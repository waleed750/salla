import 'package:salla/models/home_model.dart';

class FavoriteModel
{
  bool? status ;

  FavoriteDataModel? data;

  FavoriteModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    print('json : ${json['data']}');
    data = json['data'] != null ? FavoriteDataModel.fromJson(json['data']) : null;
    print('data current page : ${data!.currentPage}');
  }
}
class FavoriteDataModel
{
  int currentPage = 0 ;
  List<FavoriteData> favorites = [] ;
  FavoriteDataModel.fromJson(Map<String , dynamic> json )
  {
    currentPage = json['current_page'];
    /*print('json : ${json['data']}');*/
    json['data'].forEach((value){
        favorites.add(FavoriteData.fromJson(value));
    });
  }
}

class FavoriteData
{
    int? id ;
    Product? product;
    FavoriteData.fromJson(Map<String , dynamic> json)
    {
      id = json['id'];

      product = Product.fromJson(json['product']);

    }
}

class Product
{
  int? id ;
  dynamic oldPrice ;
  dynamic price ;
  dynamic discount ;
  String? image ;
  String? name ;
  String? description;

  Product.fromJson(Map<String , dynamic> json)
  {
    id = json['id'];
    oldPrice = json['old_price'];
    price = json['price'];
    discount = json['discount'];
    image = json['image'];
    name = json['name'];
    description = json['description'];
  }
}