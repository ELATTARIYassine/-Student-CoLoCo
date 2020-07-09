import 'package:flutter/material.dart';
import 'package:flutter_exam/notifier/demand_notifier.dart';
import 'package:flutter_exam/screens/feed.dart';
import 'package:flutter_exam/screens/login.dart';
import 'package:provider/provider.dart';
import 'notifier/auth_notifier.dart';
import 'notifier/housing_notifier.dart';

void main() => runApp(MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => AuthNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => HousingNotifier(),
        ),
        ChangeNotifierProvider(
          create: (context) => DemandNotifier(),
        )
      ],
      child: MyApp(),
    ));

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Student coloco',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.lightBlue,
      ),
      home: Consumer<AuthNotifier>(
        builder: (context, notifier, child) {
          return notifier.user != null ? Feed() : Login();
        },
      ),
    );
  }
}
