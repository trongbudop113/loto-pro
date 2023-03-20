import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/menu/menu_controller.dart';
import 'package:loto/page_config.dart';
import 'package:loto/responsive/response_layout.dart';
import 'package:loto/responsive/screen_size_config.dart';
import 'package:loto/responsive/screen_widget_model.dart';

class MenuPage extends GetView<MenuController>{
  MenuPage({Key? key}) : super(key: key);


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> buildContent()),
    );
  }
  final List<Widget> listWidget=[];
  initListWidget(){
    List<WidgetContainer> list = [];
    for (int i = 0; i < controller.listMenu.length; i++) {
      list.add(WidgetContainer(
        responsiveScreens: const {
          DeviceScreen.mobile : 3,
          DeviceScreen.tablet: 3,
          DeviceScreen.desktop: 3,
        },
        child: InkWell(
          onTap: (){
            Get.toNamed(PageConfig.ROOM);
          },
          child: Container(
            color: Colors.transparent,
            child: Column(
              children: [
                Container(
                  color: Colors.transparent,
                  child: Image.asset('images/loto.png'),
                ),
                Text(controller.listMenu[i].name ?? '', style: TextStyle(fontSize: 50))
              ],
            ),
          ),
        ),
      ));
    }
    listWidget.clear();
    var listRp = ResponsiveLayout.getRowResponsive<WidgetContainer>(
        list: list, createWidget: (WidgetContainer item, DeviceScreen key) => item
    );
    listWidget.addAll(listRp);
  }

  Widget buildContent(){
    initListWidget();
    return Container(
      margin: EdgeInsets.all(10),
      child: ListView.builder(
        itemCount: listWidget.length,
        itemBuilder: (ctx, index){
          return listWidget[index];
        },
      ),
    );
  }

}