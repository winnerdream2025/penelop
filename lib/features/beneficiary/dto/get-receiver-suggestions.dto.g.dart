// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'get-receiver-suggestions.dto.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

GetReceiverSuggestionsDto _$GetReceiverSuggestionsDtoFromJson(
  Map<String, dynamic> json,
) => GetReceiverSuggestionsDto(
  contacts: (json['contacts'] as List<dynamic>)
      .map((e) => DeviceContactEntry.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$GetReceiverSuggestionsDtoToJson(
  GetReceiverSuggestionsDto instance,
) => <String, dynamic>{'contacts': instance.contacts};
