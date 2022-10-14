import 'package:flutter/material.dart';
import 'package:the_buzz/screens/home.dart';
import 'package:the_buzz/screens/model/tabbar.dart';
import 'package:the_buzz/screens/new_home.dart';
import 'package:the_buzz/screens/new_post.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MaterialApp(
        initialRoute: HomeScreen.id,
        routes: {
          NewHome.id: (context) => const NewHome(),
          Tabbar.id: (context) => const Tabbar(),
          HomeScreen.id: (context) => const HomeScreen(),
          NewPost.id: (context) => const NewPost(),
        },
      ),
    );
  }
}
