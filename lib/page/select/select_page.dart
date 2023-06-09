
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/select/select_controller.dart';

class SelectPage extends GetView<SelectController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          Obx(() => Visibility(
            visible: controller.isAdmin.value,
            child: Row(
              children: [
                GestureDetector(
                  onTap: (){
                    controller.goToAddPaper();
                  },
                  child: Container(
                    width: 60,
                    child: Icon(Icons.add_box_outlined),
                  ),
                ),
                SizedBox(width: 15),
                GestureDetector(
                  onTap: (){
                    controller.goToManager();
                  },
                  child: Container(
                    width: 60,
                    child: Icon(Icons.edit_calendar_rounded),
                  ),
                )
              ],
            ),
          )),
          SizedBox(width: 15),
          GestureDetector(
            onTap: (){
              controller.onPlayGame();
            },
            child: Container(
              color: Colors.transparent,
              padding: EdgeInsets.symmetric(horizontal: 15),
              alignment: Alignment.center,
              child: Text('Vào chơi', style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
            ),
          )
        ],
      ),
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamGetPapers(),
        builder: (context, snapShot) {
          if (snapShot.connectionState == ConnectionState.active) {
            var paperList = snapShot.data?.docs ?? [];
            return GridView.builder(
              padding: const EdgeInsets.all(10),
              itemCount: paperList.length,
              itemBuilder: (context, index) {

                var data = controller.covertData(paperList[index].data() as Map<String, dynamic>);

                return GestureDetector(
                  onTap: (){
                    controller.onSelectPaper(data);
                  },
                  onLongPress: (){
                    controller.onEditPaper(data);
                  },
                  child: Container(
                    decoration: BoxDecoration(
                        color: Color(controller.convertColor(data.color ?? '')),
                        borderRadius: BorderRadius.circular(5)
                    ),
                    child: Stack(
                      children: [
                        Container(
                          alignment: Alignment.center,
                          child: Text(data.paperName ?? '', style: const TextStyle(color: Colors.white, fontSize: 18)),
                        ),
                        Visibility(
                          visible: (data.selectedName ?? '').isNotEmpty,
                          child: Positioned(
                            top: 0,
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: Container(
                              color: Colors.black.withOpacity(0.5),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 40,
                                    height: 40,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(360),
                                        color: Colors.greenAccent
                                    ),
                                    child: Icon(Icons.done, color: Colors.white),
                                  ),
                                  SizedBox(height: 15),
                                  Text((data.selectedName ?? '') + "\nđã chọn", style: TextStyle(color: Colors.white, fontSize: 18), textAlign: TextAlign.center)
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1,
                mainAxisSpacing: 10,
                crossAxisSpacing: 10,
              ),
            );
          }

          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )
    );
  }

}