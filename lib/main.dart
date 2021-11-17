import 'package:flutter/material.dart';
import 'api.dart';

import 'StudentList.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Courses App',
      theme: ThemeData(
        primarySwatch: Colors.cyan,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  final API api = API();

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List courses = [];
  bool _dbLoaded = false;

  void initState() {
    super.initState();

    widget.api.getCourses().then((data) {
      setState(() {
        courses = data;
        courses.sort((a, b) => a['courseName'].toString().compareTo(b['courseName'].toString()));
        _dbLoaded = true;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Assignment 8: Courses App"),
      ),
      body: Center(
          child: _dbLoaded
              ? Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: <Widget>[
                    Padding(padding: const EdgeInsets.all(15.0)),
                    Text(
                      "  Class Name        |     Instructor     |  Credits",
                      style: TextStyle(fontSize: 20),
                    ),
                    Expanded(
                      child: ListView(
                        children: [
                          ...courses.map<Widget>((course) => Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: ElevatedButton(
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: const Size(170, 50),
                                      ),
                                      child: Text(course['courseName'],
                                          style: TextStyle(fontSize: 12)),
                                      onPressed: () => {
                                        showDialog(
                                            context: context,
                                            builder: (context) => StudentList(
                                                course['_id'],
                                                course['courseName'])),
                                      },
                                    ),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Text(course['instructorName'],
                                        style: TextStyle(fontSize: 15)),
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(25.0),
                                    child: Text(course['courseCredits'],
                                        style: TextStyle(fontSize: 20)),
                                  )
                                ],
                              )),
                        ],
                      ),
                    )
                  ],
                )
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(
                      "Database Loading",
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                    ),
                    CircularProgressIndicator()
                  ],
                )),
    );
  }
}
