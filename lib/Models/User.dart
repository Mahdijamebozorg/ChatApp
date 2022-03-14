class User {
  String name;
  final String id;
  final DateTime lastSeen;
  String username;
  String bio;
  List<String> profileUrls;

  User({
    required this.name,
    required this.id,
    required this.lastSeen,
    required this.bio,
    required this.username,
    required this.profileUrls,
  });
}
