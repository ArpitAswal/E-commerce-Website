import 'package:ecommerce_shopping_website/ProvidersClass/products_provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shopping_website/Widgets/product_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../ProvidersClass/category_provider.dart';
import '../Utils/gridview_attributes.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

class _AllProductScreenState extends State<AllProductScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch categories when the screen is loaded
      Provider.of<CategoryProvider>(context, listen: false).fetchCategories();
    });
  }

  @override
  void dispose() {
    super.dispose();
    Provider.of<CategoryProvider>(context, listen: false).removeCategoryItems();
  }

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    final prodProvider = Provider.of<ProductsProvider>(context, listen: false);
    final ctgProvider = Provider.of<CategoryProvider>(context, listen: false);

    return Scaffold(body: Consumer<CategoryProvider>(builder:
        (BuildContext context, CategoryProvider provider, Widget? child) {
      return Column(
        children: [
          (provider.categoryList.isEmpty)
              ? Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
                  highlightColor: Colors.grey.shade400,
                  child: Container(
                    height: height * 0.1,
                    width: double.infinity,
                    margin:
                        EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        color: Colors.white),
                  ))
              : Container(
                  width: double.infinity,
                  margin: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0, bottom: 8.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: provider.categoryList.map((value) {
                      String text = value as String;
                      return Expanded(
                        child: InkWell(
                          onTap: () => provider.fetchCategoryItems(value),
                          child: Container(
                            margin: EdgeInsets.symmetric(horizontal: (width < 600) ? 8.0 : 46),
                            padding: EdgeInsets.symmetric(
                                horizontal: 12.0, vertical: 8.0),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                                color: Colors.lightBlue,
                                borderRadius: BorderRadius.circular(24),
                                border:
                                    Border.all(color: Colors.white, width: 1.5),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.blueAccent,
                                      blurRadius: 6.0,
                                      spreadRadius: 1.5)
                                ]),
                            child: Text(
                              text.capitalize(),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontStyle: FontStyle.italic,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),
          Expanded(
            child: LazyLoadScrollView(
              isLoading: prodProvider.isLoading,
              onEndOfPage: () {
                (provider.selectedCategory == null)
                    ? prodProvider.loadMore()
                    : ctgProvider.loadMore();
              },
              child: GridView.builder(
                  padding:
                      EdgeInsets.symmetric(horizontal: 16.0, vertical: 24.0),
                  shrinkWrap: true,
                  itemCount: (provider.selectedCategory == null)
                      ? prodProvider.prodCurrentLimit
                      : provider.categoryLimit,
                  scrollDirection: Axis.vertical,
                  physics: const AlwaysScrollableScrollPhysics(),
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:
                        GridViewAttributes.getCrossAxisCount(context),
                    mainAxisSpacing: 12.0,
                    crossAxisSpacing: 16.0,
                    childAspectRatio:
                        GridViewAttributes.getChildAspectRatio(context),
                  ),
                  itemBuilder: (ctx, index) {
                    return ChangeNotifierProvider.value(
                      value: (provider.selectedCategory == null)
                          ? prodProvider
                          : ctgProvider,
                      child: ProductWidget(
                          index: index,
                          whichList: (provider.selectedCategory == null)
                              ? "ProductList"
                              : "CategoryItemsList"),
                    );
                  }),
            ),
          ),
        ],
      );
    }));
  }
}

extension StringExtensions on String {
  String capitalize() {
    String newString = "";
    for (String word in split(" ")) {
      newString += "${word[0].toUpperCase()}${word.substring(1)} ";
    }
    return newString;
  }
}
