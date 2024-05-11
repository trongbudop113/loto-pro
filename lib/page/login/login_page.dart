import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/page/resources/image_resource.dart';
import 'package:loto/src/style_resource.dart';

class LoginPage extends GetView<LoginController> {
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
            width: MediaQuery.of(context).size.width < 600
                ? MediaQuery.of(context).size.width
                : 600,
            padding: const EdgeInsets.all(20),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: Colors.black, width: 3),
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(ImageResource.ic_app_loto, width: 120),
                const SizedBox(height: 40),
                _buildSwitchMode(context),
                SizedBox(height: 20),
                _buildInputUserName(context),
                SizedBox(height: 10),
                _buildInputPassword(context),
                SizedBox(height: 20),
                _buildSubmitButton(context),
                SizedBox(height: 20),
                _buildGoogleButton(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildInputUserName(BuildContext context) {
    return Obx(() => Row(
          children: [
            Expanded(
              child: TextField(
                controller: controller.userNameController,
                style: TextStyleResource.textStyleGrey(context),
                decoration: InputDecoration(
                  labelText: controller.isModePhone.value
                      ? 'Số điện thoại'
                      : 'Tài khoản',
                ),
                onChanged: (text) {
                  //controller.userNameController.text = text;
                },
              ),
            ),
            SizedBox(width: 10),
            Visibility(
              visible: controller.isModePhone.value,
              child: GestureDetector(
                onTap: () {
                  controller.onSendOTP();
                },
                child: Container(
                  height: 45,
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  decoration: BoxDecoration(
                    color: Colors.amberAccent,
                    borderRadius: BorderRadius.circular(30),
                  ),
                  alignment: Alignment.center,
                  child: Text(
                    "Gửi mã",
                    style: TextStyleResource.textStyleBlack(context),
                  ),
                ),
              ),
            )
          ],
        ));
  }

  Widget _buildInputPassword(BuildContext context) {
    return Obx(() => Visibility(
          visible: !controller.isModePhone.value,
          replacement: TextField(
            controller: controller.otpController,
            style: TextStyleResource.textStyleGrey(context),
            decoration: const InputDecoration(
              labelText: 'Mã OTP',
            ),
            onChanged: (text) {
              //controller.passwordController.text = text;
            },
          ),
          child: TextField(
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
        ));
  }

  Widget _buildSubmitButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
        child: Text("Đăng Nhập",
            style: TextStyleResource.textStyleBlack(context)
                .copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    return GestureDetector(
      onTap: () {
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
        child: Text("Login with Google",
            style: TextStyleResource.textStyleBlack(context)
                .copyWith(fontWeight: FontWeight.bold)),
      ),
    );
  }

  Widget _buildSwitchMode(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          width: 160,
          height: 45,
          padding: EdgeInsets.all(3),
          alignment: Alignment.centerLeft,
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
          child: Obx(() => Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.onChangeMode(false);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.isModePhone.value
                              ? Colors.transparent
                              : Colors.amberAccent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Email",
                          style: TextStyleResource.textStyleBlack(context),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        controller.onChangeMode(true);
                      },
                      child: Container(
                        decoration: BoxDecoration(
                          color: controller.isModePhone.value
                              ? Colors.amberAccent
                              : Colors.transparent,
                          borderRadius: BorderRadius.circular(30),
                        ),
                        alignment: Alignment.center,
                        child: Text(
                          "Phone",
                          style: TextStyleResource.textStyleBlack(context),
                        ),
                      ),
                    ),
                  )
                ],
              )),
        )
      ],
    );
  }
}
