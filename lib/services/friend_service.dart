import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase_note/models/user_model.dart';

class FriendService {
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');
  final CollectionReference friends =
      FirebaseFirestore.instance.collection('users');
  final String userId;

  FriendService(this.userId);
  Future<List<UserModel>> getUsers(String name) async {
    try {
      final usersSnapshot =
          await users.where('displayName', isEqualTo: name).limit(5).get();
      print("");
      if (usersSnapshot.size == 0) return [];
      final usersData =
          usersSnapshot.docs.map((userdoc) => userdoc.data() as UserModel);
      return usersData.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<UserModel>> getFriends(String name) async {
    try {
      final usersSnapshot = await users
          .where('name', isGreaterThanOrEqualTo: name)
          .limit(5)
          .get();
      if (usersSnapshot.size == 0) return [];
      final usersData =
          usersSnapshot.docs.map((userdoc) => userdoc.data() as UserModel);
      return usersData.toList();
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
