import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_shopping_website/Global/Colors.dart';
import '../APIModel/IndividualProduct.dart';

class ProductDetails extends StatefulWidget {
  const ProductDetails({
    Key? key,
    required this.id,
  }) : super(key: key);
  final String id;

  @override
  State<ProductDetails> createState() => _ProductDetailsState();
}

class _ProductDetailsState extends State<ProductDetails> {
  final titleStyle = const TextStyle(
      fontSize: 24,
      fontWeight: FontWeight.bold,
      decoration: TextDecoration.underline);

  Future<IndividualProduct> getProductInfo() async {
    final response = await http
        .get(Uri.parse('https://fakestoreapi.com/products/${widget.id}'));
    if (response.statusCode == 200) {
      var data = jsonDecode(response.body.toString());
      return IndividualProduct.fromJson(data);
    } else {
      throw Exception('Error');
    }
  }

  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    getProductInfo();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SizedBox(
        height: size.height,
        width: size.width,
        /* decoration: BoxDecoration(
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
        */
        child: SingleChildScrollView(
          controller: _controller,
          child: FutureBuilder(
              future: getProductInfo(),
              builder: (context, AsyncSnapshot<IndividualProduct> snapshot) {
                if (snapshot.hasData) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const BackButton(
                                color: Colors.black,
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 6.0),
                                  child: Center(
                                    child: Text(
                                      'Product: ${snapshot.data!.title.toString()}',
                                      style: const TextStyle(
                                        color: Colors.lightBlue,
                                        fontSize: 25,
                                        fontWeight: FontWeight.w500,
                                      ),
                                      maxLines: 2,
                                    ),
                                  ),
                                ),
                              ),
                              Text(
                                "\$ ${snapshot.data!.price}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.green,
                                    fontSize: 25),
                                textAlign: TextAlign.end,
                              )
                            ]),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 20),
                        child: Center(
                          child: SizedBox(
                              height: size.height * 0.7,
                              width: size.width / 2,
                              child: Image.network(
                                snapshot.data!.image.toString(),
                                fit: BoxFit.fill,
                              )),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 18.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Description', style: titleStyle),
                            const SizedBox(
                              height: 18,
                            ),
                            Text(
                              '"${snapshot.data!.description.toString()}"',
                              style: TextStyle(
                                  fontSize: 21,
                                  color: textColor,
                                  fontStyle: FontStyle.italic),
                            ),
                          ],
                        ),
                      ),
                    ],
                  );
                } else {
                  return Column(
                    children: [
                      SizedBox(height: size.height / 2),
                      const CircularProgressIndicator(),
                    ],
                  );
                }
              }),
        ),
      ),
    );
  }
}
