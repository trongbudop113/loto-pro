import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/models/user_login.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';

class PickUserLayout extends StatelessWidget {
  final CartController controller;
  const PickUserLayout({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width < 650
        ? MediaQuery.of(context).size.width
        : 450;
    return SizedBox(
      width: width,
      height: width * 1.5,
      child: Column(
        children: [
          _buildHeader(),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: controller.getListUser(),
              builder: (context, snapshot){
                if(!snapshot.hasData){
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
                return ListView.separated(
                  separatorBuilder: (c, i){
                    return const Divider();
                  },
                  padding: const EdgeInsets.all(15),
                  itemBuilder: (c, i){
                    var user = UserLogin.fromJson(snapshot.data?.docs[i].data() as Map<String, dynamic>);
                    return InkWell(
                      onTap: (){
                        controller.onPickUser(user);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              user.name ?? '',
                              style: const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            const SizedBox(height: 10),
                            Visibility(
                              visible: (user.phoneNumber ?? '').isNotEmpty,
                              replacement: Text(
                                user.email ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                              child: Text(
                                user.phoneNumber ?? '',
                                style: const TextStyle(
                                  color: Colors.black,
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    );
                  },
                  itemCount: snapshot.data!.size,
                );
              },
            ),
          ),
          _buildCloseButton(),
        ],
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 20),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Color(0xFFEEEEEE)),
        ),
      ),
      alignment: Alignment.center,
      child: const Text(
        "Chọn tài khoản đặt hàng",
        style: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w600,
          color: Color(0xFF333333),
        ),
      ),
    );
  }

  Widget _buildCloseButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => Get.back(),
        child: Container(
          width: double.infinity,
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: const BoxDecoration(
            border: Border(
              top: BorderSide(color: Color(0xFFEEEEEE)),
            ),
          ),
          child: const Text(
            "Đóng",
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w600,
              color: Color(0xFFFF8E25),
            ),
          ),
        ),
      ),
    );
  }
}
