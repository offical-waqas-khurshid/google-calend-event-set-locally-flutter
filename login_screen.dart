import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'firebase_services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

FirebaseService service = FirebaseService();

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController email = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String userId = '';
  var verId = '';
  int? resendTokenId;
  bool phoneAuthcheck = false;
  dynamic credentials;
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.indigo,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SizedBox(height: Get.height / 4),
              const CircleAvatar(
                backgroundColor: Colors.white,
                radius: 70,
                child: CircleAvatar(
                    backgroundColor: Colors.white,
                    radius: 60,
                    child: Icon(Icons.face)),
              ),
              const SizedBox(height: 10),
              //Image.asset('images/google1.png'),
              const Text(
                'Well Come Here ',
                style: TextStyle(fontSize: 25, color: Colors.white),
              ),
              const SizedBox(height: 30.0),
              Form(
                key: formKey,
                child: Column(
                  children: [
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          foregroundColor: MaterialStateProperty.all(
                            Colors.indigo,
                          ),
                          backgroundColor: MaterialStateProperty.all(
                            Colors.white,
                          ),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            isLoading == true
                                ? Container(
                                    padding: const EdgeInsets.all(5),
                                    child: const CircularProgressIndicator(
                                        color: Colors.indigo),
                                  )
                                : Icon(Icons.account_box),
                            const SizedBox(width: 8),
                            const Text('Login With Google'),
                          ],
                        ),
                        onPressed: () async {
                          setState(() {
                            isLoading = true;
                          });
                          try {
                            await service
                                .signInwithGoogle(context)
                                .whenComplete(() {
                              setState(() {
                                service.islogin = true;
                              });
                            });
                          } catch (e) {
                            if (e is FirebaseAuthException) {
                              // ignore: avoid_print
                              print(e.message!);
                            }
                          }
                          setState(() {
                            isLoading = false;
                          });
                        },
                      ),
                    ),
                    const SizedBox(height: 5),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
