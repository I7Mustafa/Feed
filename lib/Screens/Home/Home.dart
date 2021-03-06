import 'package:flutter/material.dart';
import 'package:news_feed/Auth/auth.dart';
import 'package:news_feed/screens/home/posts_list.dart';
import 'package:news_feed/Screens/Settings/Settings.dart';
import 'package:news_feed/models/pop_up_menu.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Auth auth = Auth();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0.0,
        title: Text('Discovery'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: select,
            itemBuilder: (context) {
              return PopUpMenu.choices.map((String choice) {
                return PopupMenuItem(
                  child: Text(choice),
                  value: choice,
                );
              }).toList();
            },
          ),
        ],
      ),
      body: PostsList(),
    );
  }

  void select(String choice) {
    if (choice == PopUpMenu.settings) {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Settings(),
        ),
      );
    } else if (choice == PopUpMenu.signOut) {
      auth.signOutGoogle(context);
    }
  }
}
