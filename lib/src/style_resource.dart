import 'package:flutter/material.dart';

class TextStyleResource{
  static TextStyle textStyleBlack(BuildContext context) => Theme.of(context).textTheme.bodyMedium!;
  static TextStyle textStyleWhite(BuildContext context) => Theme.of(context).textTheme.bodyLarge!;
  static TextStyle textStyleGrey(BuildContext context) => Theme.of(context).textTheme.bodySmall!;
  static TextStyle textStyleCaption(BuildContext context) => Theme.of(context).textTheme.labelLarge!;

}