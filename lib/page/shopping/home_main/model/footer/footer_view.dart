import 'package:flutter/material.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';

class FooterView extends StatelessWidget {
  final FooterModel model;
  const FooterView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildInbox();
  }

  Widget buildInbox() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        children: [
          const Row(
            children: [
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Pixel Baker",
                    style: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  SizedBox(
                    height: 16,
                  ),
                  Text("Chào mừng bạn đến với tiệm bánh chui, bánh lậu")
                ],
              ),
              Spacer(
                flex: 1,
              ),
              Text(
                "Công Thức",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                "Nguyên Liệu",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                "Blog",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              SizedBox(
                width: 60,
              ),
              Text(
                "Thanh Toán",
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              )
            ],
          ),
          const SizedBox(
            height: 48,
          ),
          Container(
            height: 1,
            color: Colors.black.withOpacity(0.1),
          ),
          const SizedBox(
            height: 48,
          ),
          poweredCore(),
          const SizedBox(
            height: 48,
          ),
        ],
      ),
    );
  }

  Widget poweredCore() {
    return const Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text.rich(
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w500,
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '2024 Flowbase. Powered by ',
                style: TextStyle(color: Colors.black),
              ),
              TextSpan(
                text: 'Flutter',
                style: TextStyle(color: Colors.blue),
              ),
            ],
          ),
        )
      ],
    );
  }
}
