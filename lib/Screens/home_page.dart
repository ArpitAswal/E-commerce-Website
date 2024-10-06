import 'package:ecommerce_shopping_website/Utils/gridview_attributes.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:iconly/iconly.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';

import '../ProvidersClass/category_provider.dart';
import '../ProvidersClass/products_provider.dart';
import '../Widgets/iconButtons.dart';
import '../Widgets/product_widget.dart';
import '../Widgets/swiper_widget.dart';
import 'all_products_screen.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage>
    with AutomaticKeepAliveClientMixin {
  late ScrollController _controller;
  late ProductsProvider productsProvider;
  late CategoryProvider categoryProvider;
  bool _isDataFetched = false;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    _controller = ScrollController();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_isDataFetched) {
      // Fetch data from both providers in parallel once
      _fetchDataInBackground();
      _isDataFetched = true;
    }
  }

  Future<void> _fetchDataInBackground() async {
    // Get the instances of the providers
    productsProvider = Provider.of<ProductsProvider>(context, listen: false);
    categoryProvider = Provider.of<CategoryProvider>(context, listen: false);
    WidgetsBinding.instance.addPostFrameCallback((callback) {
      productsProvider.getAllProducts();
      categoryProvider.fetchCategories();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);
    final size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
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
                        ..color = Colors.deepPurple,
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
                  child: CircleAvatar(
                    backgroundImage: AssetImage("assets/AA_Logo.png"),
                    radius: 26,
                  )),
            ],
          ),
          drawer: Drawer(
              width: MediaQuery.of(context).size.width * 0.25,
              shadowColor: Colors.deepPurpleAccent,
              elevation: 24.0,
              shape: Border.all(color: Colors.deepPurple, width: 2),
              child: ListView(padding: EdgeInsets.zero, children: [
                DrawerHeader(
                  padding: EdgeInsets.zero,
                  decoration: BoxDecoration(
                      color: Colors.deepPurpleAccent,
                      border: Border.all(
                          color: Colors.deepPurpleAccent)), //BoxDecoration
                  child: UserAccountsDrawerHeader(
                    margin:
                        EdgeInsets.symmetric(horizontal: 5.0, vertical: 5.0),
                    decoration: BoxDecoration(
                        color: Colors.deepPurpleAccent,
                        border: Border.all(color: Colors.deepPurpleAccent),
                        borderRadius: BorderRadius.circular(21)),
                    accountName: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Arpit Aswal",
                        style: GoogleFonts.aladin(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    accountEmail: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        "Admin Account",
                        style: GoogleFonts.aladin(
                            fontSize: 18,
                            color: Colors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    currentAccountPictureSize: Size.fromRadius(28),
                    currentAccountPicture: CircleAvatar(
                      backgroundImage: AssetImage("assets/AA_Logo.png"), //Text
                    ), //circleAvatar
                  ), //UserAccountDrawerHeader
                ),
                itemsHead(text: "Trending"),
                itemTile(
                    text: "New Items",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductScreen()));
                    }),
                itemTile(
                    text: "Sale Items",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductScreen()));
                    }),
                dividerWidget(),
                itemsHead(text: "Shop By Category"),
                Consumer<CategoryProvider>(
                    builder: (BuildContext context, value, Widget? child) {
                  return (value.categoryList.isEmpty)
                      ? SizedBox()
                      : Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: value.categoryList
                              .map((item) => itemTile(
                                  text: item,
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                AllProductScreen()));
                                  }))
                              .toList());
                }),
                dividerWidget(),
                itemsHead(text: "Items History"),
                itemTile(
                    text: "Cart Items",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductScreen()));
                    }),
                itemTile(
                    text: "Buy Items",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductScreen()));
                    }),
                dividerWidget(),
                itemsHead(text: "Help & Settings"),
                itemTile(
                    text: "Account Details",
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => AllProductScreen()));
                    }),
                dividerWidget(),
                AboutListTile(
                  // <-- SEE HERE
                  icon: Icon(
                    Icons.info,
                  ),
                  applicationIcon: CircleAvatar(
                    backgroundImage: AssetImage(
                      "assets/AA_Logo.png",
                    ),
                  ),
                  applicationName: 'AA Shopping Mart',
                  applicationVersion: '1.0.0',
                  applicationLegalese: '© 2024 My Company',
                  aboutBoxChildren: [
                    SizedBox(height: 20),
                    Text(
                      'Welcome to My E-Commerce Website! '
                      'We offer a variety of products at affordable prices.',
                      style: TextStyle(fontSize: 16),
                    ),
                    ListTile(
                      leading: Icon(Icons.web),
                      title: Text('Visit our website'),
                      onTap: () =>
                          _launchURL('https://www.myecommercewebsite.com'),
                    ),
                    ListTile(
                      leading: Icon(Icons.privacy_tip),
                      title: Text('Privacy Policy'),
                      onTap: () => _launchURL(
                          'https://www.myecommercewebsite.com/privacy'),
                    ),
                    ListTile(
                      leading: Icon(Icons.book),
                      title: Text('Terms and Conditions'),
                      onTap: () => _launchURL(
                          'https://www.myecommercewebsite.com/terms'),
                    ),
                    ListTile(
                      leading: Icon(Icons.email),
                      title: Text('Contact Us'),
                      onTap: () =>
                          _launchURL('mailto:support@myecommercewebsite.com'),
                    ),
                  ],
                  child: Text('About Website'),
                ),
              ])),
          body: Consumer<ProductsProvider>(
            builder: (BuildContext context, ProductsProvider provider,
                Widget? child) {
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
                      padding: const EdgeInsets.symmetric(
                          vertical: 20, horizontal: 20),
                      child: Column(children: [
                        SizedBox(
                          height: size.height * 0.04,
                        ),
                        Row(
                          mainAxisSize: MainAxisSize.max,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Expanded(child: SwiperWidget("Men")),
                            SizedBox(width: size.width * 0.1),
                            Expanded(child: SwiperWidget("Women")),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.04,
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
                                  categoryProvider.selectCategory = null;
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              AllProductScreen()));
                                },
                                icon: IconlyBold.arrow_right_2),
                          ],
                        ),
                        GridView.builder(
                            shrinkWrap: true,
                            itemCount: 12,
                            scrollDirection: Axis.vertical,
                            physics: const AlwaysScrollableScrollPhysics(),
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount:
                                  GridViewAttributes.getCrossAxisCount(context),
                              mainAxisSpacing: 12.0,
                              crossAxisSpacing: 16.0,
                              childAspectRatio:
                                  GridViewAttributes.getChildAspectRatio(
                                      context),
                            ),
                            itemBuilder: (ctx, index) {
                              return ChangeNotifierProvider.value(
                                value: productsProvider,
                                child: ProductWidget(
                                    index: index, whichList: "ProductList"),
                              );
                            }),
                      ]),
                    );
            },
          )),
    );
  }

  Widget itemsHead({required String text}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: FittedBox(
          fit: BoxFit.scaleDown,
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            style: TextStyle(
                color: Colors.black87,
                fontWeight: FontWeight.w600,
                fontSize: 18),
            textAlign: TextAlign.start,
          )),
    );
  }

  Widget itemTile({
    required String text,
    required Function()? onTap,
  }) {
    return ListTile(
      title: Text(text,
          softWrap: true,
          textAlign: TextAlign.start,
          style: TextStyle(
              color: Colors.deepPurple,
              fontSize: 14,
              fontWeight: FontWeight.w500,
              fontStyle: FontStyle.italic,
              overflow: TextOverflow.ellipsis)),
      onTap: () {
        Navigator.pop(context);
        onTap;
      },
    );
  }

  Widget dividerWidget() {
    return Divider(
      color: Colors.grey,
      thickness: 1.5,
      indent: 10.0,
      endIndent: 10.0,
    );
  }

  void _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
