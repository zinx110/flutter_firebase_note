import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase_note/bloc/auth_bloc.dart';
import 'package:flutter_firebase_note/helper/keep_alive_page.dart';
import 'package:flutter_firebase_note/pages/home_page.dart';
import 'package:flutter_firebase_note/pages/notes_page.dart';
import 'package:flutter_firebase_note/pages/profile_page.dart';
import 'package:flutter_firebase_note/pages/users_page.dart';

class TabPage extends StatefulWidget {
  const TabPage({super.key});

  @override
  State<TabPage> createState() => _TabPageState();
}

class _TabPageState extends State<TabPage> with SingleTickerProviderStateMixin {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(initialPage: currentPage);
  }

  int currentPage = 0;
  List<BottomNavigationBarItem> pages = [
    const BottomNavigationBarItem(
        icon: Icon(
          Icons.home,
        ),
        label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.note), label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.people), label: ''),
    const BottomNavigationBarItem(icon: Icon(Icons.person), label: ''),
  ];

  void onPageChanged(int index) {
    setState(() {
      currentPage = index;
    });
  }

  void onTabTapped(int index) {
    _pageController.animateToPage(index,
        duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Social Flutter"),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: GestureDetector(
              child: const Text("Logout"),
              onTap: () {
                context.read<AuthBloc>().add(AuthLogoutRequested());
              },
            ),
          )
        ],
      ),
      body: PageView(
        controller: _pageController,
        onPageChanged: onPageChanged,
        children: const [
          KeepAlivePage(child: HomePage()),
          KeepAlivePage(child: NotesPage()),
          KeepAlivePage(child: UsersPage()),
          KeepAlivePage(child: ProfilePage())
        ],
      ),
      bottomNavigationBar: BottomNavigationBar(
        iconSize: 20,
        selectedFontSize: 0,
        currentIndex: currentPage,
        unselectedFontSize: 0,
        selectedItemColor: Colors.cyan,
        unselectedItemColor: Colors.grey.shade50,
        landscapeLayout: BottomNavigationBarLandscapeLayout.linear,
        type: BottomNavigationBarType.fixed,
        onTap: onTabTapped,
        items: pages,
      ),
    );
  }
}
