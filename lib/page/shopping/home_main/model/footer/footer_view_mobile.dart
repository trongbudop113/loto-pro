
import 'package:flutter/material.dart';
import 'package:loto/page/shopping/home_main/model/footer/footer_model.dart';

class FooterViewMobile extends StatelessWidget {
  final FooterModel model;
  const FooterViewMobile({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    final double width = MediaQuery.of(context).size.width;
    return buildInbox(width);
  }

  Widget buildInbox(double width) {
    final double paddingItem = width * 0.055;
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: paddingItem),
      child: Column(
        children: [
          const SizedBox(
            height: 30,
          ),
          const Column(
            children: [
              Text("Pixel Baker"),
              SizedBox(
                height: 16,
              ),
              Text("Chào mừng bạn đến với tiệm bánh chui, bánh lậu"),
              SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                  "Công Thức",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Nguyên Liệu",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Blog",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  ),
                  SizedBox(
                    width: 15,
                  ),
                  Text(
                    "Thanh Toán",
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black,
                    ),
                  )
                ],
              ),
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
