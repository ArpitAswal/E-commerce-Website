import 'package:card_swiper/card_swiper.dart';
import 'package:ecommerce_shopping_website/ProvidersClass/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SwiperWidget extends StatelessWidget {
  const SwiperWidget(this.gender, {super.key});
  final String gender;

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ProductsProvider>(context, listen: false);
    double height = MediaQuery.of(context).size.height;

    return Container(
      height: height * 0.3,
      margin: const EdgeInsets.all(4.0),
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
        itemCount: provider.mens.length,
        itemBuilder: (ctx, index) {
          return (gender == 'Men')
              ? SaleWidget(item: provider.mens[index].entries)
              : SaleWidget(item: provider.women[index].entries);
        },
        autoplay: true,
        pagination: const SwiperPagination(
            margin: EdgeInsets.only(right: 10, bottom: 5),
            alignment: Alignment.bottomRight,
            builder: DotSwiperPaginationBuilder(
                color: Colors.white, activeColor: Colors.red)),
            control: const SwiperControl(
            color: Colors.white,
            disableColor: Colors.red,
            size: 18,
            padding: EdgeInsets.all(2)),
      ),
    );
  }
}

class SaleWidget extends StatelessWidget {
  const SaleWidget({super.key, required this.item});

  final Iterable<MapEntry<String, int>> item;
  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        height: double.infinity,
        margin: EdgeInsets.only(bottom: 20.0, top: 16.0, left: 16.0, right: 16.0 ),
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
              tileMode: TileMode.clamp),
        ),
        child: SizedBox(
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Container(
                  height: MediaQuery.of(context).size.height * 0.12,
                  decoration: BoxDecoration(
                    color: const Color(0xFF9689CE),
                    borderRadius: BorderRadius.circular(18),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.white,
                        blurRadius: 6.0,
                        spreadRadius: 3.0
                      ),
                    ]
                  ),
                  padding: EdgeInsets.symmetric(vertical: 12.0, horizontal: 6.0),
                  margin: EdgeInsets.all(8.0),
                  alignment: Alignment.center,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: RichText(
                        textAlign: TextAlign.center,
                        softWrap: true,
                        text: TextSpan(
                      text: "Special\nDiscount\n",
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w400,
                        fontStyle: FontStyle.italic,
                        fontSize: 21
                      ),
                      children: <TextSpan>[
                        TextSpan(
                          text: "${item.single.value.toString()}%",
                          style: TextStyle(
                              color: Colors.red,
                              fontWeight: FontWeight.bold,
                              fontSize: 28,
                          ),
                        )
                      ]
                    )),
                  ),

                ),
              ),
              Flexible(
                flex: 5,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(14),
                  child: Image.network(
                    height: double.infinity,
                    width: double.infinity,
                    item.single.key,
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
