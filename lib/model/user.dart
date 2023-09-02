class UserSchema {
  const UserSchema({
    required this.name,
    required this.email,
    required this.uid,
    required this.profilePicUrl,
  });

  final String name, email, uid, profilePicUrl;
}
