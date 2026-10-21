class AppUser {
 final int id;
 final String email;
 const AppUser({required this.id, required this.email});
 factory AppUser.fromMap(Map<String, Object?> map) => AppUser(id: map['id'] as int,
     email: map['email'] as String);
}
