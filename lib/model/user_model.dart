class User {
  String? name;
  String? email;
  String? role;
  String? uid;

  User({this.name, this.email, this.role, this.uid});

  Map<String, dynamic> toJson() {
    return {'name': name, 'email': email, 'role': role, 'uid': uid};
  }

  static User fromJson(Map<String, dynamic> json) {
    return User(
        name: json['name'],
        email: json['email'],
        role: json['role'],
        uid: json['uid']);
  }
}
