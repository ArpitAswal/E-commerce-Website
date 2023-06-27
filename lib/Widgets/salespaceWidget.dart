import 'package:flutter/material.dart';

class SaleWidget extends StatelessWidget {
  const SaleWidget(this.image, this.offer, {Key? key}) : super(key: key);
  final String? image;
  final int offer;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: double.infinity,
      height: size.height * 0.2,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        gradient: const LinearGradient(
            colors: [
              Color(0xFF7A60A5),
              Color(0xFF82C3DF),
            ],
            begin: FractionalOffset(0.0, 0.0),
            end: FractionalOffset(1.0, 0.0),
            stops: [0.0, 1.0],
            tileMode: TileMode.clamp),
      ),
      child: Row(
        children: [
          Flexible(
            flex: 1,
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 10),
              child: Container(
                height: double.infinity,
                decoration: BoxDecoration(
                  color: const Color(0xFF9689CE),
                  borderRadius: BorderRadius.circular(18),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10.0, vertical: 8),
                  child: Column(
                    children: [
                      Flexible(
                          child: SizedBox(
                              width: double.infinity,
                              child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Text(
                                    "Get the special discount",
                                    style: TextStyle(
                                        color: Colors.white, fontSize: 23),
                                  )))),
                      SizedBox(
                        height: 15,
                      ),
                      Flexible(
                        child: SizedBox(
                          width: double.infinity,
                          child: FittedBox(
                            fit: BoxFit.fill,
                            child: Text(
                              "50 %\nOFF",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                // fontSize: 300,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Flexible(
              flex: 2,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 10.0, vertical: 10.0),
                child: Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(26),
                  ),
                  child: Image.network(
                    image!,
                    fit: BoxFit.fitWidth,
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
