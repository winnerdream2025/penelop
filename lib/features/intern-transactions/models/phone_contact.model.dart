class PhoneContact {
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final bool hasCaurisAccount;

  const PhoneContact({
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    required this.hasCaurisAccount,
  });

  String get fullName => '$firstName $lastName'.trim();

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0].toUpperCase() : '';
    final l = lastName.isNotEmpty ? lastName[0].toUpperCase() : '';
    return '$f$l';
  }

  PhoneContact copyWith({bool? hasCaurisAccount}) {
    return PhoneContact(
      firstName: firstName,
      lastName: lastName,
      phoneNumber: phoneNumber,
      hasCaurisAccount: hasCaurisAccount ?? this.hasCaurisAccount,
    );
  }
}