import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_note/bloc/auth_bloc.dart';
import 'package:flutter_firebase_note/models/user_model.dart';
import 'package:flutter_firebase_note/services/friend_service.dart';

class UsersPage extends StatefulWidget {
  const UsersPage({super.key});

  @override
  State<UsersPage> createState() => _UsersPageState();
}

class _UsersPageState extends State<UsersPage> {
  final TextEditingController _controller = TextEditingController();
  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  List<UserModel> searchedUsers = [];
  void setSearchedUsers(List<UserModel> arg) {
    setState(() {
      searchedUsers = arg;
    });
  }

  @override
  Widget build(BuildContext context) {
    final FriendService friendService =
        FriendService((context.read<AuthBloc>().state as AuthSuccess).uid);

    void onPressed() async {
      final users = await friendService.getFriends(_controller.text.trim());
      setSearchedUsers(users);
      if (users.isNotEmpty) {
        print(users[0].email);
      }
    }

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        children: [
          SizedBox(
            height: 40,
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    onEditingComplete: onPressed,
                    controller: _controller,
                    onChanged: (text) {
                      setState(() {});
                    },
                    style: const TextStyle(fontSize: 14),
                    decoration: InputDecoration(
                      border: border(),
                      focusedBorder: border(focused: true),
                      enabledBorder: border(),
                      hintText: 'Search a user',
                      suffixIcon: _controller.text.isNotEmpty
                          ? IconButton(
                              onPressed: () {
                                _controller.clear();
                                setState(() {});
                              },
                              icon: const Icon(
                                Icons.clear,
                                color: Colors.grey,
                              ),
                            )
                          : null,
                    ),
                  ),
                ),
                IconButton(
                  onPressed: onPressed,
                  style: IconButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.secondary,
                      minimumSize: const Size(40, 40),
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                              topRight: Radius.circular(30),
                              bottomRight: Radius.circular(30)))),
                  icon: Icon(Icons.search,
                      color: Theme.of(context).colorScheme.inversePrimary),
                )
              ],
            ),
          ),
          const Center(
            child: Text("Users page"),
          ),
        ],
      ),
    );
  }

  OutlineInputBorder border({bool focused = false}) => OutlineInputBorder(
        borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(20), bottomLeft: Radius.circular(20)),
        borderSide: BorderSide(
            color: focused == true
                ? Theme.of(context).colorScheme.primary
                : Theme.of(context).colorScheme.secondary),
      );
}
