import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp2/googlegiris.dart';
import 'package:todoapp2/goster.dart';
import 'package:todoapp2/profilim.dart';
import 'package:todoapp2/savetextpage.dart';
import 'package:google_sign_in/google_sign_in.dart';

final GoogleSignIn _googleSignIn = GoogleSignIn();

Future<void> signOutWithGoogle() async {
  await _googleSignIn.signOut();
  FirebaseAuth.instance.signOut();
}

class DefaultPage extends StatefulWidget {
  const DefaultPage({Key? key}) : super(key: key);

  @override
  State<DefaultPage> createState() => _DefaultPageState();
}

class _DefaultPageState extends State<DefaultPage> {
  int _selectedIndex = 1;

  GlobalKey<ScaffoldState> _drawerKey = GlobalKey();
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);
  static List<StatefulWidget> _widget = <StatefulWidget>[
    TextListPage(),
    TextListPage(),
    SaveTextPage(),
    ProfilimPage(),
  ];

  void _onItemTapped(int index) {
    index == 0
        ? _drawerKey.currentState!.openDrawer()
        : setState(() {
            _selectedIndex = index;
          });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _drawerKey,
      drawer: Drawer(
          child: ListView(
        children: [
          DrawerHeader(
              child: FirebaseAuth.instance.currentUser!.photoURL != null
                  ? Image.network(
                      FirebaseAuth.instance.currentUser!.photoURL.toString())
                  : Text(
                      "USTA",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    )),
          ListTile(
            title:FirebaseAuth.instance.currentUser!.displayName!=null?
                Text(FirebaseAuth.instance.currentUser!.phoneNumber.toString()):Text("Kahraman"),
          ),
          ListTile(
            title: Text("çıkış yap"),
            onTap: () {
              signOutWithGoogle();
              Navigator.pushReplacement(context,
                  MaterialPageRoute(builder: (context) => GoogleGirisPage()));
            },
          )
        ],
      )),
      body: Center(child: _widget.elementAt(_selectedIndex)),
      bottomNavigationBar: BottomNavigationBar(
        unselectedItemColor: Colors.black,
        backgroundColor: Colors.blue,
        fixedColor: Colors.amber,
        items: [
          BottomNavigationBarItem(
            label: "drawer",
            icon: Icon(Icons.more_vert),
          ),
          BottomNavigationBarItem(
              icon: Icon(Icons.queue_sharp), label: "görevler"),
          BottomNavigationBarItem(icon: Icon(Icons.add), label: "ekle"),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: "profilim"),
        ],
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
      ),
    );
  }
}
