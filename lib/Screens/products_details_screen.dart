import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../DataModel/productInfoModel.dart';
import '../ProvidersClass/products_provider.dart';
import '../Widgets/product_rating_widget.dart';

class ProductDetailScreen extends StatelessWidget {
  const ProductDetailScreen({super.key, required this.prodId});

  final int prodId;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<ProductsProvider>(builder:
          (BuildContext context, ProductsProvider provider, Widget? child) {
        return FutureBuilder(
          future: provider.getSingleProduct(prodId),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const ProductShimmer(); // Shimmer effect while loading
            } else if (snapshot.hasError) {
              return const Text(
                  "There is some error to display the information of selected product");
            } else {
              return ProductWidget(data: snapshot.data!);
            }
          },
        );
      }),
    );
  }
}

class ProductShimmer extends StatelessWidget {
  const ProductShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
      child: Shimmer.fromColors(
          enabled: true,
          baseColor: Colors.grey.shade300,
          highlightColor: Colors.grey.shade300,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Row(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Container(
                    width: 26.0,
                    height: 26.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  ),
                  Flexible(
                    child: Container(
                        margin: const EdgeInsets.symmetric(horizontal: 16.0),
                        height: 16.0,
                        color: Colors.white),
                  ),
                  Container(
                    width: 26.0,
                    height: 26.0,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.6,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(24),
                  color: Colors.white,
                ),
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.05,
              ),
              Center(
                child: Container(
                    width: double.infinity, height: 16.0, color: Colors.white),
              ),
            ],
          )),
    );
  }
}

class ProductWidget extends StatelessWidget {
  const ProductWidget({super.key, required this.data});

  final ProductInfoModel data;
  @override
  Widget build(BuildContext context) {

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 12.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
              const BackButton(
                color: Colors.black,
              ),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Text(
                    data.title.toString(),
                    style: GoogleFonts.lato(
                        color: Colors.blue,
                        fontSize: 21,
                        fontWeight: FontWeight.w500),
                    maxLines: 2,
                    softWrap: true,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              Text(
                "\$ ${data.price}",
                style: GoogleFonts.alkatra(color: Colors.green, fontSize: 18),
                textAlign: TextAlign.end,
              )
            ]),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Flexible(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(24),
                child: Hero(
                  tag: "${data.image.toString()}/HomePage",
                  transitionOnUserGestures: true,
                  flightShuttleBuilder: (flightContext, animation, direction, fromContext, toContext) {
                    // Use different animations for push and pop
                    return AnimatedBuilder(
                      animation: animation,
                      child: Image.network(data.image!),
                      builder: (context, child) {
                        // Customize animation for push and pop
                        final value = direction == HeroFlightDirection.push
                            ? animation.value
                            : (1.0 - animation.value);  // Slow down pop

                        return Transform.scale(
                          scale: 1.0 + (0.5 * value),  // Scale it smoothly
                          child: child,
                        );
                      },
                    );
                  },
                  child: CachedNetworkImage(
                    key: UniqueKey(),
                    width: MediaQuery.of(context).size.width * 0.6,
                    height: MediaQuery.of(context).size.height * 0.8,
                    imageUrl: data.image.toString(),
                    fit: BoxFit.fill,
                    placeholder: (context, url) =>
                        SizedBox(
                          height: 24.0,
                          width: 24.0,
                          child: const CircularProgressIndicator(
                            backgroundColor: Colors.blue,
                            valueColor: AlwaysStoppedAnimation(Colors.yellow),
                          ),
                        ),
                    errorWidget: (context, url, error) =>
                        Container(
                          width: MediaQuery.of(context).size.width * 0.04,
                          height: MediaQuery.of(context).size.height * 0.04,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24),
                            gradient: LinearGradient(colors: [
                              Colors.lightBlue,
                              Colors.indigoAccent
                            ])
                          ),
                          child: Icon(Icons.error, color: Colors.red, size: 32,)
                        ),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height * 0.05,
            ),
            Center(
              child: Text('"${data.description.toString()}"',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.alkatra(
                      color: Colors.grey,
                      fontSize: 18,
                      fontStyle: FontStyle.italic)),
            ),
            RatingBuilder(
              rating: data.rating!.rate ?? 0,
            ),
          ],
        ),
      ),
    );
  }
}
