import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

GlobalKey _formKey = new GlobalKey();
TextEditingController isimController = new TextEditingController();

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Form(
                key: _formKey,
                child: Column(
                  children: [
                    TextFormField(
                      controller: isimController,
                      validator: (value) {
                        if (value == null) {
                          return "boş kalamaz";
                        }
                      },
                      decoration: InputDecoration(labelText: "isim",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(height: 20),
                    TextFormField(
                      controller: isimController,
                      validator: (value) {
                        if (value == null) {
                          return "boş kalamaz";
                        }
                      },
                      decoration: InputDecoration(labelText:"password",
                          border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(15))),
                    ),
                    SizedBox(height: 20),
                    SizedBox(
                        width: 400,
                        child: ElevatedButton(
                            onPressed: () {}, child: Text("Giris"))),
                    SizedBox(width: 400,child: ElevatedButton(onPressed: () {}, child: Text("Kayıt Ol")))
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
