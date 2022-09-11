import 'dart:async';
import 'package:flutter/material.dart';
import 'package:one_page_app/services/services.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:one_page_app/views/one_page.dart';

class SignInPage extends StatefulWidget {
  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final Color primaryColor = const Color(0xff18203d);
  final Color secondaryColor = const Color(0xff232c51);

  StreamSubscription? connection;
  bool isOffline = false;

  static const nointernetSnackbar = SnackBar(
    content: Text('no internet connection.  Please check your internet'),
  );
  static const internetSnackbar = SnackBar(
    content: Text('Internet is working fine'),
  );
  late ConnectivityResult result;

  @override
  void initState() {
    connection = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) {
      if (result == ConnectivityResult.none) {
        setState(() {
          isOffline = true;
        });
        ScaffoldMessenger.of(context).showSnackBar(nointernetSnackbar);
      } else if (result == ConnectivityResult.mobile) {
        setState(() {
          isOffline = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(internetSnackbar);
      } else if (result == ConnectivityResult.wifi) {
        setState(() {
          isOffline = false;
        });
        ScaffoldMessenger.of(context).showSnackBar(internetSnackbar);
      }
    });
    super.initState();
  }

  @override
  void dispose() {
    connection!.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _textField(
        TextEditingController controller, String labelText, bool obscureText) {
      return Material(
        elevation: 10.0,
        color: Colors.white,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(topRight: Radius.circular(30.0))),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: TextField(
            obscureText: obscureText,
            controller: controller,
            style: const TextStyle(color: Colors.black),
            decoration: InputDecoration(
                hintText: "input",
                hintStyle:
                    const TextStyle(color: Color(0xFFE1E1E1), fontSize: 14),
                contentPadding: const EdgeInsets.symmetric(horizontal: 10),
                labelText: labelText,
                labelStyle: const TextStyle(color: Colors.grey),
                border: InputBorder.none),
          ),
        ),
      );
    }

    return Scaffold(
      body: Container(
        margin: const EdgeInsets.symmetric(horizontal: 70),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(height: 40.0),
            const Text(
              "Sign in to Rumble App",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 20),
            const Text(
              "Enter your email and password below to continue to Rumble!",
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 50),
            _textField(emailController, 'Email', false),
            const SizedBox(height: 20),
            _textField(passwordController, 'Password', true),
            const SizedBox(height: 50),
            Container(
              width: 200,
              height: 40,
              child: ElevatedButton(
                onPressed: () async {
                  loginController(emailController.text, passwordController.text,
                      'u_059e304c-bf71-4ef0-87df-3d0fc76e921d');

                  if (loginResult == "OK") {
                    Navigator.of(context).pushReplacement(
                      MaterialPageRoute(
                        builder: (context) => OnePage(),
                      ),
                    );
                  }
                },
                child: Text("Sign In"),
              ),
            ),
            const SizedBox(height: 40),
            // Container(
            //   width: 200,
            //   height: 40,
            //   child: ElevatedButton(

            //     onPressed: () {
            //       Navigator.push(
            //           context,
            //           MaterialPageRoute(
            //             builder: (context) {
            //               //LoginPage();
            //             }
            //           ));
            //     },
            //     child: Text("Sign Up"),
            //   ),
            // )
          ],
        ),
      ),
    );
  }
}
