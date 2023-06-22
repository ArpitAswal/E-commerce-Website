import 'package:flutter/material.dart';
import 'package:blur/blur.dart';

class LogInScreen extends StatelessWidget {
  const LogInScreen({super.key});

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Scaffold(
        body: Stack(
          children: [
            Blur(
                blur: 5,
                child: Container(
                  height: h,
                  width: w,
                  color: Colors.white30,
                )),
            Center(
                child: SizedBox(
                    width: 540,
                    height: 400,
                    child: Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        elevation: 10,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 35.0),
                            child: Column(
                              children: [
                                const SizedBox(height: 35),
                               const Align(
                                   alignment:Alignment.topLeft,
                            child: Text('Log in',style: TextStyle(fontWeight: FontWeight.bold,fontSize: 26),)),
                                const SizedBox(height: 25),
                                const Row(
                                  children: [
                                  Text('Email',style: TextStyle(fontSize: 18,fontWeight: FontWeight.w700),),
                                   SizedBox(width: 260,),
                                    Text('Need an account?',style:TextStyle(fontSize: 14,fontWeight: FontWeight.w500),),
                                    SizedBox(width: 16,),
                                    Text('Sign up',style: TextStyle(color: Colors.teal,fontSize: 14,fontWeight: FontWeight.w500),)
                                    ]
                                ),

                                TextFormField(
                                  decoration:const InputDecoration(
                                   border:OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: Colors.black54,
                                    )
                                  ),
                                )),
                                TextFormField()
                              ],
                            ),
                          ),
                        )))
          ],
        ));
  }
}
