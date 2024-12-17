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
          const SizedBox(
            height: 65,
          ),
          Container(
            height: 560,
            width: double.maxFinite,
            decoration: const BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(
                    "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fregister.webp?alt=media&token=8fed6fb2-272d-4517-86e2-8950ad09ef87"),
                fit: BoxFit.fill,
              ),
            ),
            child: Column(
              children: [
                const SizedBox(
                  height: 80,
                ),
                const Text(
                  "Đăng Ký",
                  style: TextStyle(
                    fontSize: 48,
                    color: Color(0xFFFF7500),
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const Text(
                  "Để thưởng thức trước\nnhững chiếc bánh mới ra mắt",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 60,
                    fontWeight: FontWeight.w600,
                    height: 24 / 16,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 20),
                Container(
                  width: 440,
                  height: 60,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(60),
                    color: Colors.white,
                  ),
                  padding: const EdgeInsets.all(10),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: model.emailController,
                          cursorRadius: const Radius.circular(10),
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                          onChanged: (value) {},
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            contentPadding: const EdgeInsets.only(
                              left: 18,
                              bottom: 5,
                            ),
                            border: InputBorder.none,
                            hintText: 'Email của bạn....',
                            labelStyle: const TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                              height: 1,
                            ),
                            hintStyle: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Colors.black.withOpacity(0.4),
                            ),
                          ),
                        ),
                      ),
                      Container(
                        width: 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: const Color(0xFFFF7500),
                        ),
                        alignment: Alignment.center,
                        child: const Text(
                          "Đăng Ký",
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                          ),
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
          const SizedBox(
            height: 80,
          ),
        ],
      ),
    );
  }
}
