class Course {
  final String id;
  final String instructorName;
  final String courseCredits;
  final String courseID;
  final String courseName;

  Course._(this.id,this.instructorName,this.courseCredits,this.courseID,this.courseName);

  factory Course.fromJson(Map json) {
    final id = json[''].replaceAll('ObjectId(\"', '').replaceAll('\")', '');
    final instructorName = json['instructorName'];
    final courseCredits = json['courseCredits'];
    final courseID = json['courseID'];
    final courseName = json['courseName'];

    return Course._(id,instructorName,courseCredits,courseID,courseName);
  }
}