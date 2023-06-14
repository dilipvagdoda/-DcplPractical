class UserDetails {
  final int? id;
  final String? username;
  final String? avatarUrl;
  final String? company;
  final String? blog;
  final int? followers;
  final int? following;
  String note;

  UserDetails({
     this.id,
     this.username,
     this.avatarUrl,
     this.company,
     this.blog,
     this.followers,
     this.following,
    this.note = '',
  });
}