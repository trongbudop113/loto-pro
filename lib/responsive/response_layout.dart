import 'package:flutter/material.dart';
import 'package:loto/responsive/divider_layout.dart';
import 'package:loto/responsive/screen_size_config.dart';
import 'package:loto/responsive/screen_size_type.dart';

class ResponsiveLayout{
  static List<Widget> getRowResponsive<T extends DividerLayoutModel>(
      {required List<T> list, required Widget Function(T item, DeviceScreen key) createWidget}) {

    var ls = <Widget>[];
    int stt = 0;
    while (stt < list.length) {
      var sumRow = 0;
      List<Widget> listRow = [];
      for (int i = stt; i < list.length && sumRow <= DividerLayoutModel.numberOfRow; i++) {
        var item = list[i];
        if ((sumRow + (item.listResponsiveScreens[DividerLayoutModel.key.value] as int)) <= item.sumRow) {
          if((item.listResponsiveScreens[DividerLayoutModel.key.value] as int) > 0){
            listRow.add(
                Flexible(
                    flex: (item.listResponsiveScreens[DividerLayoutModel.key.value] as int),
                    child: createWidget(item, DividerLayoutModel.key.value)
                )
            );
            sumRow = sumRow + (item.listResponsiveScreens[DividerLayoutModel.key.value] as int);
          }
          stt += 1;
        } else {
          if (item.sumRow - sumRow != 0) {
            listRow.add(
                Flexible(
                    flex: item.sumRow - sumRow,
                    child: const SizedBox()
                )
            );
            sumRow = item.sumRow;
          }
        }
      }
      if (listRow.isNotEmpty) {
        ls.add(Row(
          children: listRow,
        ));
      }
    }
    return ls;
  }

  static void updateKeyScreen(){
    DividerLayoutModel.key.value = ScreenSizeType.getScreenType();
  }
}