class HomeModel
{
  bool? status;
  DataModel? data;
  HomeModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    data = json['data'] != null ? DataModel.fromJson(json['data']) : null;
  }

}

class DataModel
{
    List<BannersModel> bannersModel = [];
    List<ProductsModel>  productsModel = [];

    DataModel.fromJson(Map<String , dynamic> json)
    {
          json['banners'].forEach(
              (value){
                bannersModel.add(BannersModel.fromJson(value['id'], value['image']));
              }
          );
          json['products'].forEach(
              (value){
                productsModel.add(ProductsModel.fromJson(value));
              }
          );
    }
}
class BannersModel
{
  final int id ;
  final String image;

  BannersModel.fromJson(this.id, this.image);

}
class ProductsModel
{
   late int id ;
   dynamic price ;
   dynamic oldPrice ;
   dynamic discount ;
   late String name ;
   late String image;
   late bool inFavorites;
   late bool inCart;

   ProductsModel.fromJson(Map<String , dynamic> json)
{
  id = json['id'];
  name=json['name'];
  price = json['price'];
  oldPrice = json['old_price'];
  discount = json['discount'];
  image = json['image'];
  inFavorites = json['in_favorites'];
  inCart = json['in_cart'];
}



}

