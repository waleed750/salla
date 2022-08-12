class ShopLoginModel
{
  bool? status ;
  String? message ;
  Userdata? data;

  ShopLoginModel.fromJson(Map<String , dynamic> json)
  {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? Userdata.fromJson(json['data']) : null  ;
  }
}

class Userdata
{
  late int id ;
  late String name ;
  late String email ;
  late String phone ;
  late String image ;
  late int points ;
  late int credit ;
  late String token ;

  Userdata.fromJson(
      Map<String , dynamic> json
      ){
    id = json['id'];
    name = json['name'];
    email = json['email'];
    phone = json['phone'];
    image = json['image'];
    points = json['points']??0;
    credit = json['credit']??0;
    token = json['token'];

  }
}