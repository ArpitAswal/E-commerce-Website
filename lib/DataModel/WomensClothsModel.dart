/// id : 15
/// title : "BIYLACLESEN Women's 3-in-1 Snowboard Jacket Winter Coats"
/// price : 56.99
/// description : "Note:The Jackets is US standard size, Please choose size as your usual wear Material: 100% Polyester; Detachable Liner Fabric: Warm Fleece. Detachable Functional Liner: Skin Friendly, Lightweigt and Warm.Stand Collar Liner jacket, keep you warm in cold weather. Zippered Pockets: 2 Zippered Hand Pockets, 2 Zippered Pockets on Chest (enough to keep cards or keys)and 1 Hidden Pocket Inside.Zippered Hand Pockets and Hidden Pocket keep your things secure. Humanized Design: Adjustable and Detachable Hood and Adjustable cuff to prevent the wind and water,for a comfortable fit. 3 in 1 Detachable Design provide more convenience, you can separate the coat and inner as needed, or wear it together. It is suitable for different season and help you adapt to different climates"
/// category : "women's clothing"
/// image : "https://fakestoreapi.com/img/51Y5NI-I5jL._AC_UX679_.jpg"
/// rating : {"rate":2.6,"count":235}

class WomensClothsModel {
  WomensClothsModel({
      int? id,
      String? title, 
      double? price,
      String? description, 
      String? category, 
      String? image, 
      Rating? rating,}){
    _id = id;
    _title = title;
    _price = price;
    _description = description;
    _category = category;
    _image = image;
    _rating = rating;
}

  WomensClothsModel.fromJson(dynamic json) {
    _id = json['id'];
    _title = json['title'];
    _price = json['price'];
    _description = json['description'];
    _category = json['category'];
    _image = json['image'];
    _rating = json['rating'] != null ? Rating.fromJson(json['rating']) : null;
  }
  int? _id;
  String? _title;
  double? _price;
  String? _description;
  String? _category;
  String? _image;
  Rating? _rating;
WomensClothsModel copyWith({  int? id,
  String? title,
  double? price,
  String? description,
  String? category,
  String? image,
  Rating? rating,
}) => WomensClothsModel(  id: id ?? _id,
  title: title ?? _title,
  price: price ?? _price,
  description: description ?? _description,
  category: category ?? _category,
  image: image ?? _image,
  rating: rating ?? _rating,
);
  int? get id => _id;
  String? get title => _title;
  double? get price => _price;
  String? get description => _description;
  String? get category => _category;
  String? get image => _image;
  Rating? get rating => _rating;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['title'] = _title;
    map['price'] = _price;
    map['description'] = _description;
    map['category'] = _category;
    map['image'] = _image;
    if (_rating != null) {
      map['rating'] = _rating?.toJson();
    }
    return map;
  }

}

/// rate : 2.6
/// count : 235

class Rating {
  Rating({
      num? rate, 
      num? count,}){
    _rate = rate;
    _count = count;
}

  Rating.fromJson(dynamic json) {
    _rate = json['rate'];
    _count = json['count'];
  }
  num? _rate;
  num? _count;
Rating copyWith({  num? rate,
  num? count,
}) => Rating(  rate: rate ?? _rate,
  count: count ?? _count,
);
  num? get rate => _rate;
  num? get count => _count;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['rate'] = _rate;
    map['count'] = _count;
    return map;
  }

}