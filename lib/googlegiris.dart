import 'package:auth/auth.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:todoapp2/defaultpage.dart';
import 'package:todoapp2/kayitpage.dart';
import 'package:todoapp2/main.dart';
import 'giris.dart';


class GoogleGirisPage extends StatefulWidget {
  const GoogleGirisPage({Key? key}) : super(key: key);

  @override
  State<GoogleGirisPage> createState() => _GoogleGirisPageState();
}

final GoogleSignIn _googleSignIn = GoogleSignIn();
final FirebaseAuth _auth = FirebaseAuth.instance;
final _pageController = PageController();




class _GoogleGirisPageState extends State<GoogleGirisPage> {

  @override
  Widget build(BuildContext context) {
    void handleGoogleSignIn() async {
      try {
        final GoogleSignInAccount? googleSignInAccount =
        await _googleSignIn.signIn();
        if (googleSignInAccount!.email == null) {
          // Show an error message or dialog asking the user to select an email address
          return;
        }
        final GoogleSignInAuthentication googleSignInAuthentication =
        await googleSignInAccount!.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleSignInAuthentication.accessToken,
          idToken: googleSignInAuthentication.idToken,
        );

        await _auth.signInWithCredential(credential);
        print("Google ile oturum açan kullanıcı: ${user.toString()}");

        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => DefaultPage()));
      } catch (error) {
        print(error);
      }
    }
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(20)),
              width: 300,
              height: 300,
              child: PageView(
                controller: _pageController,
                scrollDirection: Axis.horizontal,
                children: [
                  Container(
                    color: Colors.blue,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "İş ve özel hayatını düzene koy",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                  Container(
                    color: Colors.blueAccent,
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        "Başarının yolu inanmaktan geçer.",
                        style: TextStyle(
                          color: Colors.white70,
                          fontWeight: FontWeight.bold,
                          fontSize: 30,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 20,),
            ElevatedButton(
                onPressed:(){
                  handleGoogleSignIn();

                },
                child: Text(
                  "google ile devam et",
                )),
            SizedBox(
              height: 20,
            ),
            PopupMenuButton(
              child: Text(
                "Daha fazla seçenekle devam et",
                style: TextStyle(decoration: TextDecoration.underline),
              ),
              onSelected: (value) {
                if (value == "item1") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => KayitPage()));
                }
                if (value == "item2") {
                  Navigator.pushReplacement(context,
                      MaterialPageRoute(builder: (context) => GirisPage()));
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuItem>[
                const PopupMenuItem(
                  child: Text('E-posta ile kaydol'),
                  value: "item1",
                ),
                const PopupMenuItem(
                  child: Text('E-posta ile giriş yap'),
                  value: "item2",
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
