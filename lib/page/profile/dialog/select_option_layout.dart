import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/model/option_data.dart';
import 'package:loto/src/style_resource.dart';

class SelectOptionLayout extends StatelessWidget {
  final List<OptionData> listOption;
  final String title;
  const SelectOptionLayout({Key? key, required this.listOption, required this.title}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 350.0,
      color: Colors.transparent,
      child: Container(
          padding: const EdgeInsets.all(15),
          decoration: BoxDecoration(
              color: Theme.of(context).bottomSheetTheme.backgroundColor,
              borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(10.0),
                  topRight: Radius.circular(10.0)
              )
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                title.tr,
                style: TextStyleResource.textStyleCaption(context).copyWith(fontSize: 22),
              ),
              SizedBox(height: 15),
              Column(
                children: listOption.map((e) {
                  return GestureDetector(
                    onTap: (){
                      Get.back(result: e.value);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Text(
                                e.value!.tr,
                                style: TextStyleResource.textStyleBlack(context),
                              ),
                              Spacer(flex: 1),
                              Obx(() => Visibility(
                                visible: e.isSelected.value,
                                child: Container(
                                  width: 15,
                                  height: 15,
                                  color: Colors.amberAccent,
                                ),
                              ))
                            ],
                          ),
                          SizedBox(height: 10),
                          Container(
                            color: Colors.grey,
                            height: 1,
                          )
                        ],
                      ),
                    ),
                  );
                }).toList(),
              )
            ],
          )
      ),
    );
  }
}
