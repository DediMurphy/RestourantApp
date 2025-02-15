
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restourantapp/screen/home/restourant_card_widget.dart';
import 'package:restourantapp/static/navigation_route.dart';

import '../../model/tourism.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      body: ListView.builder(
        itemCount: tourismList.length,
        itemBuilder: (context, index) {
          final tourism = tourismList[index];

          return TourismCard(
            tourism: tourism,
            onTap: () {
              Navigator.pushNamed(
                context,
                NavigationRoute.detailRoute.name,
                arguments: tourism
              );
            },
          );
        },
      ),
    );
  }
}
