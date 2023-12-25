import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class PageFour extends StatelessWidget {
  PageFour({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: TabBar(
          isScrollable: true,
          padding: EdgeInsets.zero,
          tabAlignment: TabAlignment.start,
          tabs: listTab
        ),
        body: TabBarView (
          children: [
            Icon(Icons.directions_car),
            Icon(Icons.directions_transit),
            Icon(Icons.directions_bike),
            Icon(Icons.directions_boat),
          ],
        ),
      ),
    );
  }

   final List<Tab> listTab = [
    Tab(
      child: Container(
        alignment: Alignment.center,
        width: 120,
        child: Text(
          "All Project",
          style: GoogleFonts.oswald(),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 120,
        alignment: Alignment.center,
        child: Text(
          "Project Flutter",
          style: GoogleFonts.oswald(),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 120,
        alignment: Alignment.center,
        child: Text(
          "Project Android",
          style: GoogleFonts.oswald(),
        ),
      ),
    ),
    Tab(
      child: Container(
        width: 120,
        alignment: Alignment.center,
        child: Text(
          "Project Unity",
          style: GoogleFonts.oswald(),
        ),
      ),
    ),
  ];
}
