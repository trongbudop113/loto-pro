import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/page/resources/image_resource.dart';
import 'package:loto/src/style_resource.dart';

class LoginPage extends GetView<LoginController>{
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("login".tr),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width < 600 ? MediaQuery.of(context).size.width : 600,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                border: Border.all(color: Colors.black, width: 3)
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageResource.ic_app_loto, width: 120),
                const SizedBox(height: 40),
                TextField(
                  controller: controller.userNameController,
                  style: TextStyleResource.textStyleGrey(context),
                  decoration: const InputDecoration(
                    labelText: 'Tài khoản',
                  ),
                  onChanged: (text) {
                    //controller.userNameController.text = text;
                  },
                ),
                SizedBox(height: 10),
                TextField(
                  controller: controller.passwordController,
                  style: TextStyleResource.textStyleGrey(context),
                  obscureText: true,
                  obscuringCharacter: "*",
                  decoration: const InputDecoration(
                    labelText: 'Mật khẩu',
                  ),
                  onChanged: (text) {
                    //controller.passwordController.text = text;
                  },
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    controller.onClickLoginEmail();
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                        "Đăng Nhập",
                        style: TextStyleResource.textStyleBlack(context).copyWith(
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                ),
                SizedBox(height: 20),
                GestureDetector(
                  onTap: (){
                    controller.onClickLogin();
                  },
                  child: Container(
                    height: 50,
                    alignment: Alignment.center,

                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(30),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.5),
                          spreadRadius: 1,
                          offset: const Offset(0, 1), // changes position of shadow
                        ),
                      ],
                    ),
                    child: Text(
                        "Login with Google",
                        style: TextStyleResource.textStyleBlack(context).copyWith(
                            fontWeight: FontWeight.bold
                        )
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      )
    );
  }

}