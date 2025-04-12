import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:flutter/material.dart';
import 'package:loto/src/image_resource.dart';

class InboxViewMobile extends StatelessWidget {
  final InboxModel model;
  const InboxViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildInbox(width);
  }

  Widget buildInbox(double width) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Column(
        children: [
          const SizedBox(height: 30),
          Container(
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              image: const DecorationImage(
                image: NetworkImage(
                  "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fregister.webp?alt=media&token=8fed6fb2-272d-4517-86e2-8950ad09ef87",
                ),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Color(0xFF333333),
                  BlendMode.overlay,
                ),
              ),
              boxShadow: [
                BoxShadow(
                  color: const Color(0xFFFF8E25).withOpacity(0.08),
                  blurRadius: 15,
                  offset: const Offset(0, 6),
                ),
              ],
            ),
            child: Column(
              children: [
                const SizedBox(height: 40),
                const Text(
                  "Đăng ký nhận thông tin",
                  style: TextStyle(
                    fontSize: 24,
                    color: Color(0xFFFF8E25),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 12),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Text(
                    "Đăng ký để nhận thông tin mới nhất về sản phẩm và khuyến mãi",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w500,
                      height: 1.5,
                      color: const Color(0xFF333333).withOpacity(0.8),
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Container(
                  width: width * 0.8,
                  height: 56,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.05),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(6),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: model.emailController,
                          style: const TextStyle(
                            fontSize: 15,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 15),
                            border: InputBorder.none,
                            hintText: 'Nhập email của bạn...',
                            hintStyle: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xFF333333).withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      Material(
                        color: Colors.transparent,
                        child: InkWell(
                          onTap: () => model.onSubscribe(),
                          borderRadius: BorderRadius.circular(12),
                          child: Container(
                            width: 110,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(12),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Đăng ký",
                              style: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 40),
              ],
            ),
          ),
          const SizedBox(height: 30),
        ],
      ),
    );
  }

}
