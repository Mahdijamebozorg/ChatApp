class User {
  String name;
  final String id;
  String? username;
  String? bio;
  List<String>? profileUrls;

  User({
    required this.name,
    required this.id,
    this.bio,
    this.username,
    this.profileUrls,
  });
}
