import 'package:ecommerce_shopping_website/Global/Colors.dart';
import 'package:flutter/material.dart';
import 'package:lazy_load_scrollview/lazy_load_scrollview.dart';
import 'package:page_transition/page_transition.dart';
import '../Widgets/categoryWidget.dart';
import 'individualCategory.dart';

class AllCategory extends StatefulWidget {
  const AllCategory({Key? key}) : super(key: key);

  @override
  State<AllCategory> createState() => _AllCategoryState();
}

class Category {
  Map<String, String> categ;
  Category(this.categ);
}

List<Category> content = [
  Category({'assets/allcategImage/anime_t-shirt.jpg': 'Anime T-shirt'}),
  Category({'assets/allcategImage/babywear.jpg': 'Baby Wear'}),
  Category(
    {'assets/allcategImage/womenkurti.jpg': "Women's Kurti"},
  ),
  Category(
    {'assets/allcategImage/bluetoothspeaker.jpg': 'Bluetooth Speaker'},
  ),
  Category(
    {'assets/allcategImage/eyewear.jpg': 'Sunglasses'},
  ),
  Category(
    {'assets/allcategImage/handbags.jpg': 'Handbags'},
  ),
  Category(
    {'assets/allcategImage/hoodie.jpg': 'Hoodie'},
  ),
  Category(
    {'assets/allcategImage/women_jewelery.jpg': "Women's Jewelery"},
  ),
  Category(
    {'assets/allcategImage/leather_formershoe.jpg': 'Leather Former Shoe'},
  ),
  Category(
    {'assets/allcategImage/smartphone.jpg': 'Smartphone'},
  ),
  Category(
    {'assets/allcategImage/sportsshoe.jpg': 'Sports Shoe'},
  ),
  Category(
    {'assets/allcategImage/womenfootwear.jpg': "Women's Footwear"},
  ),
  Category(
    {'assets/allcategImage/mencasual_T-shirt.jpg': "Men's Casual"},
  ),
  Category(
    {'assets/allcategImage/women_sandals.jpg': "Women's Sandals"},
  ),
  Category(
    {'assets/allcategImage/women_saree.jpg': "Women's Saree"},
  ),
  Category({'assets/allcategImage/zarthashirt.jpg': 'Zartha Shirt'}),
  Category({'assets/allcategImage/facecream.jpg': 'Face Cream'}),
  Category({'assets/allcategImage/jeans.jpg': 'Jeans'}),
  Category({'assets/allcategImage/men_formalsuit.jpg': "Men's Formal Suit"})
];
bool searchwidget = false;

List<Category> searchCategory = [];

class _AllCategoryState extends State<AllCategory> {
  bool isLoading = false;
  final ScrollController _controller = ScrollController();
  void scrollEnd() {
    isLoading = true;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Search'),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                setState(() {
                  searchwidget = true;
                  showSearch(context: context, delegate: Searchdelegate());
                  searchwidget = false;
                });
              },
            )
          ],
        ),
        body: (searchwidget)
            ? Container()
            : SingleChildScrollView(
                controller: _controller,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 15.0, horizontal: 10.0),
                  child: LazyLoadScrollView(
                    isLoading: isLoading,
                    onEndOfPage: () => scrollEnd(),
                    child: GridView.builder(
                        shrinkWrap: true,
                        itemCount: content.length,
                        scrollDirection: Axis.vertical,
                        physics: const AlwaysScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithMaxCrossAxisExtent(
                          crossAxisSpacing: 10.0,
                          mainAxisSpacing: 10.0,
                          maxCrossAxisExtent: 300,
                        ),
                        itemBuilder: (ctx, index) {
                          return InkWell(
                              // borderRadius: BorderRadius.circular(8.0),
                              onTap: () {
                                Navigator.push(
                                    context,
                                    PageTransition(
                                        type: PageTransitionType.fade,
                                        child: IndividualCategory(
                                            title: content[index]
                                                .categ
                                                .values
                                                .toList()[0])));
                              },
                              child: CategoryWidget(
                                  image: content[index].categ.keys.toList()[0],
                                  name:
                                      content[index].categ.values.toList()[0]));
                        }),
                  ),
                ),
              ));
  }
}

class Searchdelegate extends SearchDelegate {
  int ind = 0;
  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        color: iconsColor,
        onPressed: () {
          query = '';
        },
      )
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      color: iconsColor,
      onPressed: () {
        searchwidget = false;
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    return CategoryWidget(
        image: searchCategory[ind].categ.keys.toList()[0],
        name: searchCategory[ind].categ.values.toList()[0]);
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    List<Category> suggestion = [];
    searchCategory.clear();
    for (int i = 0; i < content.length; i++) {
      if (content[i]
          .categ
          .values
          .toList()[0]
          .toLowerCase()
          .contains(query.toLowerCase())) {
        suggestion.add(Category({
          content[i].categ.keys.toList()[0]: content[i].categ.values.toList()[0]
        }));
      }
      if (i == content.length) {
        break;
      }
    }
    searchCategory.addAll(suggestion);
    debugPrint('new\n');
    return Container(
      height: MediaQuery.of(context).size.height,
      width: MediaQuery.of(context).size.width,
      color: Colors.white,
      child: ListView.builder(
          itemCount: suggestion.length,
          itemBuilder: (context, index) {
            return Column(
              children: [
                ListTile(
                  tileColor: Colors.white,
                  title: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 14.0),
                    child: Text(suggestion[index].categ.values.toList()[0]),
                  ),
                  titleTextStyle: const TextStyle(
                    fontSize: 26,
                    fontWeight: FontWeight.w500,
                    wordSpacing: 1.2,
                    letterSpacing: 1.2,
                  ),
                  minLeadingWidth: 30,
                  leading: CircleAvatar(
                    radius: 30,
                    backgroundColor: Colors.white,
                    child: Center(
                      child:
                          Image.asset(suggestion[index].categ.keys.toList()[0]),
                    ),
                  ),
                  onTap: () {
                    ind = index;
                    query = suggestion[index].categ.values.toList()[0];
                    showResults(context);
                  },
                ),
                const Divider(
                  thickness: 0.5,
                )
              ],
            );
          }),
    );
  }
}
