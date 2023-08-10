
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/paper_manager/paper_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class PaperManagerPage extends GetView<PaperManagerController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("Chỉnh sửa", style: TextStyleResource.textStyleBlack(context)),
          actions: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                GestureDetector(
                  onTap: (){
                    controller.onClickDone();
                  },
                  child: Container(
                    width: 35,
                    height: 35,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(360),
                      color: Colors.white,
                    ),
                    child: const Icon(Icons.done, color: Colors.green,),
                  ),
                )
              ],
            ),
            const SizedBox(width: 15)
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Column(
                children: [
                  SizedBox(height: 15),
                  GestureDetector(
                    child: Container(
                      color: Colors.transparent,
                      child: Row(
                        children: [
                          const SizedBox(width: 10),
                          Text("Chọn màu:", style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18)),
                          const SizedBox(width: 20),
                          Obx(() => Container(
                            width: 100,
                            height: 30,
                            color: controller.colorPaper.value == 0
                                ? Colors.black87 : Color(controller.convertColor(controller.selectPaper.value.color!)),
                          ))
                        ],
                      ),
                    ),
                    onTap: (){
                      controller.showDialogSelectColorPaper(context);
                    },
                  ),
                  SizedBox(height: 15),
                  Obx(() => Container(
                    child: Row(
                      children: [
                        const SizedBox(width: 10),
                        Text("Tên tờ:", style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18)),
                        const SizedBox(width: 20),
                        Text(controller.namePaper.value, style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 18))
                      ],
                    ),
                  )),
                  const SizedBox(height: 20),
                ],
              ),
              Obx(() => buildContent1(context))
            ],
          ),
        )
    );
  }

  Widget buildContent1(BuildContext context){

    return Visibility(
        visible: controller.isHasData.value,
        child: CustomScrollView(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          slivers: controller.listRow.asMap().entries.map((e) {
            if(e.value.typeFull ?? true){
              return const SliverPadding(padding: EdgeInsets.symmetric(vertical: 10));
            }else{
              return SliverGrid.count(
                crossAxisCount: 9,
                childAspectRatio: 0.5,
                children: (e.value.items ?? []).asMap().entries.map((child) {
                  return Obx(() => GestureDetector(
                    onTap: (){
                      controller.onTapItem(e.key, child.key, context);
                    },
                    child: Container(
                      decoration: BoxDecoration(
                          color: child.value.number?.value == 0 ? Color(controller.colorPaper.value) : Colors.white,
                          border: Border.all(width: 0.5)
                      ),
                      alignment: Alignment.center,
                      child: Visibility(
                        visible: (child.value.number?.value ?? 0) > 0,
                        child: Text(
                            (child.value.number?.value ?? 0).toString(),
                            style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 16)
                        ),
                      ),
                    ),
                  ));
                }).toList()
              );
            }
          }).toList()
        )
    );

  }

}