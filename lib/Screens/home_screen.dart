import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:card_swiper/card_swiper.dart';
/*
import 'package:ecommerce_shopping_website/Widgets/iconButtons.dart';
import 'package:ecommerce_shopping_website/globalData/shoeItems.dart';
import 'package:ecommerce_shopping_website/APIModel/Products.dart';
import 'package:ecommerce_shopping_website/Screens/allcategoryScreen.dart';
import 'package:ecommerce_shopping_website/Screens/AccountScreen.dart';
import 'package:ecommerce_shopping_website/Widgets/salespaceWidget.dart';
import 'package:ecommerce_shopping_website/Screens/allproductsScreen.dart';
import 'package:ecommerce_shopping_website/Widgets/productsWidget.dart';
import 'package:ecommerce_shopping_website/globalData/Colors.dart';*/
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

/*
class _HomeScreenState extends State<HomeScreen> {
  late TextEditingController _searchController;
  final ScrollController _controller = ScrollController();

  List<Products> productsList = [];
  List<Products> searchList = [];
  bool isLoading = false;
  int currentLimit = 10;
  String errorMsg = '';

  Future<void> getProducts() async {
    try {
      final response = await http
          .get(Uri.parse('https://fakestoreapi.com/products?limit=10'));
      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        productsList.clear();
        for (Map i in data) {
          productsList.add(Products.fromJson(i));
        }
      }
      debugPrint('${productsList.length}');
    } catch (error) {
      errorMsg = error.toString();
      debugPrint(errorMsg);
      throw error.toString();
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _controller.addListener(() async {
      if (_controller.position.pixels == _controller.position.maxScrollExtent) {
        if (currentLimit <= productsList.length) {
          isLoading = true;
          currentLimit += 5;
        } else {
          await Future.delayed(const Duration(seconds: 2));
          isLoading = false;
        }
        setState(() {});
      }
    });
  }

  @override
  void initState() {
    _searchController = TextEditingController();
    getProducts();
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus();
        },
        child: Scaffold(
            appBar: AppBar(
              title: FittedBox(
                fit: BoxFit.fill,
                child: Stack(
                  children: <Widget>[
                    // Stroked text as border.
                    Text(
                      ' X HOME SHOPPING ',
                      style: TextStyle(
                        wordSpacing: 2,
                        fontSize: 28,
                        foreground: Paint()
                          ..style = PaintingStyle.stroke
                          ..strokeWidth = 5
                          ..color = iconsColor,
                      ),
                    ),
                    // Solid text as fill.
                    Text(
                      ' X HOME SHOPPING ',
                      style: TextStyle(
                        //wordSpacing: 2,
                        fontSize: 28,
                        color: Colors.grey[300],
                      ),
                    ),
                  ],
                ),
              ),
              leading: Padding(
                padding: const EdgeInsets.only(left: 12.0),
                child: Buttons(
                  function: () {
                    Navigator.push(
                      context,
                      PageTransition(
                        type: PageTransitionType.leftToRightWithFade,
                        child: const AllCategory(),
                      ),
                    );
                  },
                  icon: IconlyBold.category,
                ),
              ),
              actions: [
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: Buttons(
                    function: () {
                      Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.leftToRightPop,
                            child: const AccountScreen(),
                            childCurrent: widget),
                      );
                    },
                    icon: IconlyBold.user_3,
                  ),
                ),
              ],
            ),
            body: (errorMsg.isNotEmpty)
                ? const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
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
            )
                : (productsList.isEmpty)
                ? const Center(
              child: Column(
                //crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircularProgressIndicator(),
                  SizedBox(height: 5),
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
                : SingleChildScrollView(
              controller: _controller,
              child: Padding(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14.0, vertical: 10),
                child: Column(children: [
                  TextFormField(
                    controller: _searchController,
                    keyboardType: TextInputType.name,
                    decoration: InputDecoration(
                        contentPadding:
                        const EdgeInsets.only(left: 25),
                        hintText: "Search",
                        hintStyle: const TextStyle(fontSize: 18),
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21.0),
                          borderSide: BorderSide(
                            color: Theme.of(context).cardColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            width: 1,
                            color: Theme.of(context)
                                .colorScheme
                                .secondary,
                          ),
                        ),
                        suffixIcon: Padding(
                          padding: const EdgeInsets.only(right: 22.0),
                          child: Icon(IconlyLight.search,
                              color: iconsColor, size: 25),
                        )),
                    onChanged: (String value) {
                      setState(() {
                        searchList = productsList
                            .where((element) => element.title!
                            .toLowerCase()
                            .contains(value.toLowerCase()))
                            .toList();
                      });
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      SizedBox(
                        height: size.height * 0.25,
                        width: size.width / 2 - 100,
                        child: Swiper(
                          itemCount: mens.length,
                          itemBuilder: (ctx, index) {
                            return SaleWidget(mens[index].prod,
                                mens[index].price.values.toList()[0]);
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                              margin:
                              EdgeInsets.only(top: 10, right: 5),
                              alignment: Alignment.bottomRight,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red)),
                          control: const SwiperControl(
                              color: Colors.white,
                              disableColor: Colors.red,
                              size: 26,
                              padding: EdgeInsets.all(0)),
                        ),
                      ),
                      SizedBox(
                        height: size.height * 0.25,
                        width: size.width / 2 - 100,
                        child: Swiper(
                          itemCount: womens.length,
                          itemBuilder: (ctx, index) {
                            return SaleWidget(
                                womens[index].prod,
                                womens[index]
                                    .price
                                    .values
                                    .toList()[0]);
                          },
                          autoplay: true,
                          pagination: const SwiperPagination(
                              margin:
                              EdgeInsets.only(top: 10, right: 5),
                              alignment: Alignment.bottomRight,
                              builder: DotSwiperPaginationBuilder(
                                  color: Colors.white,
                                  activeColor: Colors.red)),
                          control: const SwiperControl(
                              color: Colors.white,
                              disableColor: Colors.red,
                              size: 26,
                              padding: EdgeInsets.all(0)),
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: Row(
                      mainAxisAlignment:
                      MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          " All Products",
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 21,
                              letterSpacing: 2.5,
                              wordSpacing: 1.2),
                        ),
                        const Spacer(),
                        Buttons(
                            function: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const AllProducts()));
                            },
                            icon: IconlyBold.arrow_right_2),
                      ],
                    ),
                  ),
                  LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () => didChangeDependencies(),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: (_searchController.text.isNotEmpty)
                            ? searchList.length
                            : (currentLimit <= productsList.length)
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
                          if (_searchController.text.isEmpty) {
                            return ChangeNotifierProvider.value(
                                value: productsList[index],
                                child: const ProductsWidget());
                          } else {
                            return ChangeNotifierProvider.value(
                                value: searchList[index],
                                child: const ProductsWidget());
                          }
                        }),
                  ),
                  if (isLoading) const CircularProgressIndicator()
                ]),
              ),
            )));
  }
}
*/