import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Global/Colors.dart';
import '../Global/shoeItems.dart';
import '../ProvidersClass/products_provider.dart';
import '../Widgets/iconButtons.dart';
import '../Widgets/product_widget.dart';
import '../Widgets/salespaceWidget.dart';
import 'account_screen.dart';
import 'all_category_screen.dart';
import 'all_products_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late TextEditingController _searchController;
  late ProductsProvider providerInstance;
  late ScrollController _controller;

  @override
  void initState() {
    _searchController = TextEditingController();
    _controller = ScrollController();
    providerInstance = Provider.of<ProductsProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      providerInstance.getAllProducts();
    });
    super.initState();
  }

  @override
  void dispose() {
    _searchController.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
        appBar: AppBar(
          title: FittedBox(
            fit: BoxFit.fill,
            child: Stack(
              children: <Widget>[
                // Stroked text as border.
                Text(
                  ' HOME SHOPPING ',
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
                  ' HOME SHOPPING ',
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
        body: Consumer<ProductsProvider>(
          builder:
              (BuildContext context, ProductsProvider provider, Widget? child) {
            return (provider.productsList.isEmpty)
                ? const Center(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
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
                  padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                  child: Column(children: [
                    TextFormField(
                        controller: _searchController,
                        keyboardType: TextInputType.name,
                        decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(left: 25),
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
                                color:
                                    Theme.of(context).colorScheme.secondary,
                              ),
                            ),
                            suffixIcon: Padding(
                              padding: const EdgeInsets.only(right: 22.0),
                              child: Icon(IconlyLight.search,
                                  color: iconsColor, size: 25),
                            )),
                        onChanged: (String value) {
                          provider.setSearchList(provider.productsList
                              .where((element) => element.title!
                                  .toLowerCase()
                                  .contains(value.toLowerCase()))
                              .toList());
                        }),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Container(
                            height: size.height * 0.25,
                            width: size.width * 0.38,
                            padding: const EdgeInsets.all(4.0),
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
                                  tileMode: TileMode.clamp)),
                            child: Swiper(
                              itemCount: mens.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SaleWidget(mens[index].prod,
                                      mens[index].price.values.toList()[0]),
                                );
                              },
                              autoplay: true,
                              pagination: const SwiperPagination(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  alignment: Alignment.bottomRight,
                                  builder: DotSwiperPaginationBuilder(
                                      color: Colors.white,
                                      activeColor: Colors.red)),
                              control: const SwiperControl(
                                  color: Colors.white,
                                  disableColor: Colors.red,
                                  size: 21,
                                  padding: EdgeInsets.all(0)),
                            ),
                          ),
                          const Spacer(),
                          Container(
                            height: size.height * 0.25,
                            width: size.width * 0.38,
                            padding: const EdgeInsets.symmetric(horizontal: 4.0),
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
                                  tileMode: TileMode.clamp)),
                            child: Swiper(
                              itemCount: womens.length,
                              itemBuilder: (ctx, index) {
                                return Padding(
                                  padding: const EdgeInsets.all(4.0),
                                  child: SaleWidget(womens[index].prod,
                                      womens[index].price.values.toList()[0]),
                                );
                              },
                              autoplay: true,
                              pagination: const SwiperPagination(
                                  margin: EdgeInsets.only(top: 10, right: 10),
                                  alignment: Alignment.bottomRight,
                                  builder: DotSwiperPaginationBuilder(
                                      color: Colors.white,
                                      activeColor: Colors.red)),
                              control: const SwiperControl(
                                  color: Colors.white,
                                  disableColor: Colors.red,
                                  size: 21,
                                  padding: EdgeInsets.all(0)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                          bgColor: Colors.deepPurpleAccent,
                          iconColor: Colors.white,
                            function: () {
                              Navigator.push(
                                  context,
                                  PageTransition(
                                      type: PageTransitionType.fade,
                                      child: const AllProductScreen()));
                            },
                            icon: IconlyBold.arrow_right_2),
                      ],
                    ),
                    GridView.builder(
                        shrinkWrap: true,
                        itemCount: (_searchController.text.isNotEmpty)
                            ? provider.searchList.length
                            : 12,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 4,
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 16.0,
                              childAspectRatio: 1.2
                        ),
                        itemBuilder: (ctx, index) {
                          //here we have to pass something that will indicate which list we want to use to display item
                          bool b = (_searchController.text.isEmpty) ? true // indicate that we will use products list
                              : false; // indicate that we will use search list
                          return ChangeNotifierProvider.value(
                            value: providerInstance,
                            child: ProductWidget(index: index, whichList: b),
                          );
                        }),
                  ]),
                );
          },
        ));
  }
}
