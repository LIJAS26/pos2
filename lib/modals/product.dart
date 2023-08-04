// @dart=2.9
class Product{
  String image;
  String name;
  String description="this is a test description";
  double price;
  String category;
  var colours;
  var images;
  var sizes;
  String subCategory;
  int orderLimit;
  String id;
  int quantity=0;
  Product(this.image,this.name, this.price,this.category,this.colours,this.images,this.sizes,this.subCategory,this.orderLimit,this.id);
  Product.fromMapObject(Map<String,dynamic> map){
    this.name=map['name'];
    this.image=map['image'];
    this.price=double.parse(map['price']);
    this.category=map['category'];
    this.colours=map['color'];
    this.images=map['imageId'];
    this.sizes=map['size'];
    this.subCategory=map['subCategory'];
    this.orderLimit=map['orderLimit'];
    this.id=map['id'];




  }
}