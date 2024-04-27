// To parse this JSON data, do
//
//     final allUser = allUserFromJson(jsonString);

import 'dart:convert';

AllUser allUserFromJson(String str) => AllUser.fromJson(json.decode(str));

String allUserToJson(AllUser data) => json.encode(data.toJson());

class AllUser {
  final List<User> users;

  AllUser({
    required this.users,
  });

  factory AllUser.fromJson(Map<String, dynamic> json) => AllUser(
        users: List<User>.from(json["users"].map((x) => User.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "users": List<dynamic>.from(users.map((x) => x.toJson())),
      };
}

class User {
  final int id;
  final String username;
  final String nickname;

  User({
    required this.id,
    required this.username,
    required this.nickname,
  });

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["ID"],
        username: json["Username"],
        nickname: json["Nickname"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "Username": username,
        "Nickname": nickname,
      };
}
