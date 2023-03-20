class MenuCategory{
  String? imageMenu;
  String? name;
  String? id;

  MenuCategory({this.name, this.id, this.imageMenu});


  static List<MenuCategory> listEx(){
    return [
      MenuCategory(imageMenu: "", name: "Lô Tô", id: "1"),
      MenuCategory(imageMenu: "", name: "Cờ Caro", id: "2"),
      MenuCategory(imageMenu: "", name: "Test", id: "3"),
    ];
  }

}