class RecipeType{
  int? typeID;
  String? typeName;

  RecipeType({this.typeID, this.typeName});

  static List<RecipeType> listType(){
    return [
      RecipeType(typeID: 1, typeName: "Chính"),
      RecipeType(typeID: 2, typeName: "Phụ"),
    ];
  }
}