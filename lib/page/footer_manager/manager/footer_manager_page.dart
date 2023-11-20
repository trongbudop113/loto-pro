import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/footer_manager/manager/footer_manager_controller.dart';
import 'package:loto/page/footer_manager/models/footer_menu.dart';

class FooterManagerPage extends GetView<FooterManagerController> {
  const FooterManagerPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("footer_manager".tr),
      ),
      body: ListView.builder(
        itemCount: controller.vehicles.length,
        itemBuilder: (context, i) {
          return ExpansionTile(
            initiallyExpanded: true,
            title: Text(
              controller.vehicles[i].title,
              style: TextStyle(
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            children: <Widget>[
              Column(
                children: _buildExpandableContent(
                  controller.vehicles[i],
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  _buildExpandableContent(Vehicle vehicle) {
    List<Widget> columnContent = [];

    for (String content in vehicle.contents) {
      columnContent.add(
        ListTile(
          title: Text(
            content,
            style: TextStyle(fontSize: 18.0),
          ),
          subtitle: Row(
            children: [
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.redAccent,
                  child: Icon(Icons.remove_red_eye),
                ),
                onTap: (){
                  controller.goToShowPage();
                },
              ),
              SizedBox(
                width: 10,
              ),
              GestureDetector(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Colors.blueAccent,
                  child: Icon(Icons.edit),
                ),
                onTap: (){
                  controller.goToEditPage();
                },
              ),
            ],
          ),
          leading: Icon(vehicle.icon),
          onTap: (){
            controller.goToEditPage();
          },
        ),
      );
    }

    return columnContent;
  }
}
