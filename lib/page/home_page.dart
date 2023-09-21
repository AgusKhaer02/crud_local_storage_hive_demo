import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';


class HomeSubcreen extends StatefulWidget {
  const HomeSubcreen({super.key});

  @override
  State<HomeSubcreen> createState() => _HomeSubcreenState();
}

class _HomeSubcreenState extends State<HomeSubcreen> {
  late Box homeBox;

  @override
  void initState() {
    // buka box home
    homeBox = Hive.box('home');
    homeBox.put("1", "David");
    homeBox.put("2", "Ham");
    homeBox.put("3", "Soap");
    homeBox.putAll({
      "4": "John Price",
      "5": "Sam Fisher",
      "6": "Richard",
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(homeBox.get("1")),
        Text(homeBox.get("2")),
        Text(homeBox.get("3")),
        Text(homeBox.get("4")),
        Text(homeBox.get("5")),
        Text(homeBox.get("6")),
      ],
    );
  }
}
