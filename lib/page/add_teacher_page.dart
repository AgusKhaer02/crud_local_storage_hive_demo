import 'package:crud_hive_demo/model/teacher.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AddTeacherScreen extends StatefulWidget {
  const AddTeacherScreen({super.key});

  @override
  State<AddTeacherScreen> createState() => _AddTeacherScreenState();
}

class _AddTeacherScreenState extends State<AddTeacherScreen> {
  final _key = GlobalKey<FormState>();
  int id = 0;
  String? name;
  int age = 0;
  String? subject;

  late Box<Teacher> teacherBox;

  @override
  void initState() {
    teacherBox = Hive.box("teachers");

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Teacher"),
      ),
      body: Column(
        children: [
          Form(
            key: _key,
            child: Column(
              children: [
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'ID', helperText: 'Input your ID'),
                  onSaved: (value) {
                    id = int.parse(value.toString());
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Name', helperText: 'Input your name'),
                  onSaved: (value) {
                    name = value.toString();
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.number,
                  decoration: InputDecoration(
                      labelText: 'Age', helperText: 'Input your Age'),
                  onSaved: (value) {
                    age = int.parse(value.toString());
                  },
                ),
                TextFormField(
                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                      labelText: 'Subject', helperText: 'Input your Subject'),
                  onSaved: (value) {
                    subject = value.toString();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          saveStudent();
        },
        label: Text("Save"),
        backgroundColor: Colors.green,
        icon: Icon(Icons.add),
      ),
    );
  }

  saveStudent() {
    final isValid = _key.currentState?.validate();

    if (isValid != null && isValid) {
      _key.currentState?.save();
      teacherBox.add(
        Teacher(
          id: id,
          name: name.toString(),
          age: age,
          subject: subject.toString(),
        ),
      );
    }
  }
}
