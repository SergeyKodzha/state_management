import 'package:flutter/material.dart';

@immutable
class User {
  final String uid;
  final String name;
  final String avatar;

  User({required this.uid, required this.name, required this.avatar});
  factory User.fromJson(Map<String, dynamic> json) =>
      User(uid: json['uid'], name: json['uid'], avatar: json['avatar']);
  Map<String, dynamic> toJson() => {uid: uid, name: name, avatar: avatar};
}
