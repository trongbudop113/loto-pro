
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/contact/blocks/info_block.dart';
import 'package:loto/page/contact/blocks/send_contact_block.dart';
import 'package:loto/page/contact/contact_controller.dart';

class ContactPage extends GetView<ContactController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Obx(() => Visibility(
        visible: (controller.contactData.value.phone ?? '').isNotEmpty,
        child: SingleChildScrollView(
          child: Column(
            children: [
              InfoBlock(
                controller: controller,
              ),
              SendContactBlock(
                controller: controller,
              )
            ],
          ),
        ),
      )),
    );
  }
}

