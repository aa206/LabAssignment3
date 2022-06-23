import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mytutor/views/favoritescreen.dart';
import 'package:mytutor/views/loginscreen.dart';
import 'package:mytutor/views/profilescreen.dart';
import 'package:mytutor/views/registerscreen.dart';
import 'package:mytutor/views/subscribescreen.dart';
import 'package:mytutor/views/tutorsscreen.dart';
import 'package:mytutor/views/coursesscreen.dart';
import 'package:http/http.dart' as http;
import '../models/courses.dart';
import '/models/user.dart';

class MainScreen extends StatefulWidget {
  final User user;
  const MainScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();

}

class _MainScreenState extends State<MainScreen> {
  late List<Widget> _pages;
  
  @override
  void initState(){
    _pages =<Widget>[
      CoursesScreen(user: widget.user),
      TutorsScreen(user: widget.user),
      SubscribeScreen(user: widget.user),
      FavoriteScreen(user: widget.user),
      ProfileScreen(user: widget.user),
    ];
  }
  
 int _selectedIndex = 0;
  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('MY Tutor'),
        ),
        drawer: Drawer(
          child: ListView(
            children: [
              UserAccountsDrawerHeader(
                accountName: Text(widget.user.name.toString()),
                accountEmail: Text(widget.user.email.toString()),
                currentAccountPicture: CircleAvatar(
                  backgroundImage: NetworkImage(
                    "https://static.wikia.nocookie.net/line/images/b/bb/2015-brown.png/revision/latest?cb=20150808131630")),
                ),
              _createDrawerItem(
                icon: Icons.person,
                text: 'My Profile',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => MainScreen(
                              user: widget.user,
                            )));
                },
              ),
              _createDrawerItem(
                icon: Icons.folder,
                text: 'My Subjects',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => CoursesScreen(user: widget.user,
                            )));
                },
              ),
              _createDrawerItem(
                icon: Icons.book,
                text: 'My Tutor Class',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => TutorsScreen(user: widget.user,
                            )));
                },
              ),
              _createDrawerItem(
                icon: Icons.save,
                text: 'My Subscribe',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.favorite,
                text: 'My Favourite',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.settings,
                text: 'Setting',
                onTap: () {},
              ),
              _createDrawerItem(
                icon: Icons.settings,
                text: 'Log Out',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => LoginScreen(
                            )));},
              ),
            ],
            ),
        ),
        body: Center(
            child: _pages.elementAt(_selectedIndex),
          
        ),
        bottomNavigationBar: BottomNavigationBar(
          items: const <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: Icon(Icons.folder),
              label: 'Subjects',
              backgroundColor: Colors.grey,
              
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.book),
              label: 'Tutors',
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.save),
              label: 'Subscribe',
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.favorite),
              label: 'Favourite',
              backgroundColor: Colors.grey,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Profile',
              backgroundColor: Colors.grey,
            ),
          ],
          currentIndex: _selectedIndex,
          selectedItemColor: Colors.pink,
          onTap: _onItemTapped,
        ),
    );
  }
  
  Widget _createDrawerItem(
      {
      required IconData icon,
      required String text,
      required GestureTapCallback onTap
      }) 
      
      {
      return ListTile(
        title: Row
        (children: <Widget>[
          Icon(icon),
          Padding(
            padding: EdgeInsets.only(left: 8.0),
            child: Text(text),
            )
    ],
    ),
    onTap: onTap,
  );

    }
    
}

