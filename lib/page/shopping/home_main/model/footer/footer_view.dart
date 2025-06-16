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
    return Container(
      color: const Color(0xFFFFF8F3),
      padding: const EdgeInsets.symmetric(horizontal: 80),
      child: Column(
        children: [
          const SizedBox(height: 48),
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Bug Cake",
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFFFF8E25),
                      letterSpacing: 0.5,
                    ),
                  ),
                  SizedBox(height: 16),
                  Text(
                    "Chào mừng bạn đến với tiệm bánh chui, bánh lậu",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF666666),
                      height: 1.5,
                    ),
                  ),
                ],
              ),
              const Spacer(),
              Row(
                children: [
                  _buildFooterButton("Công Thức", onTap: () => model.onGotoRecipePage()),
                  const SizedBox(width: 24),
                  _buildFooterButton("Đơn Hàng", onTap: () => model.onGoToViewOrder()),
                  const SizedBox(width: 24),
                  _buildFooterButton("Cá nhân", onTap: () => model.onGoToViewProfile()),
                  const SizedBox(width: 24),
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
