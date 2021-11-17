import 'package:assignment8/main.dart';
import 'package:flutter/material.dart';
import 'api.dart';
import 'StudentList.dart';

class EditStudent extends StatefulWidget {
  final String id, fname, studentID, courseName, courseId;

  final API api = API();

  EditStudent(this.id, this.fname, this.studentID, this.courseName, this.courseId);

  @override
  _EditStudentState createState() => _EditStudentState(id, fname, studentID, courseName, courseId);
}

class _EditStudentState extends State<EditStudent> {
  
  final String id, fname, studentID, courseName, courseId;
  
  _EditStudentState(this.id, this.fname, this.studentID, this.courseName, this.courseId);

  void _changeFName(id, newName) {
    setState(() {
      widget.api.editStudent(id, newName);
      Navigator.pop(context);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => StudentList(
                                                widget.courseId,
                                                widget.courseName)));
    });
  }

  TextEditingController nameCont = TextEditingController();

  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.studentID,
          style: TextStyle(fontSize: 25),
        ),
      ),
      body: Center(
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                children: <Widget>[
                  Text(
                    "Enter a new first name for student: " + widget.studentID,
                    style: TextStyle(fontSize: 20),
                  ),
                  TextFormField(
                    keyboardType: TextInputType.number,
                    controller: nameCont,
                  ),
                  ElevatedButton(
                      onPressed: () => {
                            _changeFName(widget.id, nameCont.text),
                          },
                      child: Text("Change First Name")),
                ],
              ),
            )
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
          child: Icon(Icons.home),
          onPressed: () => {
                Navigator.pop(context),
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) =>MyHomePage())),
              }),
    );
  }
}