import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mytutor/views/favoritescreen.dart';
import 'package:mytutor/views/loginscreen.dart';
import 'package:mytutor/views/mainscreen.dart';
import 'package:mytutor/views/subscribescreen.dart';
import 'package:mytutor/views/tutorsscreen.dart';
import 'package:http/http.dart' as http;
import '../models/user.dart';
import '../models/courses.dart';

class CoursesScreen extends StatefulWidget {
  final User user;
  const CoursesScreen({Key? key, required this.user}) : super(key: key);

  @override
  State<CoursesScreen> createState() => _CoursesScreenState();
}

class _CoursesScreenState extends State<CoursesScreen> {
  List<Subject>? subjectList = <Subject>[];
  String titlecenter = 'No Subjects Available';
  var numofpage, curpage = 1;

  TextEditingController searchController = TextEditingController();
  String search = "";
  String dropdownvalue = 'Programming 101';
  var types = [
    'All',
    'Programming 101',
    'Programming 201',
    'Introduction to Web programming',
    'Web programming advanced',
    'Python for Everybody',
    'Introduction to Computer Science',
    'Code Yourself! An Introduction to Programming',
    'IBM Full Stack Software Developer Professional Certificate',
    'Graphic Design Specialization',
    'Fundamentals of Graphic Design',
    'Fundamentals of Graphic Design',
    'Full-Stack Web Development with React',
    'Software Design and Architecture',
    'Software Testing and Automation',
    'Introduction to Cyber Security',
  ];

  @override
  void initState() {
    super.initState();
   _loadSubjects(1, search);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Subjects'),
          actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              _loadSearchDialog();
            },
          )
        ],
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
                        builder: (content) => CoursesScreen(
                          user: widget.user,
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
                        builder: (content) => LoginScreen(
                            )));
                },
              ),
              _createDrawerItem(
                icon: Icons.save,
                text: 'My Subscribe',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => SubscribeScreen(
                          user: widget.user,
                            )));
                },
              ),
              _createDrawerItem(
                icon: Icons.favorite,
                text: 'My Favourite',
                onTap: () {
                  Navigator.pop(context);
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (content) => FavoriteScreen(
                          user: widget.user,
                            )));
                },
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
        body: subjectList!.isEmpty
          ? Padding(
              padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
              child: Column(
                children: [
                  Center(
                      child: Text(titlecenter,
                          style: const TextStyle(
                              fontSize: 18, fontWeight: FontWeight.bold))),
                  SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: types.map((String char) {
                        return Padding(
                          padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                          child: ElevatedButton(
                            child: Text(char),
                            onPressed: () {
                              _loadSubjects(1, search);
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ],
              ),
            )
          : Column(children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(0, 10, 0, 0),
                child: Text(titlecenter,
                    style: const TextStyle(
                        fontSize: 18, fontWeight: FontWeight.bold)),
              ),
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: types.map((String char) {
                    return Padding(
                      padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
                      child: ElevatedButton(
                        child: Text(char),
                        onPressed: () {
                          _loadSubjects(1, search);
                        },
                      ),
                    );
                  }).toList(),
                ),
              ),
              Expanded(
                  child: GridView.count(
                    crossAxisCount: 2,
                      children: List.generate(subjectList!.length, (index) {
                        return Card(
                          child: Column(
                            children: [
                              Flexible(
                                flex: 6,
                                child: CachedNetworkImage(
                                  imageUrl: "http://10.143.159.53/mytutor3/assets/courses/" +
                                      subjectList![index].subjectId.toString() +
                                      '.jpg',
                                  fit: BoxFit.cover,
                                  placeholder: (context, url) =>
                                      const LinearProgressIndicator(),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                ),
                              ),
                                Flexible(
                                  flex: 4,
                                  child: Column(
                                    children: [
                                      Text(
                                        subjectList![index]
                                            .subjectName
                                            .toString(),
                                            style: const TextStyle(
                                            fontSize: 16,
                                            fontWeight: FontWeight.bold),),
                                      Text("RM " +
                                          double.parse(subjectList![index]
                                                  .subjectPrice
                                                  .toString())
                                              .toStringAsFixed(2)),
                                      Text(subjectList![index]
                                              .subjectDesc
                                              .toString()),
                                      Text(subjectList![index]
                                          .subjectSessions
                                          .toString() +
                                          " time of sessions"),
                                  ],
                              ))
                            ],
                          ));
                        })
                        )
                        )
                        ],
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
  
}     void _loadSubjects(int pageno, String _search) {
        curpage = pageno;
        numofpage ?? 1;
        http.post(Uri.parse("http://10.143.166.152/mytutor2/php/loadcourses.php"),
            body: {
              'pageno': pageno.toString(),
              'search': _search,
              }).timeout(
            const Duration(seconds: 5),
            onTimeout: () {
            return http.Response(
            'Error', 408); // Request Timeout response status code
      },).then((response) {
          var jsondata = jsonDecode(response.body);
          if (response.statusCode == 200 && jsondata['status'] == 'success') {
          var extractdata = jsondata['data'];
          subjectList = <Subject>[];
          extractdata['subjects'].forEach((v) {
            subjectList!.add(Subject.fromJson(v));
          });
          
          }
        });
  }
  void _loadSearchDialog() {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          // return object of type Dialog
          return StatefulBuilder(
            builder: (context, StateSetter setState) {
              return AlertDialog(
                title: const Text(
                  "Search ",
                ),
                content: SizedBox(
                  //height: screenHeight / 3,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      TextField(
                        controller: searchController,
                        decoration: InputDecoration(
                            labelText: 'Search',
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(5.0))),
                      ),
                    
                    ],
                  ),
                ),
                actions: [
                  ElevatedButton(
                    onPressed: () {
                      search = searchController.text;
                      Navigator.of(context).pop();
                      _loadSubjects(1, search);
                    },
                    child: const Text("Search"),
                  )
                ],
              );
            },
          );
        });
  }
}