class User {
  final String id;
  String name;
  DateTime lastSeen;
  String username;
  String bio;
  List<String> profileUrls;

  User({
    required this.id,
    required this.name,
    required this.lastSeen,
    required this.bio,
    required this.username,
    required this.profileUrls,
  });
}
