class CategoriesModel{
  bool? state;
  CategoriesDataModel? data;

  CategoriesModel.fromJson(Map<String,dynamic> json){
    state = json["state"];
    data = CategoriesDataModel.fromJson(json["data"]);
  }


}

class CategoriesDataModel{
  
  List<CategoriesAllDataModel>? data;

  CategoriesDataModel.fromJson(Map<String,dynamic> json){

    data = List<CategoriesAllDataModel>.from(json["data"].map((element) => CategoriesAllDataModel.fromJson(element),),);

  }
  
}

class CategoriesAllDataModel{
  int? id;
  String? name;
  String? image;

  CategoriesAllDataModel.fromJson(Map<String,dynamic> json){
    id = json["id"];
    name = json["name"];
    image = json["image"];
  }
  
}