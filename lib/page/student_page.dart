import 'package:crud_hive_demo/model/student.dart';
import 'package:crud_hive_demo/page/add_student_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class StudentScreen extends StatefulWidget {
  const StudentScreen({super.key});

  @override
  State<StudentScreen> createState() => _StudentScreenState();
}

class _StudentScreenState extends State<StudentScreen> {
  late Box<Student> studentBox;

  @override
  void initState() {
    studentBox = Hive.box("students");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        itemCount: studentBox.length,
        itemBuilder: ((context, index) {
          final student = studentBox.getAt(index) as Student;

          return Card(
            child: Column(
              children: [
                Text(
                  student.id.toString(),
                ),
                Text(
                  student.name.toString(),
                ),
                Text(
                  student.age.toString(),
                ),
                Text(
                  student.subject.toString(),
                ),
              ],
            ),
          );
        }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
            Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddStudentScreen()));
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
