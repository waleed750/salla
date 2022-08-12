class SearchProducts {
  bool? status;
  String? message;
  ProductData? data;
  SearchProducts.fromJson({
    this.status ,
    this.message,
    required Map<String , dynamic> json
})
  {
    status = json["status"];
    message = json["message"];
    data =  ProductData.fromJson(json: json["data"]);
  }
}
class ProductData{
   List<ProductSearchModel> products = [];
   ProductData.fromJson({
     required Map<String , dynamic> json
})
    {
        for(var element in json["data"])
          {
            products.add( ProductSearchModel.fromJson(element ) );
          }
    }

}
class ProductSearchModel {
  late int id ;
  dynamic price ;
  String? image;
  String? name ;
  bool? in_favourtie ;
  bool? in_cart;
  ProductSearchModel.fromJson(
      Map<String , dynamic> json
      ){
    id = json['id'];
    price = json['price'];
    image = json['image'];
    name = json['name'];
    in_favourtie = json['in_favorites'];
    in_cart = json['in_cart'];
  }
}