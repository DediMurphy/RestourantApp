import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/provider/detail/bookmark_icon_provider.dart';
import 'package:restourantapp/provider/detail/tourism_detail_provider.dart';
import 'package:restourantapp/screen/detail/body_of_detail_screen_widget.dart';
import 'package:restourantapp/screen/detail/bookmark_icon_widget.dart';

import '../../static/tourism_detail_result_state.dart';

// todo-04-detail-05: make this widget StatefulWidget
class DetailScreen extends StatefulWidget {
  // todo-04-detail-04: you can change this parameter into int value
  final int tourismId;

  const DetailScreen({
    super.key,
    required this.tourismId,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  // todo-04-detail-07: initialize a Future in initState
  @override
  void initState() {
    super.initState();

    Future.microtask(() {
      context.read<TourismDetailProvider>().fetchToursmDetail(widget.tourismId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism Detail"),
        actions: [
          ChangeNotifierProvider(
              create: (context) => BookmarkIconProvider(),
              // todo-04-detail-11: change this widget using FutureBuilder
              child: Consumer<TourismDetailProvider>(
                  builder: (context, value, child) {
                return switch (value.resultState) {
                  TourismDetailLoadedState(data: var tourism) =>
                    BookmarkIconWidget(tourism: tourism),
                  _ => const SizedBox(),
                };
              })
          ),
        ],
      ),
      // todo-04-detail-08: to make it easy, create a new widget below
      // todo-04-detail-09: create a FutureBuilder
      body: Consumer<TourismDetailProvider>(
        builder: (context, value, child) {
          return switch (value.resultState) {
            TourismDetailLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
            TourismDetailLoadedState(data: var tourism) =>
              BodyOfDetailScreenWidget(tourism: tourism),
            TourismDetailErrorState(error: var message) => Center(
                child: Text(message),
              ),
            _ => const SizedBox(),
          };
        },
      ),
    );
  }
}
