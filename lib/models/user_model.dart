// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:flutter/foundation.dart';

class UserModel {
  final String displayName;
  final String email;
  final String uid;
  final List<String> friends;
  final List<String> friendRequests;
  UserModel({
    required this.displayName,
    required this.email,
    required this.uid,
    required this.friends,
    required this.friendRequests,
  });

  UserModel copyWith({
    String? displayName,
    String? email,
    String? uid,
    List<String>? friends,
    List<String>? friendRequests,
  }) {
    return UserModel(
      displayName: displayName ?? this.displayName,
      email: email ?? this.email,
      uid: uid ?? this.uid,
      friends: friends ?? this.friends,
      friendRequests: friendRequests ?? this.friendRequests,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'displayName': displayName,
      'email': email,
      'uid': uid,
      'friends': friends,
      'friendRequests': friendRequests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      displayName: map['displayName'] as String,
      email: map['email'] as String,
      uid: map['uid'] as String,
      friends: List<String>.from((map['friends'] as List<String>)),
      friendRequests:
          List<String>.from((map['friendRequests'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) =>
      UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'UserModel(displayName: $displayName, email: $email, uid: $uid, friends: $friends, friendRequests: $friendRequests)';
  }

  @override
  bool operator ==(covariant UserModel other) {
    if (identical(this, other)) return true;

    return other.displayName == displayName &&
        other.email == email &&
        other.uid == uid &&
        listEquals(other.friends, friends) &&
        listEquals(other.friendRequests, friendRequests);
  }

  @override
  int get hashCode {
    return displayName.hashCode ^
        email.hashCode ^
        uid.hashCode ^
        friends.hashCode ^
        friendRequests.hashCode;
  }
}
