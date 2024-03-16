import 'package:intl/intl.dart';

class FormatUtils{
  static final oCcy = NumberFormat("#,##0", "en_US");

  static String formatOrderStatus(int status){
    switch (status) {
      case 1 : {
        return "Đã nhận đơn";
      }
      case 2 : {
        return "Đang thực hiện";
      }
      case 3 : {
        return "Đang giao tới";
      }
      case 4 : {
        return "Hoàn thành";
      }
      default: {
        return "Đã nhận đơn";
      }
    }
  }
}