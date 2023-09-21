import 'package:crud_hive_demo/model/student.dart';
import 'package:crud_hive_demo/model/teacher.dart';
import 'package:crud_hive_demo/page/bank_page.dart';
import 'package:crud_hive_demo/page/home_page.dart';
import 'package:crud_hive_demo/page/student_page.dart';
import 'package:crud_hive_demo/page/teacher_page.dart';
import 'package:flutter/material.dart';
import 'package:path_provider/path_provider.dart' as path;
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';

void main() async {
  // jika bekerja dengan asynchronous, pastikan widget berjalan
  // proses ini menjembatani antara dart layer dengan flutter engine
  // sebagai contoh proses getApplicationDocumentsDirectory
  // ini akan membutuhkan interaksi antara flutter engine dengan kode nativenya,
  WidgetsFlutterBinding.ensureInitialized();
  // ini directory local pada document di storage/penyimpanan internal HP nya
  final dir = await path.getApplicationDocumentsDirectory();
  Hive.init(dir.path);
  // subdirectory dari sebuah box
  Hive.initFlutter('hive_db');

  // register dulu untuk data modelnya untuk Student
  Hive.registerAdapter<Student>(StudentAdapter());
  Hive.registerAdapter<Teacher>(TeacherAdapter());
  // membuat box dari home, sama seperti membuka tabel
  await Hive.openBox("home");
  // kemudian buka nilai Students yang dengan model Students
  await Hive.openBox<Student>("students");
  await Hive.openBox<Teacher>("teachers");

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const HomeScreen(),
    );
  }
}

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int index = 0;

  final pages = [
    const HomeSubcreen(),
    const StudentScreen(),
    const TeacherScreen(),
    const BankScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: pages[index],
      bottomNavigationBar: Container(
        color: Colors.orange,
        child: BottomNavigationBar(
          currentIndex: index,
          backgroundColor: Colors.teal,
          fixedColor: Colors.teal,
          onTap: (value) {
            setState(() {
              index = value;
            });
          },
          items: [
            BottomNavigationBarItem(icon: Icon(Icons.home), label: "Home"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Student"),
            BottomNavigationBarItem(icon: Icon(Icons.person), label: "Teacher"),
            BottomNavigationBarItem(icon: Icon(Icons.money), label: "Bank"),
          ],
        ),
      ),
    );
  }
}
