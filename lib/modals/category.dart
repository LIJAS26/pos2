// @dart=2.9
class Brands{

  String category;
  String image;
  String id;
  Brands( this.category, this.image);
  Brands.fromMapObject(Map<String,dynamic> map){

    this.category=map['name'];
    this.image=map['image'];
     this.id=map['id'];



  }


}