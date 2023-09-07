import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/moon_cake/controller/moon_cake_detail_controller.dart';
import 'package:loto/src/style_resource.dart';

class MoonCakeDetailPage extends GetView<MoonCakeDetailController>{
  const MoonCakeDetailPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      backgroundColor: Theme.of(context).cardColor,
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 1,
              child: Container(
                color: Theme.of(context).backgroundColor,
                alignment: Alignment.center,
                padding: EdgeInsets.all(50),
                child: Image.network("https://firebasestorage.googleapis.com/v0/b/loto-fb7ac.appspot.com/o/moon_cake.png?alt=media&token=48655c5c-b0c8-4291-b775-ec70c0011df5"),
              ),
            ),
            SizedBox(height: 10),
            Container(
              alignment: Alignment.centerLeft,
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              child: Text(
                "Bánh thập cẩm",
                style: TextStyleResource.textStyleWhite(context).copyWith(fontSize: 25),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Giá: 65.000đ",
                style: TextStyleResource.textStyleBlack(context).copyWith(fontSize: 25, fontWeight: FontWeight.bold),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Thành phần:",
                style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10).copyWith(left: 25, right: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Bột mì, đường, bơ đậu phộng, dầu ăn, bí xanh, hạt dưa, mứt sen, lạp xưởng",
                style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20, height: 1.3),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Trứng muối:",
                style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
              alignment: Alignment.centerLeft,
              child: Text(
                "Ghi chú:",
                style: TextStyleResource.textStyleGrey(context).copyWith(fontSize: 20),
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: Container(
        height: 60,
        color: Theme.of(context).backgroundColor,
        child: Row(
          children: [
            Expanded(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _subtractButton(),
                  Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 40,
                    child: Text(
                        "1",
                      style: TextStyle(
                          fontSize: 18,
                          color: getTextColor(Theme.of(context).backgroundColor),
                        height: 1
                      ),
                    ),
                  ),
                  _plusButton()
                ],
              ),
            ),
            Container(
              height: 60,
              width: 2,
              color: Colors.white,
            ),
            Expanded(
              child: Container(
                alignment: Alignment.center,
                child: Text(
                  "Thêm vào giỏ",
                  style: TextStyle(
                    fontSize: 18,
                    color: getTextColor(Theme.of(context).backgroundColor),
                    height: 1
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Color getTextColor(Color color) {
    int d = 0;

// Counting the perceptive luminance - human eye favors green color...
    double luminance =
        (0.299 * color.red + 0.587 * color.green + 0.114 * color.blue) / 255;

    if (luminance > 0.5)
      d = 0; // bright colors - black font
    else
      d = 255; // dark colors - white font

    return Color.fromARGB(color.alpha, d, d, d);
  }

  Widget _plusButton(){
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        color: Colors.pink
      ),
      child: Icon(Icons.add, size: 15,),
    );
  }

  Widget _subtractButton(){
    return Container(
      width: 30,
      height: 30,
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: Colors.pink
      ),
      child: Icon(Icons.add, size: 15,),
    );
  }
}
