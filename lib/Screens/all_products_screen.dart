import 'package:ecommerce_shopping_website/ProvidersClass/products_provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shopping_website/Widgets/product_widget.dart';

import '../ProvidersClass/category_provider.dart';
import '../Utils/gridview_attributes.dart';

class AllProductScreen extends StatelessWidget {
  const AllProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final prodProvider = Provider.of<ProductsProvider>(context, listen: false);
    final ctgProvider = Provider.of<CategoryProvider>(context, listen: false);

    return Scaffold(body: Consumer<CategoryProvider>(builder:
        (BuildContext context, CategoryProvider provider, Widget? child) {
      return Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.1,
            child: ListView(
              padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
              scrollDirection: Axis.horizontal,
              physics: AlwaysScrollableScrollPhysics(),
              children: provider.categoryList.map((value) {
                return InkWell(
                  onTap: () => provider.fetchCategoryItems(value),
                  child: Container(
                    constraints: BoxConstraints(minWidth: 100, maxWidth: 150),
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.0, vertical: 8.0),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                        color: Colors.lightBlue,
                        borderRadius: BorderRadius.circular(24),
                        border: Border.all(color: Colors.white, width: 1.5),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.blueAccent,
                              blurRadius: 6.0,
                              spreadRadius: 1.5)
                        ]),
                    child: Text(
                      value,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                          color: Colors.white,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w600),
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
