import 'package:flutter/material.dart';
import 'package:loto/page/admin/dashboard/dashboard_page.dart';

class ThirdLevelItem2Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      route: '/thirdLevelItem2',
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          'Third Level Item 2',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
