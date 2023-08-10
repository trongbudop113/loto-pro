import 'package:flutter/material.dart';

class TextStyleResource{
  static TextStyle textStyleBlack(BuildContext context) => Theme.of(context).textTheme.bodyText1!;
  static TextStyle textStyleWhite(BuildContext context) => Theme.of(context).textTheme.bodyText2!;
  static TextStyle textStyleGrey(BuildContext context) => Theme.of(context).textTheme.headline1!;
  static TextStyle textStyleCaption(BuildContext context) => Theme.of(context).textTheme.caption!;

}