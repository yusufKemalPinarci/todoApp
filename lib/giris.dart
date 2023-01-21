import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp2/defaultpage.dart';

class GirisPage extends StatefulWidget {
  const GirisPage({Key? key}) : super(key: key);

  @override
  State<GirisPage> createState() => _GirisPageState();
}

class _GirisPageState extends State<GirisPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final formkeyy = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController sifreController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [ Center(
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          Image.asset(
            'assets/images/light.png',
            width: 150,
            height: 150,
          ),
          Padding(
            padding: const EdgeInsets.all(30.0),
            child: Form(
                key: formkeyy,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "boş bırakamazsın";
                          } else {
                            return null;
                          }
                        },
                        controller: emailController,
                        decoration: InputDecoration(
                            label: Text("email"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: TextFormField(
                        validator: (value) {
                          if (value!.isEmpty) {
                            return "boş bırakamazsın";
                          } else {
                            return null;
                          }
                        },
                        controller: sifreController,
                        decoration: InputDecoration(label:Text("Sifre"),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(20))),
                      ),
                    ),ElevatedButton(onPressed: () async {
                      String email=emailController.text;
                      String password=sifreController.text;
                      UserCredential giriskullanici= await auth.signInWithEmailAndPassword(email: email,
                          password: password);
                      if (giriskullanici.user!.emailVerified) {

                        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DefaultPage()));

                      } else
                      {print("Lütfen mail onaylayın");};
                    }, child: Text("Giriş Yap")),

                  ],
                )),
          )
        ]),
      ),],

      ),
    );
  }
}
