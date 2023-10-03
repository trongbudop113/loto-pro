import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/contact_manager/contact_manager_controller.dart';
import 'package:loto/src/style_resource.dart';

class ContactManagerPage extends GetView<ContactManagerController> {
  const ContactManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("contact_manager".tr),
      ),
      body: ListView.separated(
        itemBuilder: (c, i){
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
            child: Row(
              children: [
                Container(
                  width: 100,
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                  color: Colors.grey,
                  child: Text(
                    "Trong",
                    maxLines: 1,
                    style: TextStyleResource.textStyleWhite(context).copyWith(height: 1.5),
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Text(
                    "View tesdt test's profile on LinkedIn, the world's largest professional community",
                    style: TextStyleResource.textStyleBlack(context).copyWith(height: 1.5),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            ),
          );
        },
        separatorBuilder: (c, i){
          return Container(height: 1, color: Colors.grey);
        },
        itemCount: 10
      ),
    );
  }
}