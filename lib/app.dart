import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tasks_status_architecture/common_components/nav_service.dart';
import 'package:tasks_status_architecture/routes/routes.dart';
import 'package:tasks_status_architecture/view_models/news_provider.dart';

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<NewsProvider>(
          create: (context) => NewsProvider(),
        ),
      ],
      child: MaterialAppClass(),
    );
  }
}

class MaterialAppClass extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'News App',
      initialRoute: SetupRoutes.initialRoute,
      routes: SetupRoutes.routes,
      navigatorKey: NavService.navKey,
      debugShowCheckedModeBanner: false,
    );
  }
}
