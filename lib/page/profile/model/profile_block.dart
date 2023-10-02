class ProfileBlock{
  String? blockName;
  String? page;
  String? icon;
  ProfileType? type;

  ProfileBlock({this.blockName, this.icon, this.page, this.type});
}

enum ProfileType{
  ThemeMode,
  Language,
  Products
}