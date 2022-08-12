class CategoryModel{

  late bool status;
  CategoryDataModel? dataModel ;
  CategoryModel.fromJson({
    required Map<String , dynamic> json
  }){
    status = json['status'];
    dataModel = CategoryDataModel.fromJson(json: json['data']);
  }
}

class CategoryDataModel {
  int? current_page;

  List<CategoryData>? catergories = [];

  CategoryDataModel.fromJson({
    Map<String , dynamic>? json
  }){
    current_page = json!['current_page'];
    for(var element in json['data'])
    {
      catergories!.add(CategoryData.fromJson(json: element));
    }
  }
}

class CategoryData{
  late int id;
  late String name ;
  late String image ;
  CategoryData.fromJson({
    required Map<String , dynamic> json
  }){
    id = json['id'];
    name = json['name'];
    image = json['image'];

  }

}