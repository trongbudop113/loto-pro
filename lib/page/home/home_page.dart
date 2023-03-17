import 'dart:async';


import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/home/home_controller.dart';
import 'package:loto/responsive/response_layout.dart';
import 'package:loto/responsive/screen_size_config.dart';
import 'package:loto/responsive/screen_widget_model.dart';

class HomePage extends GetView<HomeController>{

  HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Obx(()=> buildContent()),
    );
  }
  final List<Widget> listWidget=[];
  initListWidget(){
    List<WidgetContainer> list = [];
    for (int i = 0; i < controller.listData.length; i++) {
      var element = controller.listData[i];
      if(element.typeFull){
        list.add(WidgetContainer(
          responsiveScreens: const {
            DeviceScreen.mobile : 9,
            DeviceScreen.tablet: 9,
            DeviceScreen.desktop: 9,
          },
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(width: 1, color: Colors.black)
            ),
            padding: EdgeInsets.all(5),
            height: 40,
            alignment: Alignment.center,
            child: Text("---- Lô tô ----", style: TextStyle(fontSize: 18)),
          ),
        ));
      }else{
        for(int j = 0; j < element.items!.length; j++){
          list.add(WidgetContainer(
            child: GestureDetector(
              onTap: (){
                element.items![j].isCheck.value = !element.items![j].isCheck.value;
                controller.onTapNumber(i, j);
              },
              child: Container(
                decoration: BoxDecoration(
                    color: element.items![j].number! > 0 ? Colors.white : Colors.blue,
                    border: Border.all(width: 1, color: Colors.black)
                ),
                alignment: Alignment.center,
                height: 100,
                child: Visibility(
                    visible: element.items![j].number! > 0,
                    child: Stack(
                      children: [
                        Container(
                          // width: double.infinity,
                          // height: double.infinity,
                          alignment: Alignment.center,
                          child: Text(element.items![j].number.toString(), style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
                        ),
                        Obx(() => Visibility(
                          visible: element.items![j].isCheck.value,
                          child: Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Container(
                                  width: 40,
                                  height: 40,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.all(Radius.circular(360)),
                                      border: Border.all(
                                          width: 3,
                                          color: Colors.red
                                      )
                                  ),
                                )
                              ],
                            ),
                          ),
                        ))
                      ],
                    )
                ),
              ),
            ),
          ));
        }
      }
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
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: Colors.black)
      ),
      //padding: EdgeInsets.all(10),
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

