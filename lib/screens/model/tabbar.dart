import 'package:flutter/material.dart';
import 'package:the_buzz/screens/new_home.dart';

import '../home.dart';

class Tabbar extends StatefulWidget {
  static const String id = 'tabbar';
  const Tabbar({Key? key}) : super(key: key);

  @override
  State<Tabbar> createState() => _TabbarState();
}

class _TabbarState extends State<Tabbar> {
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const HomeScreen(),
        Padding(
          padding: const EdgeInsets.fromLTRB(0.0, 20.0, 0.0, 0.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Container(
                color: Colors.white,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Row(
                    children: [
                      const Spacer(),
                      Column(
                        children: const [Icon(Icons.home)],
                      ),
                      const Spacer()
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
