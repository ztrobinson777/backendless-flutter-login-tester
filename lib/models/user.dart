class User {
  String objectId;
  String email;
  String phone;

  User({required this.objectId, required this.email, required this.phone});

  factory User.fromJson(Map<String, dynamic> data) {
    return User(
      objectId: data["objectId"]!,
      email: data["email"]!,
      phone: data["phone"]!,
    );
  }

  factory User.fromUserData(Map<dynamic, dynamic> data) {
    return User(
      objectId: data["objectId"]!,
      email: data["email"]!,
      phone: data["phone"]!
    );
  }
}