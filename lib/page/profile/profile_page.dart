import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/profile/profile_controller.dart';

class ProfilePage extends GetView<ProfileController>{

  @override
  Widget build(BuildContext context) {

    final int crossAxisCount = MediaQuery.of(context).size.width > 1000 ? 5 : (MediaQuery.of(context).size.width <= 600 ? 2 : 3);

    return Scaffold(
      appBar: AppBar(),
      body: GridView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: 3,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          childAspectRatio: 1,
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10.0,
            mainAxisSpacing: 10.0
        ),
        itemBuilder: (BuildContext context, int index){
          return GestureDetector(
            onTap: (){
              controller.onChangeThemeMode(context);
            },
            child: Container(
              color: Colors.amber,
            ),
          );
        },
      )
    );
  }
}