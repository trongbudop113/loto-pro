import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class FormatUtils{
  static final oCcy = NumberFormat("#,##0", "en_US");

  static String formatCurrency(double d) {
    return "${FormatUtils.oCcy.format(d)}đ";
  }

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
      case 5 : {
        return "Hủy đơn";
      }
      default: {
        return "Đã nhận đơn";
      }
    }
  }

  static Color orderStatusColor(int status){
    switch (status) {
      case 1 : {
        return Colors.yellow;
      }
      case 2 : {
        return Colors.greenAccent;
      }
      case 3 : {
        return Colors.greenAccent;
      }
      case 4 : {
        return Colors.green;
      }
      case 5 : {
        return Colors.red;
      }
      default: {
        return Colors.yellow;
      }
    }
  }
}