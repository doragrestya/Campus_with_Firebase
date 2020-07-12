import 'package:campusapp/DashboardPage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();

  Future<void> _handleGoogleSign() async {
    final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
    final GoogleSignInAuthentication googleAuth =
        await googleUser.authentication;

    final AuthCredential credential = GoogleAuthProvider.getCredential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );

    AuthResult result = await _auth.signInWithCredential(credential);
    final FirebaseUser user = result.user;

    _alertDialog(user);
  }

  Future<void> _signOut() async {
    await _googleSignIn.signOut();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.deepOrange,
      body: Center(
        child: ListView(
          children: <Widget>[
            Stack(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.only(top: 50, bottom: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      Image.asset(
                        'images/logo.png',
                        height: 200,
                        width: 200,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          'Berakhlak Mulia, Berfikir Akademis, Bertindak Profesional',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Padding(
                        padding:
                            const EdgeInsets.only(left: 50, right: 50, top: 80),
                        child: Container(
                          width: MediaQuery.of(context).size.width,
                          child: Column(
                            children: <Widget>[
                              Container(
                                margin: EdgeInsets.only(top: 16, bottom: 16),
                                width: MediaQuery.of(context).size.width,
                                height: 60,
                                child: RaisedButton(
                                  color: Colors.white,
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8)),
                                  onPressed: () => _handleGoogleSign(),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: <Widget>[
                                      Image.asset('images/google.jpg', height: 30,),
                                      Padding(padding: EdgeInsets.only(left: 5),),
                                      Text(
                                        'Sign in with Google',
                                        style: TextStyle(
                                            color: Colors.black,
                                            letterSpacing: 3, fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),

//                              Container(
//                                margin: EdgeInsets.only(top: 16, bottom: 16),
//                                width: MediaQuery.of(context).size.width,
//                                height: 40,
//                                child: RaisedButton(
//                                  color: Colors.deepOrange,
//                                  shape: RoundedRectangleBorder(
//                                      borderRadius: BorderRadius.circular(8)),
//                                  onPressed: () => _signOut(),
//                                  child: Row(
//                                    mainAxisAlignment: MainAxisAlignment.center,
//                                    children: <Widget>[
//                                      Icon(Icons.exit_to_app),
//                                      Text(
//                                        'SignOut',
//                                        style: TextStyle(
//                                            color: Colors.white,
//                                            letterSpacing: 3),
//                                      ),
//                                    ],
//                                  ),
//                                ),
//                              ),
                            ],
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }

  void _alertDialog(FirebaseUser user) {
    AlertDialog dialog = AlertDialog(
      content: Container(
        height: 125,
        child: Column(
          children: <Widget>[
            Text(
              'Login Berhasil',
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue),
            ),
            Divider(),
            ClipOval(
              child: Image.asset(user.photoUrl),
            ),
            Text('Anda Login sebagai ${user.displayName}'),
            Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: RaisedButton(
                child: Text('Oke'),
                onPressed: () => Navigator.push(context,
                    MaterialPageRoute(builder: (context) => DashboardPage())),
                color: Colors.red,
              ),
            )
          ],
        ),
      ),
    );
    showDialog(context: context, child: dialog);
  }
}
