import 'package:get/get.dart';

class StatusOrder{
  int? statusID;
  String? statusName;
  RxBool isSelected = false.obs;

  StatusOrder({this.statusID, this.statusName});


  static List<StatusOrder> listStatusExample(){
    return [
      StatusOrder(statusID: 1, statusName: "Đã nhận đơn"),
      StatusOrder(statusID: 2, statusName: "Đang thực hiện"),
      StatusOrder(statusID: 3, statusName: "Đang giao tới"),
      StatusOrder(statusID: 4, statusName: "Hoàn thành"),
      StatusOrder(statusID: 5, statusName: "Hủy đơn"),
    ];
  }

  static List<StatusOrder> listFilterExample(){
    return [
      StatusOrder(statusID: 1, statusName: "Tất cả"),
      StatusOrder(statusID: 150, statusName: "150g"),
      StatusOrder(statusID: 200, statusName: "200g"),
    ];
  }
}