import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/simple/get_view.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/page/resources/image_resource.dart';

class LoginPage extends GetView<LoginController>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        alignment: Alignment.center,
        padding: EdgeInsets.symmetric(horizontal: 15),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(ImageResource.ic_app_loto, width: 120),
            SizedBox(height: 40),
            GestureDetector(
              onTap: (){
                controller.onClickLogin();
              },
              child: Container(
                height: 50,
                alignment: Alignment.center,
                child: Text("Login with Google", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(30),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 1,
                      offset: Offset(0, 2), // changes position of shadow
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      )
    );
  }

}