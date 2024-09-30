import 'package:ecommerce_shopping_website/Utils/gridview_attributes.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';

import '../Global/Colors.dart';
import '../ProvidersClass/products_provider.dart';
import '../Widgets/iconButtons.dart';
import '../Widgets/product_widget.dart';
import '../Widgets/swiper_widget.dart';
import 'account_screen.dart';
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
    final size = MediaQuery
        .of(context)
        .size;

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
                        fillColor: Theme
                            .of(context)
                            .cardColor,
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(21.0),
                          borderSide: BorderSide(
                            color: Theme
                                .of(context)
                                .cardColor,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(25.0),
                          borderSide: BorderSide(
                            width: 1,
                            color:
                            Theme
                                .of(context)
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
                      provider.setSearchList(provider.productsList
                          .where((element) =>
                          element.title!
                              .toLowerCase()
                              .contains(value.toLowerCase()))
                          .toList());
                    }),
                SizedBox(height: size.height * 0.04,),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Expanded(child: SwiperWidget("Men")),
                    SizedBox(width: size.width * 0.1),
                    Expanded(child: SwiperWidget("Women")),
                  ],
                ),
                SizedBox(height: size.height * 0.04,),
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
                    SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: GridViewAttributes.getCrossAxisCount(context),
                      mainAxisSpacing: 12.0,
                      crossAxisSpacing: 16.0,
                      childAspectRatio: GridViewAttributes.getChildAspectRatio(context),
                    ),
                    itemBuilder: (ctx, index) {
                      return ChangeNotifierProvider.value(
                        value: providerInstance,
                        child: ProductWidget(index: index, whichList: (_searchController.text.isEmpty) ? "ProductList" : "SearchList"),
                      );
                    }),
              ]),
            );
          },
        ));
  }

}