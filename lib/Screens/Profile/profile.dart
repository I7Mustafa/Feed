import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:line_icons/line_icons.dart';
import 'package:news_feed/models/Post.dart';
import 'package:news_feed/models/User.dart';
import 'package:provider/provider.dart';
import 'package:news_feed/Constant/constant.dart';

import 'ProfilePostTile.dart';

class Profile extends StatefulWidget {
  @override
  _ProfileState createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: forgroungColor,
      body: SafeArea(
        child: ListView(
          controller: controller,
          children: <Widget>[
            userInfo(context),
            userPosts(context),
          ],
        ),
      ),
    );
  }

  userInfo(BuildContext context) {
    final user = Provider.of<User>(context) ?? null;
    return Column(
      children: <Widget>[
        SizedBox(height: 18.0),
        Center(
          child: SizedBox(
            height: 75.0,
            width: 75.0,
            child: CircleAvatar(
              backgroundImage: NetworkImage(
                user?.photoUrl ??
                    'https://fakeimg.pl/350x200/?text=World&font=lobster',
              ),
              radius: 24.0,
            ),
          ),
        ),
        SizedBox(height: 14.0),
        Center(
          child: Text(
            user?.name ?? '',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 22.0,
              color: blackColor,
            ),
          ),
        ),
        SizedBox(height: 12.0),
        Center(
          child: Text(
            user?.email ?? '',
            style: TextStyle(
              fontWeight: FontWeight.w300,
              fontSize: 14.0,
              color: blackColor,
            ),
          ),
        ),
        SizedBox(height: 16.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12.0),
                color: backgroundColor,
              ),
              child: IconButton(
                color: Colors.green[300],
                icon: Icon(Icons.chat_bubble_outline),
                onPressed: () {
                  //TODO send message
                },
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: backgroundColor,
              ),
              child: IconButton(
                color: Colors.blueAccent,
                icon: Icon(FontAwesomeIcons.facebookSquare),
                onPressed: () {
                  // TODO open facebook app page
                },
              ),
            ),
            SizedBox(width: 20.0),
            Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(18.0),
                color: backgroundColor,
              ),
              child: IconButton(
                color: Colors.blue,
                icon: Icon(FontAwesomeIcons.linkedin),
                onPressed: () {
                  // TODO open linkedIn page
                },
              ),
            ),
          ],
        ),
      ],
    );
  }

  userPosts(BuildContext context) {
    final user = Provider.of<User>(context);
    final post = Provider.of<List<Post>>(context);
    return StreamBuilder(
      stream: Post().getPosts,
      builder: (context, snapshot) {
        return ListView.builder(
          controller: controller,
          shrinkWrap: true,
          itemCount: post.length,
          itemBuilder: (context, index) {
            return ProfilePostTile(
              post: post[index],
              user: user,
            );
          },
        );
      },
    );
  }
}
