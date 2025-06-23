import 'package:flutter/material.dart';
import 'package:get/get.dart';

mixin AppbarMixin {

  BoxConstraints get boxConstraints => const BoxConstraints(maxWidth: 1440, minWidth: 600);

  Widget buildAppBar(
    BuildContext context,
    BoxConstraints constraint, {
    required String title,
  }) {
    return Container(
      constraints: const BoxConstraints(
        maxWidth: 1440,
        minWidth: 600,
      ),
      child: _buildAppBarWeb(context, constraint, title: title),
    );
  }

  Widget _buildAppBarWeb(
    BuildContext context,
    BoxConstraints constraint, {
    required String title,
  }) {
    return Container(
      height: 97,
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [Color(0xFFFF7A00), Color(0xFFFF8E25)],
        ),
      ),
      padding: EdgeInsets.symmetric(
        horizontal: (constraint.maxWidth * 0.03).clamp(15, 44),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          _buildMenuButton(),
          _buildTitle(title),
          const SizedBox(width: 70)
        ],
      ),
    );
  }

  Widget _buildMenuButton() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {
          Get.back();
        },
        borderRadius: BorderRadius.circular(30),
        child: Container(
          width: 70,
          height: 44,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white.withOpacity(0.2),
            border: Border.all(
              color: Colors.white.withOpacity(0.3),
              width: 1,
            ),
          ),
          child: const Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
        ),
      ),
    );
  }

  Text _buildTitle(String title) {
    return Text(
      title,
      style: const TextStyle(
        fontSize: 22,
        color: Colors.white,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.5,
      ),
    );
  }
}
