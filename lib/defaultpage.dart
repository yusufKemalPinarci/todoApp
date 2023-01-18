import 'package:flutter/material.dart';
import 'package:todoapp2/goster.dart';
import 'package:todoapp2/profilim.dart';
import 'package:todoapp2/savetextpage.dart';
class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}




class _DefaultPageState extends State<DefaultPage> {
  int _selectedIndex = 1 ;
  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  static const TextStyle optionStyle = TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<StatefulWidget> _widget = <StatefulWidget>[
    TextListPage(),
    TextListPage(),
    SaveTextPage(),
    ProfilimPage(),

  ];


  void _onItemTapped(int index) {
    index == 0
        ? _drawerKey.currentState!.openDrawer():
    setState(() {
      _selectedIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(key: _drawerKey,drawer: Drawer(child: ListView(children: [DrawerHeader(child: Text("drawer header")),ListTile(title:Text("profilim"),)],)),body:Center(child: _widget.elementAt(_selectedIndex)) ,
    bottomNavigationBar: BottomNavigationBar(unselectedItemColor: Colors.black,backgroundColor: Colors.blue,fixedColor: Colors.amber,items: [
      BottomNavigationBarItem(
        label: "drawer",
        icon: Icon(Icons.more_vert),
      ),
      BottomNavigationBarItem(icon: Icon(Icons.queue_sharp),label: "görevler"),
      BottomNavigationBarItem(icon: Icon(Icons.add),label: "ekle"),
      BottomNavigationBarItem(icon: Icon(Icons.person),label: "profilim"),
    ],currentIndex:_selectedIndex,onTap: _onItemTapped, ),);
  }
}
