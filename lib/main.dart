import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restourantapp/data/api_service.dart';
import 'package:restourantapp/provider/detail/bookmark_list_provider.dart';
import 'package:restourantapp/provider/detail/tourism_detail_provider.dart';
import 'package:restourantapp/provider/home/tourism_list_provider.dart';
import 'package:restourantapp/provider/index_nav_provider.dart';
import 'package:restourantapp/screen/detail/detail_screen.dart';
import 'package:restourantapp/screen/main/main_screen.dart';
import 'package:restourantapp/static/navigation_route.dart';
import 'package:restourantapp/style/theme/tourism_theme.dart';

void main() {
 runApp(
   MultiProvider(
     providers: [
       ChangeNotifierProvider(
         create: (context) => IndexNavProvider(),
       ),
       ChangeNotifierProvider(
         create: (context) => BookmarkListProvider(),
       ),
       Provider(
           create: (context) => ApiServices()
       ),
       ChangeNotifierProvider(
           create: (context) => TourismListProvider(
             context.read<ApiServices>(),
           )
       ),
       ChangeNotifierProvider(
           create: (context) => TourismDetailProvider(
             context.read<ApiServices>(),
           )
       )
     ],
     child: const MyApp(),
   ),
 );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: TourismTheme.lightTheme,
      darkTheme: TourismTheme.darkTheme,
      themeMode: ThemeMode.system,
      initialRoute: NavigationRoute.mainRoute.name,
      routes: {
        NavigationRoute.mainRoute.name: (context) => const MainScreen(),
        NavigationRoute.detailRoute.name: (context) => DetailScreen(
              tourismId: ModalRoute.of(context)?.settings.arguments as int,
            )
      },
    );
  }
}
