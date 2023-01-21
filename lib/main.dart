import 'package:auth/auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:todoapp2/defaultpage.dart';
import 'package:todoapp2/googlegiris.dart';
import 'package:todoapp2/savetextpage.dart';

import 'giris.dart';
import 'myhomepage.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    runApp(MyApp());
}
User? user =FirebaseAuth.instance.currentUser;

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: user!= null ? DefaultPage():GoogleGirisPage()
    );
  }
}



