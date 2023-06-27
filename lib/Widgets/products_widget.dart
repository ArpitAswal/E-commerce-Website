import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:iconly/iconly.dart';
import 'package:ecommerce_shopping_website/APIModel/Products.dart';
import 'package:page_transition/page_transition.dart';
import 'package:provider/provider.dart';
import '../Screens/products_details_screen.dart';
import 'cart_calling.dart';

class ProductsWidget extends StatefulWidget {
   const ProductsWidget({Key? key}) : super(key: key);

  @override
  State<ProductsWidget> createState() => _ProductsWidgetState();
}

class _ProductsWidgetState extends State<ProductsWidget> {
  bool _click=false;

  @override
  Widget build(BuildContext context) {
    final productsProvider = Provider.of<Products>(context);
    return  Padding(
      padding: const EdgeInsets.all(2.0),
      child: Material(
        borderRadius: BorderRadius.circular(8.0),
        elevation: 7,
        color: Theme.of(context).cardColor,
        child: InkWell(
          borderRadius: BorderRadius.circular(8.0),
          onTap: () {
            Navigator.push(context, PageTransition(type: PageTransitionType.bottomToTop, child: ProductDetails(id: productsProvider.id.toString(),),),);
          },
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4,vertical: 3),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: RichText(
                        text: TextSpan(
                            text: '\$ ',
                            style: const TextStyle(
                                color: Colors.green,
                                fontWeight: FontWeight.w800,fontSize: 18),
                            children: <TextSpan>[
                              TextSpan(
                                  text: "${productsProvider.price}",
                                  style: const TextStyle(
                                      color: Colors.green,
                                      fontWeight: FontWeight.w600)),
                            ]),
                      ),
                    ),
                    Container(
                      alignment: Alignment.topCenter,
                      decoration: BoxDecoration(
                        color: (_click)?Colors.white:Colors.grey[200],
                        shape: BoxShape.circle
                      ),
                      child: IconButton(onPressed: (){
                        (_click)? CartCalling().del(productsProvider.id):
                        CartCalling().add(productsProvider.id,productsProvider.title,productsProvider.price,productsProvider.description,productsProvider.category,productsProvider.image);

                          _click=!_click;
                        setState(() {

                        });
                      }, icon: Icon(IconlyBold.heart,color: (_click)?Colors.red:Colors.white,)),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: FancyShimmerImage(
                    height: MediaQuery.of(context).size.height * 0.2,
                    width: double.infinity,
                    errorWidget: const Icon(
                      IconlyBold.danger,
                      color: Colors.red,
                      size: 28,
                    ),
                    imageUrl: productsProvider.image!,
                    boxFit: BoxFit.fill,
                  )),
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6.0,vertical: 4),
                  child: Center(
                    child: Text(
                      productsProvider.title.toString(),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 3,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}