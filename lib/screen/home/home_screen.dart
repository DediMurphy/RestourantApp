import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/data/api_service.dart';
import 'package:restourantapp/model/tourism_list_response.dart';
import 'package:restourantapp/provider/home/tourism_list_provider.dart';
import 'package:restourantapp/screen/home/restourant_card_widget.dart';
import 'package:restourantapp/static/navigation_route.dart';

import '../../static/tourism_list_result_state.dart';


// langkah 6 ubah home scren menjadi stateful
class HomeScreen extends StatefulWidget {
  const HomeScreen({
    super.key,
  });

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {

  @override
  void initState() {
    // TODO: implement initState
    Future.microtask(() {
      context.read<TourismListProvider>().fetchTourismList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Tourism List"),
      ),
      body:  Consumer<TourismListProvider>(
          builder: (context, value, child) {
            return switch (value.resultState) {
              TourismListLoadingState() => const Center(
                child: CircularProgressIndicator(),
              ),
              TourismListLoadedState(data: var tourismList) => ListView.builder(
                itemCount: tourismList.length,
                itemBuilder: (context, index) {
                  final tourism = tourismList[index];

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
              TourismListErrorState(error: var message) => Center(
                child: Text(message),
              ),
              _ => const SizedBox(),
            };
        }
      ),
    );
  }
}
