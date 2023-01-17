import 'package:flutter/material.dart';
import 'package:todoapp2/goster.dart';
import 'package:todoapp2/savetextpage.dart';
class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}




class _DefaultPageState extends State<DefaultPage> {
  int _selectedIndex = 0 ;
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<StatefulWidget> _widget = <StatefulWidget>[
    SaveTextPage(),
    TextListPage()
  ];


  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(body:Center(child: _widget.elementAt(_selectedIndex)) ,
    bottomNavigationBar: BottomNavigationBar(items: [
      BottomNavigationBarItem(icon: Icon(Icons.adb),label: "sdf"),
      BottomNavigationBarItem(icon: Icon(Icons.ad_units),label: "sdfdsf")

    ],currentIndex:_selectedIndex,onTap: _onItemTapped, ),);
  }
}
