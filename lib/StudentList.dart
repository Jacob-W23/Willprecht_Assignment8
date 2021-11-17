import 'package:flutter/material.dart';
import 'api.dart';
import 'main.dart';
import 'editStudent.dart';

class StudentList extends StatefulWidget {
  final String id, courseName;

  final API api = API();

  StudentList(this.id, this.courseName);

  @override
  _StudentListState createState() => _StudentListState(id, courseName);
}

class _StudentListState extends State<StudentList> {

  List students = [];
  bool _dbLoaded = false;

  void initState()  {
    super.initState();

    widget.api.getStudents().then((data) {
      setState(() {
        students = data;
        students.sort((a, b) => a['lname'].toString().compareTo(b['lname'].toString()));
        _dbLoaded = true;
      });
    });
  }

  final String id, courseName;

  _StudentListState(this.id, this.courseName);

  void _deleteCourse(id) {
    setState(() {
      widget.api.deleteCourse(id);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => MyHomePage()));
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.courseName),
      ),
      body: Center(
        child: _dbLoaded 
                ? Column(
                  children: [
                    Padding(padding: const EdgeInsets.all(15.0)),
                    ElevatedButton(onPressed: ()=> {
                      _deleteCourse(id)}, child: Text("Delete Course")),
                      Padding(padding: const EdgeInsets.all(10.0)),
                      Text("Student List:",
                      style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                    Expanded(
                      child: ListView(
                          shrinkWrap: true,
                          padding: EdgeInsets.all(15.0),
                          children: [
                            ...students
                                .map<Widget>(
                                  (student) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 8),
                                    child: TextButton(
                                      onPressed: () => {
                                        Navigator.pop(context),
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) => EditStudent(
                                                                      student['_id'],
                                                                      student['fname'],
                                                                      student['studentID'],
                                                                      widget.courseName,
                                                                      widget.id))),
                                      },
                                      child: ListTile(
                                        title: Text(
                                          (student['fname'] + ' ' +
                                          student['lname'] + ' - Click to edit'),
                                          textAlign: TextAlign.center,
                                          style: TextStyle(fontSize: 20),
                                        ),
                                      ),
                                    ),
                                  ),
                                )
                                .toList(),
                          ]),
                    ),
                  ],
                )
        :Column(
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
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.home),
        onPressed: () => {
          Navigator.pop(context),
          Navigator.push(context, MaterialPageRoute(builder: (context) => MyHomePage())),
        },
      ),
    );
  }
}