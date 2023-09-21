import 'package:crud_hive_demo/page/add_teacher_page.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

import '../model/teacher.dart';


class TeacherScreen extends StatefulWidget {
  const TeacherScreen({super.key});

  @override
  State<TeacherScreen> createState() => _TeacherScreenState();
}

class _TeacherScreenState extends State<TeacherScreen> {


  late Box<Teacher> teacherBox;
  @override
  void initState() {
    teacherBox = Hive.box('teachers');

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      // jadi dari sini value listenable builder akan memantau perubahan dari sebuah data di box teachernya
      // jadi pada saat menambahkan data/menghapus data/mengubah data, valuelistenable ini akan mengupdate/me refresh dengan data yang baru
      body: ValueListenableBuilder(
        valueListenable: teacherBox.listenable(),
        builder: (context, box , child) {
          return ListView.builder(
            itemCount: teacherBox.length,
            itemBuilder: ((context, index) {
              final teacher = teacherBox.getAt(index) as Teacher;

              return Card(
                child: Column(
                  children: [
                    Text(
                      teacher.id.toString(),
                    ),
                    Text(
                      teacher.name.toString(),
                    ),
                    Text(
                      teacher.age.toString(),
                    ),
                    Text(
                      teacher.subject.toString(),
                    ),
                  ],
                ),
              );
            }),
          );
        }
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) => AddTeacherScreen()));
        },
        label: Text("Add"),
        icon: Icon(Icons.add),
      ),
    );
  }
}
