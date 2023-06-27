import 'package:flutter/material.dart';
import 'package:blur/blur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:page_transition/page_transition.dart';
import '../AuthServices/authentication.dart';
import '../Global/message.dart';
import 'home_screen.dart';

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
  String email = '';
  String pass = '';
  String name = 'AA';
  bool hidden = false;
  bool login = true;
  bool load1 = false;
  bool load2 = false;
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
            padding: const EdgeInsets.only(top: 50.0),
            child: Center(
              child: Container(
                width: 450,
                color: Colors.white70,
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  color: Colors.white,
                  elevation: 10,
                  margin:
                      const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 35.0, vertical: 25),
                    child: Column(
                      children: [
                        const SizedBox(height: 40),
                        Align(
                            alignment: Alignment.topLeft,
                            child: Text(
                              (login == true) ? 'LogIn' : 'SignUp',
                              style: const TextStyle(
                                  fontWeight: FontWeight.bold, fontSize: 28),
                            )),
                        const SizedBox(height: 25),
                        Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Email',
                                style: TextStyle(
                                    fontSize: 17, fontWeight: FontWeight.w600),
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    (login == true)
                                        ? 'Need an account?'
                                        : 'Already have an account?',
                                    style: const TextStyle(
                                        fontSize: 13,
                                        fontWeight: FontWeight.w400),
                                  ),
                                  const SizedBox(width: 7),
                                  TextButton(
                                      onPressed: (() {
                                        login = !login;
                                        emailController.text='';
                                        passController.text='';
                                        setState(() {});
                                      }),
                                      child: Text(
                                        (login == true) ? 'Sign up' : 'Log in',
                                        style: const TextStyle(
                                            color: Colors.teal,
                                            fontSize: 13,
                                            fontWeight: FontWeight.w400),
                                      ))
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
                                            (hidden == false) ? 'Show' : 'Hide',
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
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 20.0, horizontal: 10),
                          child: Column(
                            children: [
                              button(1, (login == true) ? 'Login' : 'Signup',
                                  Colors.green[600]!, Colors.white, ''),
                              const Padding(
                                padding: EdgeInsets.symmetric(vertical: 14.0),
                                child: Text('Or'),
                              ),
                              button(2, 'Continue with Google', Colors.white,
                                  Colors.black, 'assets/google.png'),
                              const SizedBox(height: 12),
                              button(3, 'Continue with GitHub', Colors.white,
                                  Colors.black, 'assets/GithubLogo.png'),
                              const SizedBox(height: 12),
                              button(
                                  4,
                                  'Continue with Facebook',
                                  Colors.blue[700]!,
                                  Colors.white,
                                  'assets/FacebookLogo.jpg'),
                            ],
                          ),
                        ),
                        if (login == true)
                          const Center(
                              child: Text(
                            'Forgot Password?',
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                          ))
                        else
                          const Center(
                              child: Text(
                            'By clicking the "Sign up " button, you are agree the Terms of Service and Privacy Policy',
                            softWrap: true,
                            textAlign: TextAlign.center,
                          ))
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
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
        if (controller.text == passController.text) {
          pass = value!;
        } else {
          email = value!;
        }
        setState(() {});
      },
      validator: (value) {
        if (value == null || value.isEmpty) {
          return (controller.text == passController.text)
              ? 'Enter the password'
              : 'Enter the email';
        }
        return null;
      },
    );
  }

  Widget button(
      int btn, String text, Color bgColor, Color textColor, String imgurl) {
    return SizedBox(
      height: 40,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            padding: const EdgeInsets.symmetric(vertical: 2),
            elevation: 7,
            shadowColor: Colors.greenAccent,
            shape: const RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(24)),
                side: BorderSide(color: Colors.white, width: 1.5)),
            backgroundColor: bgColor),
        onPressed: () async {
          if (btn == 1) {
            if (formKey.currentState!.validate()) {
              formKey.currentState!.save();
              setState(() {
                load1 = true;
              });
              if (login == true) {
                final status= await Authentication.signIn(email, pass);
                if(status.isEmpty){
                  movescreen();
                }
                else{
                  Alert.toastmessage(status);
                }
              } else if (login == false) {
                final status= await Authentication.signUp(name, email, pass);
                if(status.isEmpty){
                  movescreen();
                }
                else {
                  Alert.toastmessage(status);
                }
              }
              Future.delayed(const Duration(seconds: 2));
              setState(() {
                load1 = false;
              });
            }
          } else if (btn == 2) {
            User? user = await Authentication.googleSignIn();
            if (user != null) {
              movescreen();
            }
          } else if (btn == 3) {
            if (login == true) {
              await Authentication.signIn(email, pass);
            } else if (login == false) {
              await Authentication.signUp(name, email, pass);
            }
          } else if (btn == 4) {
            if (login == true) {
              await Authentication.signIn(email, pass);
            } else if (login == false) {
              await Authentication.signUp(name, email, pass);
            }
          }
        },
        child: (btn == 1 && load1 == true)
            ? const Center(
              child: CircularProgressIndicator(
                  strokeWidth: 3,
                  color: Colors.white,
                ),
            )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (imgurl.isNotEmpty)
                    FittedBox(
                      alignment: Alignment.center,
                      child:
                          CircleAvatar(radius: 15, child: Image.asset(imgurl)),
                    ),
                  const SizedBox(width: 7),
                  Text(
                    text.toString(),
                    style: TextStyle(fontSize: 15, color: textColor),
                  ),
                ],
              ),
      ),
    );
  }

  void movescreen() {
    Navigator.push(
        context,
        PageTransition(
            type: PageTransitionType.bottomToTopPop,
            child: const HomeScreen(),
            childCurrent: widget));
  }
}
