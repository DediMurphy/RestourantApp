import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/provider/detail/bookmark_list_provider.dart';
import 'package:restourantapp/screen/home/restourant_card_widget.dart';
import 'package:restourantapp/static/navigation_route.dart';

class BookmarkScreen extends StatelessWidget {
  const BookmarkScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Bookmark List"),
      ),
      // todo-02-list-07: wrap this list with Consumer
      body: Consumer<BookmarkListProvider>(
        builder: (context, value, child) {
          // todo-02-list-08: add if-else if the list is empty
          final bookmarkList = value.bookmarkList;
          return switch (bookmarkList.isNotEmpty) {
            true => ListView.builder(
                // todo-02-list-09: dont forget to change he list value
                itemCount: bookmarkList.length,
                itemBuilder: (context, index) {
                  final tourism = bookmarkList[index];

                  return TourismCard(
                    tourism: tourism,
                    onTap: () {
                      Navigator.pushNamed(
                        context,
                        NavigationRoute.detailRoute.name,
                        arguments: tourism.id,
                      );
                    },
                  );
                },
              ),
            _ => const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("No Bookmarked"),
                  ],
                ),
              ),
          };
        },
      ),
    );
  }
}
