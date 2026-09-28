import 'dart:async';

import 'package:corrispay/app/utils/localkeys.dart';
import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:get_storage/get_storage.dart';

import '../dto/get-receiver-suggestions.dto.dart';

class DeviceContactsRepository {
  final GetStorage _box;

  // TTL réduit à 1h, en filet de sécurité seulement — le vrai mécanisme
  // d'invalidation est le listener natif (voir startListeningForChanges),
  // qui vide le cache dès qu'un contact est ajouté/modifié/supprimé.
  static const Duration _cacheTtl = Duration(hours: 1);

  StreamSubscription<void>? _subscription;

  DeviceContactsRepository(this._box);

  /// À appeler UNE SEULE FOIS au démarrage de l'app (ex: dans main.dart
  /// ou un provider racine), pas à chaque ouverture de l'écran destinataire.
  /// Écoute les changements natifs du répertoire (ajout/suppression/
  /// modification d'un contact) et invalide immédiatement le cache local
  /// dès qu'un changement est détecté, pour que le prochain appel à
  /// getContactEntries() relise le répertoire à jour.
  void startListeningForChanges() {
    if (_subscription != null) return; // évite d'enregistrer plusieurs fois
    _subscription = FlutterContacts.onDatabaseChange.listen((_) => clearCache());
  }

  void stopListeningForChanges() {
    _subscription?.cancel();
    _subscription = null;
  }

  /// Demande la permission (déclenche la popup système si pas encore
  /// décidée), puis lit les contacts et renvoie, pour chaque numéro au
  /// format global valide, le nom tel qu'enregistré dans le répertoire
  /// de l'utilisateur (ex: "Tonton Koffi") associé à ce numéro.
  ///
  /// Utilise le cache local tant qu'aucun changement n'a été détecté par
  /// le listener natif et que le TTL de secours (1h) n'est pas dépassé.
  Future<List<DeviceContactEntry>> getContactEntries({
    bool forceRefresh = false,
  }) async {
    if (!forceRefresh) {
      final cached = _readCache();
      if (cached != null) return cached;
    }

    final status = await FlutterContacts.permissions.request(PermissionType.read);
    if (status != PermissionStatus.granted) return [];

    final contacts = await FlutterContacts.getAll(properties: {ContactProperty.phone});

    // Dédoublonnage par numéro normalisé : si le même numéro apparaît sous
    // plusieurs contacts/noms, on garde la première occurrence rencontrée.
    final entriesByNumber = <String, DeviceContactEntry>{};

    for (final contact in contacts) {
      final name = contact.displayName?.trim() ?? '';
      if (name.isEmpty) continue;

      for (final phone in contact.phones) {
        final normalized = _extractGlobalFormat(phone.number);
        if (normalized == null) continue;
        entriesByNumber.putIfAbsent(
          normalized,
              () => DeviceContactEntry(name: name, phoneNumber: normalized),
        );
      }
    }

    final result = entriesByNumber.values.toList();
    _writeCache(result);
    return result;
  }

  /// Garde uniquement les numéros qui ressemblent à un format global
  /// (indicatif pays inclus) — même règle que côté backend (DTO):
  /// avec ou sans "+", 8 à 15 chiffres après nettoyage des espaces/tirets.
  String? _extractGlobalFormat(String raw) {
    final cleaned = raw.replaceAll(RegExp(r'[\s\-().]'), '');
    final isValid = RegExp(r'^\+?\d{8,15}$').hasMatch(cleaned);
    return isValid ? cleaned : null;
  }

  List<DeviceContactEntry>? _readCache() {
    final cachedAt = _box.read(LocalKeys.contactsCachedAt);
    final cached = _box.read(LocalKeys.contactsPhoneNumbers);
    if (cachedAt == null || cached == null) return null;

    final age = DateTime.now().difference(DateTime.parse(cachedAt));
    if (age > _cacheTtl) return null;

    // Défensif : si le format stocké ne correspond plus au modèle actuel
    // (ex: ancien cache d'une version précédente du modèle), on traite
    // le cache comme absent plutôt que de planter — force un re-scan
    // propre au lieu d'une erreur silencieuse.
    try {
      return (cached as List)
          .map(
            (e) => DeviceContactEntry.fromJson(Map<String, dynamic>.from(e)),
      )
          .toList();
    } catch (_) {
      _box.remove(LocalKeys.contactsPhoneNumbers);
      _box.remove(LocalKeys.contactsCachedAt);
      return null;
    }
  }

  void _writeCache(List<DeviceContactEntry> entries) {
    _box.write(
      LocalKeys.contactsPhoneNumbers,
      entries.map((e) => e.toJson()).toList(),
    );
    _box.write(LocalKeys.contactsCachedAt, DateTime.now().toIso8601String());
  }

  void clearCache() {
    _box.remove(LocalKeys.contactsPhoneNumbers);
    _box.remove(LocalKeys.contactsCachedAt);
  }
}