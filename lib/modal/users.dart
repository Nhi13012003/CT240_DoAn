class UserData {
  final String id;
  late String name;
  final String email;
  final String password;

  UserData(
      {required this.password,
      required this.email,
      required this.id,
      required this.name});
}
