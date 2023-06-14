class User {
  final int id;
  final String username;
  final String avatarUrl;
  String note;

  User({
    required this.id,
    required this.username,
    required this.avatarUrl,
    this.note = '',
  });

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'username': username,
      'avatarUrl': avatarUrl,
      'note': note,
    };
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      username: map['username'],
      avatarUrl: map['avatarUrl'],
      note: map['note'],
    );
  }
}