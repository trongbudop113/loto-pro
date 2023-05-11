class CategoryPaper{
  String? paperID;
  String? paperName;
  bool? isAdd;
  String? color;
  String? categoryID;

  CategoryPaper({this.color, this.paperName, this.isAdd, this.paperID, this.categoryID});

  CategoryPaper.fromJson(Map<String, dynamic> json) {
    paperID = json['paperID'];
    color = json['color'];
    isAdd = json['isAdd'];
    paperName = json['paperName'];
    categoryID = json['categoryID'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['paperID'] = this.paperID;
    data['color'] = this.color;
    data['isAdd'] = this.isAdd;
    data['paperName'] = this.paperName;
    data['categoryID'] = this.categoryID;
    return data;
  }
}