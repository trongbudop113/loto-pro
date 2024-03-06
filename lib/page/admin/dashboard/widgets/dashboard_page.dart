import 'package:flutter/material.dart';
import 'package:loto/page/admin/dashboard/dashboard_page.dart';

class DashboardPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MyScaffold(
      route: '/',
      body: Container(
        alignment: Alignment.topLeft,
        padding: const EdgeInsets.all(10),
        child: Text(
          'Dashboard',
          style: TextStyle(
            fontWeight: FontWeight.w700,
            fontSize: 36,
          ),
        ),
      ),
    );
  }
}
