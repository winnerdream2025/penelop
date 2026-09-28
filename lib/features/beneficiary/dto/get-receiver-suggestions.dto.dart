import 'package:json_annotation/json_annotation.dart';

part 'get-receiver-suggestions.dto.g.dart';


class DeviceContactEntry {
  final String name;
  final String phoneNumber;

  const DeviceContactEntry({required this.name, required this.phoneNumber});

  Map<String, dynamic> toJson() => {
    'name': name,
    'phoneNumber': phoneNumber,
  };

  factory DeviceContactEntry.fromJson(Map<String, dynamic> json) =>
      DeviceContactEntry(
        name: json['name'] as String,
        phoneNumber: json['phoneNumber'] as String,
      );
}

@JsonSerializable()
class GetReceiverSuggestionsDto {
  final List<DeviceContactEntry> contacts;


  GetReceiverSuggestionsDto({
    required this.contacts,
  });

  factory GetReceiverSuggestionsDto.fromJson(Map<String, dynamic> json) =>
      _$GetReceiverSuggestionsDtoFromJson(json);

  Map<String, dynamic> toJson() => _$GetReceiverSuggestionsDtoToJson(this);
}


