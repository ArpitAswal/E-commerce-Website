import 'package:ecommerce_shopping_website/ProvidersClass/products_provider.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:ecommerce_shopping_website/Widgets/product_widget.dart';
import '../DataModel/Products.dart';

class AllProductScreen extends StatefulWidget {
  const AllProductScreen({super.key});

  @override
  State<AllProductScreen> createState() => _AllProductScreenState();
}

final List<Products> productsList = [];

class _AllProductScreenState extends State<AllProductScreen> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
          body: SizedBox(
                height: MediaQuery.of(context).size.height,
                width: MediaQuery.of(context).size.width,
                child: Consumer<ProductsProvider>(
                builder: (BuildContext context, ProductsProvider provider, Widget? child) {
                  return LazyLoadScrollView(
                    isLoading: provider.isLoading,
                    onEndOfPage: () {
                      provider.loadMore();
                    },
                    child: GridView.builder(
                        padding: EdgeInsets.symmetric(
                            horizontal: 16.0, vertical: 24.0),
                        shrinkWrap: true,
                        itemCount: provider.prodCurrentLimit,
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
                          return ChangeNotifierProvider.value(
                            value: Provider.of<ProductsProvider>(
                                context, listen: false),
                            child: ProductWidget(index: index, whichList: true),
                          );
                        }),
                  );
                }),
              )
        );

  }
}
