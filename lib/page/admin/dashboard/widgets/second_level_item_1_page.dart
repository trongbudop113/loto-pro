import 'package:flutter/material.dart';
import 'package:loto/page/admin/dashboard/dashboard_page.dart';

class SecondLevelItem1Page extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      route: '/secondLevelItem1',
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          'Second Level Item 1',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
