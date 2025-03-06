class UserProfile {
  final String id;
  final String email;
  final String? firstName;
  final String? lastName;
  final String? phone;
  final String? address;
  final String? avatarUrl;

  UserProfile({
    required this.id,
    required this.email,
    this.firstName,
    this.lastName,
    this.phone,
    this.address,
    this.avatarUrl,
  });

  factory UserProfile.fromJson(Map<String, dynamic> json) => UserProfile(
    id: json['id'],
    email: json['email'],
    firstName: json['first_name'],
    lastName: json['last_name'],
    phone: json['phone'],
    address: json['address'],
    avatarUrl: json['avatar_url'],
  );
}