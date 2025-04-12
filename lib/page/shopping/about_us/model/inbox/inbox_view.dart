import 'package:loto/page/shopping/about_us/model/inbox/inbox_model.dart';
import 'package:flutter/material.dart';

class InboxView extends StatelessWidget {
  final InboxModel model;
  const InboxView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildInbox();
  }

  Widget buildInbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 68),
      child: Column(
        children: [
          const SizedBox(height: 65),
          Container(
            height: 560,
            width: double.maxFinite,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  const Color(0xFF333333).withOpacity(0.8),
                  const Color(0xFF333333).withOpacity(0.85),
                ],
              ),
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
            ),
            child: Column(
              children: [
                const SizedBox(height: 80),
                const Text(
                  "Đăng Ký Ngay",
                  style: TextStyle(
                    fontSize: 48,
                    color: Color(0xFFFF8E25),
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.5,
                  ),
                ),
                const SizedBox(height: 20),
                const Text(
                  "Để thưởng thức trước\nnhững chiếc bánh mới ra mắt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    height: 1.2,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 40),
                Container(
                  width: 440,
                  height: 70,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.1),
                        blurRadius: 20,
                        offset: const Offset(0, 8),
                      ),
                    ],
                  ),
                  padding: const EdgeInsets.all(8),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: model.emailController,
                          style: const TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color(0xFF333333),
                          ),
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.symmetric(horizontal: 20),
                            border: InputBorder.none,
                            hintText: 'Nhập email của bạn...',
                            hintStyle: TextStyle(
                              fontSize: 16,
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
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            width: 130,
                            height: 54,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(15),
                              gradient: const LinearGradient(
                                colors: [Color(0xFFFF8E25), Color(0xFFFFB067)],
                              ),
                            ),
                            alignment: Alignment.center,
                            child: const Text(
                              "Đăng Ký",
                              style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.w600,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}
