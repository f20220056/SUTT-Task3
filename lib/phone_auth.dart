import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:sutt_task2/firebase.dart';
import 'package:sutt_task2/home_page.dart';

class PhoneAuth extends StatefulWidget {
  const PhoneAuth({super.key});

  @override
  State<PhoneAuth> createState() => _PhoneAuthState();
}

class _PhoneAuthState extends State<PhoneAuth> {
  late String num;
  late String otp;

  Future<PhoneAuthCredential?> phoneAuth(String num) async {
    await fb_auth.verifyPhoneNumber(
      phoneNumber: '+91 $num',
      verificationCompleted: (PhoneAuthCredential credential) async {
        UserCredential userCredential =
            await fb_auth.signInWithCredential(credential);
        user = userCredential.user;
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (BuildContext context) {
              return const Screen1();
            },
          ),
        );
      },
      verificationFailed: (FirebaseAuthException e) {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 100,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                        child: Text('Verification failed! Please try again')),
                  ],
                ),
              ),
            );
          },
        );
      },
      codeSent: (String verificationId, int? resendToken) {
        showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext context) {
            return Container(
              height: 300,
              child: Center(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(30, 60, 30, 35),
                      child: TextField(
                        decoration: const InputDecoration(
                          labelText: 'OTP',
                          hintText: 'Enter OTP sent to your mobile',
                          border: OutlineInputBorder(),
                        ),
                        onChanged: (text) {
                          otp = text;
                        },
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: FloatingActionButton.extended(
                          backgroundColor: Color.fromARGB(255, 0, 89, 243),
                          elevation: 8,
                          icon: Icon(Icons.arrow_circle_right_outlined),
                          label: Text('Login'),
                          onPressed: () async {
                            PhoneAuthCredential credential =
                                PhoneAuthProvider.credential(
                                    verificationId: verificationId,
                                    smsCode: otp);
                            try {
                              UserCredential userCredential = await fb_auth
                                  .signInWithCredential(credential);
                              user = userCredential.user;
                              FirebaseAuth.instance
                                  .authStateChanges()
                                  .listen((User? user) {
                                if (user != null) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (BuildContext context) {
                                        return const Screen1();
                                      },
                                    ),
                                  );
                                }
                              });
                            } on FirebaseAuthException catch (e) {
                              if (e.code == 'invalid-verification-code') {
                                showModalBottomSheet<void>(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return Container(
                                      height: 100,
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                                padding:
                                                    const EdgeInsets.fromLTRB(
                                                        0, 0, 0, 0),
                                                child: Text(
                                                    'Verification failed! Please try again')),
                                          ],
                                        ),
                                      ),
                                    );
                                  },
                                );
                              }
                            }
                          }),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      codeAutoRetrievalTimeout: (String verificationId) {},
    );
  }

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          title: Text(
            'Login with Phone',
            style: TextStyle(
              fontSize: 18,
            ),
          ),
          backgroundColor: Colors.blue,
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(30, 70, 30, 30),
              child: TextField(
                decoration: const InputDecoration(
                  labelText: 'Mobile Number',
                  hintText: 'Enter your number without country code',
                  border: OutlineInputBorder(),
                ),
                onChanged: (text) {
                  num = text;
                },
              ),
            ),
            FloatingActionButton.extended(
              backgroundColor: Colors.blue,
              elevation: 8,
              icon: Icon(Icons.arrow_circle_right_outlined),
              label: Text('Send OTP'),
              onPressed: () {
                phoneAuth(num);
              },
            ),
          ],
        ),
      );
    
  }
}
