import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:iconly/iconly.dart';
import '../DataModel/JeweleryModel.dart';
import '../DataModel/MensClothsModel.dart';
import '../DataModel/WomensClothsModel.dart';
import '../Widgets/category2Widget.dart';
import '../Widgets/categoryWidget.dart';

class AnimeTshirt {
  Map<String, String> anime;
  AnimeTshirt(this.anime);
}

List<AnimeTshirt> images = [
  AnimeTshirt({'assets/AnimeTshirt/Acnologia_dark_tshirt.jpg': "Acnologia"}),
  AnimeTshirt({'assets/AnimeTshirt/Gojo_white_tshirt.jpg': "Satoru Gojo"}),
  AnimeTshirt({'assets/AnimeTshirt/Itachi_white_tshirt.jpg': "Itachi Uchiha"}),
  AnimeTshirt({'assets/AnimeTshirt/Kakashi_dark_tshirt.jpg': "Kakashi Hatake"}),
  AnimeTshirt({'assets/AnimeTshirt/Mikey_white_tshirt.jpg': "Mikey"}),
];

bool isError = false;

class IndividualCategory extends StatefulWidget {
  const IndividualCategory({
    Key? key,
    required this.title,
  }) : super(key: key);
  final String title;

  @override
  State<IndividualCategory> createState() => _IndividualCategoryState(title);
}

final List<JeweleryModel> jewelList = [];
final List<MensClothsModel> mensList = [];
final List<WomensClothsModel> womenList = [];

class _IndividualCategoryState extends State<IndividualCategory> {
  final ScrollController _controller = ScrollController();

  _IndividualCategoryState(this.name);
  String name;

  Future<void> getJewelery() async {
    try {
      final response = await http.get(
          Uri.parse('https://fakestoreapi.com/products/category/jewelery'));

      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        jewelList.clear();
        for (Map i in data) {
          jewelList.add(JeweleryModel.fromJson(i));
        }
      }
      debugPrint('${jewelList.length}');
    } catch (error) {
      isError = true;
      throw error.toString();
    }
  }

  Future<void> getMens() async {
    try {
      final response = await http.get(Uri.parse(
          "https://fakestoreapi.com/products/category/men's clothing"));

      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        mensList.clear();
        for (Map i in data) {
          mensList.add(MensClothsModel.fromJson(i));
        }
      }
      debugPrint('${mensList.length}');
    } catch (error) {
      isError = true;
      throw error.toString();
    }
  }

  Future<void> getWomens() async {
    try {
      final response = await http.get(Uri.parse(
          "https://fakestoreapi.com/products/category/women's clothing"));

      var data = jsonDecode(response.body.toString());
      if (response.statusCode == 200) {
        womenList.clear();
        for (Map i in data) {
          womenList.add(WomensClothsModel.fromJson(i));
        }
      }
      debugPrint('${womenList.length}');
    } catch (error) {
      isError = true;
      throw error.toString();
    }
  }

  @override
  void initState() {
    if (name.contains("Women's Jewelery")) {
      getJewelery();
    } else if (name.contains("Women's Kurti")) {
      getWomens();
    } else if (name.contains("Men's Casual")) {
      getMens();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: (isError)
          ? const Center(
              child: Column(
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
              ),
            )
          : (jewelList.isEmpty &&
                  images.isEmpty &&
                  mensList.isEmpty &&
                  womenList.isEmpty)
              ? const Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(),
                      SizedBox(
                        height: 5,
                      ),
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
              : Stack(children: [
                  SingleChildScrollView(
                    controller: _controller,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12.0, vertical: 12),
                          child: GridView.builder(
                              shrinkWrap: true,
                              itemCount: (name.contains("Women's Jewelery"))
                                  ? jewelList.length
                                  : (name.contains("Women's Kurti"))
                                      ? womenList.length
                                      : (name.contains("Men's Casual"))
                                          ? mensList.length
                                          : images.length,
                              scrollDirection: Axis.vertical,
                              physics: const AlwaysScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithMaxCrossAxisExtent(
                                crossAxisSpacing: 10.0,
                                mainAxisSpacing: 6.0,
                                maxCrossAxisExtent: 300,
                              ),
                              itemBuilder: (ctx, index) {
                                if (name.contains("Women's Jewelery")) {
                                  return Category2Widget(
                                      id: jewelList[index].id ?? -1,
                                      title: jewelList[index].title.toString(),
                                      price: jewelList[index].price,
                                      image: jewelList[index].image.toString(),
                                      category:
                                          jewelList[index].category.toString());
                                } else if (name.contains("Women's Kurti")) {
                                  return Category2Widget(
                                      id: womenList[index].id!,
                                      title: womenList[index].title.toString(),
                                      price: womenList[index].price,
                                      image: womenList[index].image.toString(),
                                      category: womenList[index]
                                          .category
                                          .toString());
                                } else if (name.contains("Men's Casual")) {
                                  return Category2Widget(
                                      id: mensList[index].id!,
                                      title: mensList[index].title.toString(),
                                      price: mensList[index].price,
                                      image: mensList[index].image.toString(),
                                      category:
                                          mensList[index].category.toString());
                                } else {
                                  return CategoryWidget(
                                      image:
                                          images[index].anime.keys.toList()[0],
                                      name: images[index]
                                          .anime
                                          .values
                                          .toList()[0]);
                                }
                              }),
                        ),
                      ],
                    ),
                  ),
                ]),
    );
  }
}
