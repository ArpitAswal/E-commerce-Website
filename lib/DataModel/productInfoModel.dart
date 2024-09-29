import 'Rating.dart';

class ProductInfoModel {
  int? id;
  String? title;
  double? price;
  String? category;
  String? description;
  String? image;
  Rating? rating;

  ProductInfoModel(
      {this.id,
        this.title,
        this.price,
        this.category,
        this.description,
        this.image,
        this.rating,});

  ProductInfoModel.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    title = json['title'];
    price = json['price'];
    category = json['category'];
    description = json['description'];
    image = json['image'];
    rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['title'] = title;
    data['price'] = price;
    data['category'] = category;
    data['description'] = description;
    data['image'] = image;
    if (rating != null) {
      data['rating'] = rating?.toJson();
    }
    return data;
  }
}