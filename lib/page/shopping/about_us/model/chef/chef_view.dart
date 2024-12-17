import 'package:loto/page/shopping/about_us/model/chef/chef_model.dart';
import 'package:flutter/material.dart';

class ChefView extends StatelessWidget {
  final ChefModel model;
  const ChefView({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return buildChefKitchen();
  }

  Widget buildChefKitchen() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 67),
      child: Column(
        children: [
          const SizedBox(
            height: 81,
          ),
          SizedBox(
            height: 687,
            child: Row(
              children: [
                SizedBox(
                  width: 525,
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fshop_now1.webp?alt=media&token=e61a1ef2-6742-40e4-bd0e-16e02628b34d",
                  ),
                ),
                const Spacer(flex: 1),
                SizedBox(
                  width: 763,
                  child: Image.network(
                    "https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/home%2Fcategories%2Fshop_now2.webp?alt=media&token=e61a1ef2-6742-40e4-bd0e-16e02628b34d",
                  ),
                )
              ],
            ),
          )
        ],
      ),
    );
  }
}
