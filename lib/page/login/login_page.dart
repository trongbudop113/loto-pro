import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/src/image_resource.dart';
import 'package:loto/src/logo_app_base_64.dart';
import 'package:loto/src/style_resource.dart';

class LoginPage extends GetView<LoginController> {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SingleChildScrollView(
          child: Container(
            width: MediaQuery.of(context).size.width < 600
                ? MediaQuery.of(context).size.width
                : 450,
            padding: const EdgeInsets.all(32),
            margin: const EdgeInsets.symmetric(horizontal: 20),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(24),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.1),
                  blurRadius: 20,
                  offset: const Offset(0, 10),
                ),
              ],
            ),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildLogo(),
                const SizedBox(height: 32),
                _buildSwitchMode(context),
                const SizedBox(height: 24),
                _buildLoginForm(context),
                const SizedBox(height: 32),
                _buildDivider(),
                const SizedBox(height: 24),
                _buildSocialLogin(context),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLogo() {
    return Column(
      children: [
        Image.memory(
          base64Decode(logoAppBase64),
          width: 120,
          height: 120,
        ),
        const SizedBox(height: 16),
        const Text(
          "Đăng nhập",
          style: TextStyle(
            fontSize: 28,
            fontWeight: FontWeight.bold,
            color: Color(0xFFFF8E25),
          ),
        ),
      ],
    );
  }

  Widget _buildLoginForm(BuildContext context) {
    return Column(
      children: [
        _buildInputUserName(context),
        const SizedBox(height: 16),
        _buildInputPassword(context),
        const SizedBox(height: 24),
        _buildSubmitButton(context),
      ],
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
        const SizedBox(width: 10),
        Visibility(
          visible: controller.isModePhone.value,
          child: GestureDetector(
            onTap: () {
              controller.onSendOTP();
            },
            child: Container(
              height: 45,
              padding: const EdgeInsets.symmetric(horizontal: 15),
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


  Widget _buildDivider() {
    return Row(
      children: [
        Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            "Hoặc",
            style: TextStyle(
              color: Colors.grey,
              fontSize: 14,
            ),
          ),
        ),
        Expanded(child: Divider(color: Colors.grey.withOpacity(0.3))),
      ],
    );
  }

  Widget _buildSocialLogin(BuildContext context) {
    return _buildGoogleButton(context);
  }

  Widget _buildSubmitButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onClickLoginEmail(context),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(30),
            boxShadow: [
              BoxShadow(
                color: const Color(0xFFFF8E25).withOpacity(0.2),
                blurRadius: 8,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          alignment: Alignment.center,
          child: const Text(
            "Đăng Nhập",
            style: TextStyle(
              color: Colors.white,
              fontSize: 16,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildGoogleButton(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => controller.onClickLogin(context),
        borderRadius: BorderRadius.circular(30),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: const Color(0xFFFF8E25).withOpacity(0.5),
              width: 1.5,
            ),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              // Image.asset(
              //   'assets/images/google_logo.png',
              //   height: 24,
              // ),
              const SizedBox(width: 12),
              const Text(
                "Đăng nhập với Google",
                style: TextStyle(
                  color: Color(0xFF333333),
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ],
          ),
        ),
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
          padding: const EdgeInsets.all(3),
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
