class CallNumberData {
  bool? isWin;
  List<String>? listNumber;
  String? currentNumber;

  CallNumberData({this.isWin, this.listNumber, this.currentNumber});

  CallNumberData.fromJson(Map<String, dynamic> json) {
    isWin = json['isWin'];
    listNumber = json['listNumber'].cast<String>();
    currentNumber = json['currentNumber'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = Map<String, dynamic>();
    data['isWin'] = this.isWin;
    data['listNumber'] = this.listNumber;
    data['currentNumber'] = this.currentNumber;
    return data;
  }
}