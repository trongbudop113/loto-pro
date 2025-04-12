import 'package:flutter/cupertino.dart';
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
    return Container(
      color: const Color(0xFFFFF8F3),
      padding: EdgeInsets.symmetric(horizontal: paddingItem),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Column(
            children: [
              const Text(
                "Bug Cake",
                style: TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFFFF8E25),
                  letterSpacing: 0.5,
                ),
              ),
              const SizedBox(height: 16),
              const Text(
                "Chào mừng bạn đến với tiệm bánh chui, bánh lậu",
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF666666),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 24),
              Wrap(
                spacing: 24,
                runSpacing: 16,
                alignment: WrapAlignment.center,
                children: [
                  _buildFooterButton("Công Thức", onTap: () => model.onGotoRecipePage()),
                  _buildFooterButton("Nguyên Liệu"),
                  _buildFooterButton("Blog"),
                  _buildFooterButton("Thanh Toán", onTap: () => model.onGoToPaymentInfo()),
                ],
              ),
            ],
          ),
          const SizedBox(height: 48),
          Container(
            height: 1,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  const Color(0xFFFF8E25).withOpacity(0.1),
                  const Color(0xFFFF8E25).withOpacity(0.3),
                  const Color(0xFFFF8E25).withOpacity(0.1),
                ],
              ),
            ),
          ),
          const SizedBox(height: 48),
          poweredCore(),
          const SizedBox(height: 48),
        ],
      ),
    );
  }

  Widget _buildFooterButton(String text, {VoidCallback? onTap}) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: const Color(0xFFFF8E25).withOpacity(0.2),
              width: 1,
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w600,
              color: Color(0xFF333333),
            ),
          ),
        ),
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
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.5,
          ),
          TextSpan(
            children: [
              TextSpan(
                text: '© 2024 Bug Cake. Powered by ',
                style: TextStyle(color: Color(0xFF666666)),
              ),
              TextSpan(
                text: 'Flutter',
                style: TextStyle(
                  color: Color(0xFFFF8E25),
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
