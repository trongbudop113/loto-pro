import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/contact/models/send_contact.dart';
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
      body: StreamBuilder<QuerySnapshot<Object?>>(
        stream: controller.streamGetListContact(),
        builder: (c, snapshot){
          if(!snapshot.hasData){
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView.separated(
              itemBuilder: (c, i){
                SendContact sendContact = SendContact.fromJson(snapshot.data!.docs[i].data() as Map<String, dynamic>);
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
                  child: Row(
                    children: [
                      getStatusRead(sendContact.isRead ?? false),
                      SizedBox(width: 10,),
                      Container(
                        width: 100,
                        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 2),
                        color: Colors.grey,
                        child: Text(
                          "${sendContact.name}",
                          maxLines: 1,
                          style: TextStyleResource.textStyleWhite(context).copyWith(height: 1.5),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      SizedBox(width: 10),
                      Expanded(
                        child: Text(
                          "${sendContact.content}",
                          style: TextStyleResource.textStyleBlack(context).copyWith(height: 1.7),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                );
              },
              separatorBuilder: (c, i){
                return Container(height: 1, color: Colors.black87);
              },
              itemCount: snapshot.data!.docs.length
          );
        },
      ),
    );
  }

  Icon getStatusRead(bool isRead){
    if(!isRead) return const Icon(Icons.done, color: Colors.grey,);
    return const Icon(Icons.done_all , color: Colors.green,);
  }
}