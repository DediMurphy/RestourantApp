import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/provider/index_nav_provider.dart';
import 'package:restourantapp/screen/bookmark/bookmark_screen.dart';
import 'package:restourantapp/screen/home/home_screen.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // todo-01-main-08: use Consumer to build the screen
      body: Consumer<IndexNavProvider>(
        builder: (context, value, child) {
          return switch (value.indexBottomNavBar) {
            0 => const HomeScreen(),
            _ => const BookmarkScreen()
          };
        },
      ),
      bottomNavigationBar: BottomNavigationBar(
          currentIndex: context.watch<IndexNavProvider>().indexBottomNavBar,
          onTap: (index) {
            context.read<IndexNavProvider>().setIndextBottomNavBar = index;
          },
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.home), label: "Home", tooltip: "Home"),
            BottomNavigationBarItem(
                icon: Icon(Icons.bookmark),
                label: "Bookmark",
                tooltip: "Bookmark"),
          ]),
    );
  }
}
