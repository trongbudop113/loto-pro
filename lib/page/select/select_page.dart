
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
          GestureDetector(
            onLongPress: (){
              controller.goToManager();
            },
            child: Container(
              width: 60,
              color: Color(0xFFFC29BD),
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
              padding: EdgeInsets.all(10),
              itemCount: paperList.length,
              itemBuilder: (context, index) {

                var data = controller.covertData(paperList[index].data() as Map<String, dynamic>);

                return GestureDetector(
                  onTap: (){
                    controller.onSelectPaper();
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(controller.convertColor(data.color ?? '')),
                      borderRadius: BorderRadius.circular(5)
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(data.paperName ?? '', style: TextStyle(color: Colors.white, fontSize: 18)),
                        Visibility(
                          visible: (data.selectedName ?? '').isNotEmpty,
                          child: Text("Thạch chọn"),
                        )
                      ],
                    ),
                  ),
                );
              },
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
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