import 'package:flutter/material.dart';
import 'package:sutt_task2/firebase.dart';
import 'package:sutt_task2/phone_auth.dart';

class LoginPage extends StatefulWidget {
  LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool flag = false;

  @override
  Widget build(BuildContext context) {
    if (flag == false) {
      return Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text('Login'),
        ),
        body: Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 70, 0, 0),
              child: Text(
                'Rail-Search',
                style: TextStyle(
                    fontFamily: 'Zendots',
                    fontWeight: FontWeight.w700,
                    color: Colors.blue[900],
                    fontSize: 40),
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(0, 30, 0, 60),
                child: Container(
                    child: Image.asset('assets/images/train_sutt (1).jpg'))),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 15, 0, 0),
              child: FloatingActionButton.extended(
                elevation: 10,
                onPressed: () async {
                  setState(() {
                    login(context);
                    flag = true;
                  });
                },
                icon: Image.asset('assets/images/google_icon.jpeg'),
                label: const Text(
                  'Login with Google',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 25, 0, 0),
              child: FloatingActionButton.extended(
                elevation: 10,
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (BuildContext context) {
                        return PhoneAuth();
                      },
                    ),
                  );
                },
                icon: Icon(Icons.phone),
                label: const Text(
                  'Login with Phone Number',
                  style: TextStyle(fontWeight: FontWeight.w800, fontSize: 15),
                ),
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
              ),
            ),
          ],
        ),
      );
    } else {
      return const Center(
          child: CircularProgressIndicator(
        strokeWidth: 7,
      ));
    }
  }
}
