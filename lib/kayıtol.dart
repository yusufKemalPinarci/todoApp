import 'package:flutter/material.dart';

class KayitPage extends StatefulWidget {
  const KayitPage({Key? key}) : super(key: key);

  @override
  State<KayitPage> createState() => _KayitPageState();
}

GlobalKey _formKey=new GlobalKey();
class _KayitPageState extends State<KayitPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(body: Form(key: _formKey,child: Column(children: [ListView(children: [],)],)),);
  }
}
