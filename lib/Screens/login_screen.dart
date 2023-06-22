import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  late final FocusNode emailFocusNode;
  late final FocusNode passFocusNode;
  TextEditingController emailController = TextEditingController();
  TextEditingController passController = TextEditingController();
  final formKey = GlobalKey<FormState>();
  bool hidden = false;
  bool load = false;
  bool verified = false;
  FirebaseAuth auth = FirebaseAuth.instance;

  @override
  void initState() {
    emailFocusNode = FocusNode();
    passFocusNode = FocusNode();
    super.initState();
  }

  @override
  void dispose() {
    emailFocusNode.dispose();
    passFocusNode.dispose();
    emailController.dispose();
    passController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: SingleChildScrollView(
      child: Stack(
        children: [
          Blur(
              blur: 5,
              child: Container(
                height: h,
                width: w,
                color: Colors.white30,
              )),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 25.0),
            child: Center(
              child: SizedBox(
                  width: w / 3,
                  child: Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0),
                    ),
                    color: Colors.white,
                    elevation: 10,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 35.0, vertical: 20),
                      child: Column(
                        children: [
                          const Align(
                              alignment: Alignment.topLeft,
                              child: Text(
                                'Log in',
                                style: TextStyle(
                                    fontWeight: FontWeight.bold, fontSize: 28),
                              )),
                          const SizedBox(height: 25),
                          const Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Email',
                                  style: TextStyle(
                                      fontSize: 17,
                                      fontWeight: FontWeight.w600),
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      'Need an account?',
                                      style: TextStyle(
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    ),
                                    SizedBox(width: 10),
                                    Text(
                                      'Sign up',
                                      style: TextStyle(
                                          color: Colors.teal,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w400),
                                    )
                                  ],
                                ),
                              ]),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 8.0),
                            child: Form(
                              key: formKey,
                              child: Column(
                                children: [
                                  tff(emailController, true, emailFocusNode),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        const Text(
                                          'Password',
                                          style: TextStyle(
                                              fontSize: 17,
                                              fontWeight: FontWeight.w600),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: [
                                            IconButton(
                                                onPressed: () {
                                                  hidden = !hidden;
                                                  setState(() {});
                                                },
                                                icon: (hidden == true)
                                                    ? const Icon(
                                                        Icons.visibility_off,
                                                        color: Colors.lightBlue,
                                                      )
                                                    : const Icon(
                                                        Icons.visibility,
                                                        color: Colors.lightBlue,
                                                      )),
                                            const SizedBox(width: 5),
                                            Text(
                                              (hidden == false)
                                                  ? 'Show'
                                                  : 'Hide',
                                              style: const TextStyle(
                                                  color: Colors.teal,
                                                  fontSize: 13,
                                                  fontWeight: FontWeight.w400),
                                            )
                                          ],
                                        ),
                                      ]),
                                  const SizedBox(
                                    height: 6,
                                  ),
                                  tff(passController, hidden, passFocusNode)
                                ],
                              ),
                            ),
                          ),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 2),
                                elevation: 5,
                                shadowColor: Colors.purple,
                                shape: const RoundedRectangleBorder(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(21)),
                                    side: BorderSide(
                                        color: Colors.white, width: 1.5)),
                                backgroundColor: Colors.deepPurple),
                            onPressed: () {
                              if (formKey.currentState!.validate()) {
                                setState(() {
                                  load = true;
                                });
                                loginFirebase();
                              }},
                            child: Center(
                                child: load
                                    ? const CircularProgressIndicator(
                                        strokeWidth: 2,
                                        color: Colors.white,
                                      )
                                    : const Text(
                                        'Login',
                                        style: TextStyle(
                                            fontSize: 21, color: Colors.white),
                                      )),
                          ),
                        ],
                      ),
                    ),
                  )),
            ),
          )
        ],
      ),
    ));
  }

  Widget tff(TextEditingController controller, bool b, final focusNode) {
    return TextFormField(
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      cursorWidth: 1.5,
      cursorColor: Colors.lightBlue,
      obscureText: (b == false) ? true : false,
      decoration: InputDecoration(
        border: const OutlineInputBorder(
            borderSide: BorderSide(
              color: Colors.black54,
            ),
            borderRadius: BorderRadius.all(Radius.circular(15))),
        focusedBorder: OutlineInputBorder(
            borderSide: BorderSide(
                color: Colors.lightBlue.shade200,
                width: 2.5,
                style: BorderStyle.solid),
            borderRadius: const BorderRadius.all(Radius.circular(15))),
        hintText: (b == true) ? 'user Gmail' : 'user password',
        hintStyle: const TextStyle(color: Colors.red, fontSize: 11),
      ),
      onSaved: (value) {
        if (kDebugMode) {
          print('Saved value');
        }
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'Please enter e-mail';
        }
        return null;
      },
    );
  }

  Future<void> loginFirebase(){
   return auth
        .signInWithEmailAndPassword(
        email: emailController.text.toString(),
        password:
        passController.text.toString())
        .then((value) {
      verified = auth.currentUser!.emailVerified;
      if (verified) {
        //alert.toastmessage(value.user!.email.toString());
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'Email Successfully Verified')));
        //Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
                content: Text(
                    'This account is still not verified, Try again signup and first verify then signin')));
      }
      setState(() {
        load = false;
      });
    }).onError((error, stackTrace) {
      setState(() {
        load = false;
      });
      //alert.toastmessage(error.toString());
    });
  }
}
