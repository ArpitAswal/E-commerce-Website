
class CartProducts{
  CartProducts({
    this.id,
    this.title,
    this.price,
    this.description,
    this.category,
    this.image,
    });

  Map<String, dynamic> toMap() => {
  "id" : id,
   "title" : title,
   "price" : price,
   "description" : description,
   "caregory"  : category,
    "image" : image,
  };

  int? id;
  String? title;
  double? price;
  String? description;
  String? category;
  String? image;
}