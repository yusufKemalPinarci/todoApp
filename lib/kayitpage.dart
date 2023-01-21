import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todoapp2/defaultpage.dart';
import 'package:todoapp2/googlegiris.dart';

class KayitPage extends StatefulWidget {
  const KayitPage({Key? key}) : super(key: key);

  @override
  State<KayitPage> createState() => _KayitPageState();
}

class _KayitPageState extends State<KayitPage> {
  FirebaseAuth auth = FirebaseAuth.instance;
  final formkeyy = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController sifreController = TextEditingController();
  User? user =FirebaseAuth.instance.currentUser;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(children: [Center(
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
                    ),

                    ElevatedButton(
                        onPressed: () async {
                          if (formkeyy.currentState!.validate()) {
                            formkeyy.currentState!.save();
                            String email = emailController.text;
                            String password = sifreController.text;
                            try {
                              UserCredential kullanicikimlik =
                              await auth.createUserWithEmailAndPassword(
                                  email: email, password: password);
                              var kullanici = kullanicikimlik.user;
                              await kullanici!
                                  .sendEmailVerification();
                              if(user!=null){
                                Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DefaultPage()));
                              }
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Uyarı"),
                                    content: Text("Bu bir uyarı mesajıdır"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text("Onayladım"),
                                        onPressed: () {
                                          if(user!=null){
                                            Navigator.of(context).pop();
                                            Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>DefaultPage()));
                                          }
                                          Navigator.of(context).pop();


                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                              // kullanıcıya onay için mail gider.
                              print(kullanici.toString());
                            } catch (e) {
                              print("HATAAAAA $e");
                              showDialog(
                                context: context,
                                builder: (BuildContext context) {
                                  return AlertDialog(
                                    title: Text("Uyarı"),
                                    content: Text("$e"),
                                    actions: <Widget>[
                                      ElevatedButton(
                                        child: Text("tamam"),
                                        onPressed: () {
                                          Navigator.of(context).pop();

                                        },
                                      ),
                                    ],
                                  );
                                },
                              );
                            }
                          } else {
                            print("yanliş bilgiler eksik");
                          }

                        },
                        child: Text("Kayıt Ol")),
                    ElevatedButton(onPressed: (){
                      Navigator.pushReplacement(context, MaterialPageRoute(builder: (context)=>GoogleGirisPage()));


                    }, child: Text("geri dön"))
                  ],
                )),
          )
        ]),
      ),],

      ),
    );
  }
}


