import 'dart:convert';
import 'package:ecommerce_shopping_website/Screens/cart_products_screen.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:ecommerce_shopping_website/Widgets/product_widget.dart';
import '../DataModel/Products.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import '../Widgets/cart_calling.dart';
import '../Widgets/infoButton.dart';

class AllProducts extends StatefulWidget {
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

final List<Products> productsList = [];

class _AllProductsState extends State<AllProducts> {
  bool _isLoading = false;
  int currentLimit = 15;
  bool isError = false;

  final ScrollController _controller = ScrollController();

  Future<void> getProducts() async {
    try {
      final response =
          await http.get(Uri.parse('https://fakestoreapi.com/products'));
      //https://api.escuelajs.co/api/v1/products?limit=20&offset=0
      // https://fakestoreapi.com/carts
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        productsList.clear();
        for (Map i in data) {
          productsList.add(Products.fromJson(i));
        }
      }
      debugPrint('${productsList.length}');
      setState(() {});
    } catch (error) {
      isError = true;
      throw error.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (currentLimit <= productsList.length) {
          _isLoading = true;
          if (currentLimit == productsList.length) {
            currentLimit = productsList.length;
          } else {
            currentLimit += 5;
          }
          debugPrint('currentlimit=$currentLimit');
        } else {
//          await Future.delayed(const Duration(seconds: 2));
          _isLoading = false;
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CartCalling>(
        create: (BuildContext context) => CartCalling(),
        child: Builder(builder: (context) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('All Products'),
              centerTitle: true,
              actions: [
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const CartProductsScreen()));
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 0, right: 15, top: 8, bottom: 8),
                    child: Stack(
                      children: [
                        const Align(
                            alignment: Alignment.bottomCenter,
                            child: Icon(Icons.shopping_cart_rounded,
                                color: Colors.blue, size: 25)),
                        Consumer<CartCalling>(builder:
                            (BuildContext context, value, Widget? child) {
                          return Positioned(
                              top: 0,
                              left: 0,
                              right: 0,
                              child: Text(
                                value.count.toString(),
                                style: const TextStyle(color: Colors.purple),
                              ));
                        })
                      ],
                    ),
                  ),
                )
              ],
            ),
            body: (isError)
                ? const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          IconlyBold.danger,
                          color: Colors.red,
                          size: 50,
                        ),
                        SizedBox(height: 5),
                        Text(
                            'There is an error in server Please again open the website',
                            style: TextStyle(
                                color: Colors.red,
                                fontSize: 24,
                                fontWeight: FontWeight.w500)),
                      ],
                    ),
                  )
                : productsList.isEmpty
                    ? const Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            CircularProgressIndicator(),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              'Loading',
                              style: TextStyle(
                                  fontSize: 20,
                                  color: Colors.blue,
                                  fontWeight: FontWeight.w400),
                            )
                          ],
                        ),
                      )
                    : Stack(children: [
                        SingleChildScrollView(
                          controller: _controller,
                          child: Column(
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 12),
                                child: LazyLoadScrollView(
                                  isLoading: _isLoading,
                                  onEndOfPage: () => didChangeDependencies(),
                                  child: GridView.builder(
                                      shrinkWrap: true,
                                      itemCount:
                                          (currentLimit <= productsList.length)
                                              ? currentLimit
                                              : productsList.length,
                                      scrollDirection: Axis.vertical,
                                      physics:
                                          const AlwaysScrollableScrollPhysics(),
                                      gridDelegate:
                                          const SliverGridDelegateWithMaxCrossAxisExtent(
                                        crossAxisSpacing: 10.0,
                                        mainAxisSpacing: 6.0,
                                        maxCrossAxisExtent: 300,
                                      ),
                                      itemBuilder: (ctx, index) {
                                        return ChangeNotifierProvider.value(
                                            value: productsList[index],
                                            child: ProductWidget(index: index, whichList: true,));
                                      }),
                                ),
                              ),
                              if (_isLoading)
                                const Center(
                                    child: CircularProgressIndicator()),
                            ],
                          ),
                        ),
                        const Align(
                          alignment: Alignment.bottomRight,
                          child: AddInfo(),
                        )
                      ]),
          );
        }));
  }
}
