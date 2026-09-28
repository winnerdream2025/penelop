// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'transaction.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  statut: json['statut'] as String,
  type: json['type'] as String,
  name: json['name'] as String,
  montant: (json['montant'] as num).toDouble(),
  date: DateTime.parse(json['date'] as String),
  reference: json['reference'] as String,
  isSent: json['isSent'] as bool,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'date': instance.date.toIso8601String(),
      'statut': instance.statut,
      'type': instance.type,
      'name': instance.name,
      'montant': instance.montant,
      'reference': instance.reference,
      'isSent': instance.isSent,
    };
