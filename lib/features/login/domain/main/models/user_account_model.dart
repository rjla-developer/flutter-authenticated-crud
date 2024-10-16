class UserAccountModel {
  final String id;
  final String email;
  final String fullName;
  final List<String> roles;
  final String token;

  UserAccountModel({
    required this.id,
    required this.email,
    required this.fullName,
    required this.roles,
    required this.token,
  });

  bool get isAdmin => roles.contains('admin');
}
