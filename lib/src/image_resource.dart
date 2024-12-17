import 'package:flutter/foundation.dart' show kIsWeb;

const ICON_PNG_PATH_WEB = "images/png/";
const LOGO_PNG_PATH_WEB = "logo/";
const ICON_PNG_PATH_MOBILE = "assets/images/png/";
const LOGO_PNG_PATH_MOBILE = "assets/logo/";
const ICON_SVG_PATH_WEB = "images/icon_svg/";
const ICON_SVG_PATH_MOBILE = "assets/images/icon_svg/";

const String EXTENSION_PNG = ".png";
const String EXTENSION_SVG = ".svg";

class ImageResource {

  /// SVG File Path
  static String ic_arrow_connect = getSvgSourcePath("arrow_right");
  static String ic_arrow_right = getSvgSourcePath("ic_arrow_right");
  static String knife = getSvgSourcePath("knife");
  static String timer = getSvgSourcePath("timer");
  static String playCircle = getSvgSourcePath("play_circle");
  static String unlike = getSvgSourcePath("ic_unlike");

  /// PNG File Path
  static String ic_egg_yolk = getPngSourcePath('egg_yolk');
  static String ic_app_logo = getLogoPngSourcePath('ic_app_128');

  static String banner = getPngSourcePath('banner');
  static String breakFast = getPngSourcePath('break_fast');
  static String cake = getPngSourcePath('cake');
  static String chocolate = getPngSourcePath('chocolate');
  static String meat = getPngSourcePath('meat');
  static String recipe = getPngSourcePath('recipe');
  static String sandwich = getPngSourcePath('sandwich');
  static String vegan = getPngSourcePath('vegan');

  static String adsFood = getPngSourcePath('ads_food');
  static String chef = getPngSourcePath('chef');
  static String chickenRice = getPngSourcePath('chicken_rice');
  static String salmon = getPngSourcePath('salmon');
  static String salad = getPngSourcePath('salad');
  static String meatBall = getPngSourcePath('meat_ball');
  static String pancake = getPngSourcePath('pancake');
  static String orangePancake = getPngSourcePath('orange_pancake');
  static String pasta = getPngSourcePath('pasta');
  static String burger = getPngSourcePath('burger');
  static String bgInbox = getPngSourcePath('bg_inbox');
  static String avatar = getPngSourcePath('avatar');
  static String bgContactUs = getPngSourcePath('bg_contact_us');

}

String getPngSourcePath(String name) {
  if (kIsWeb) {
    // running on the web!
    return ICON_PNG_PATH_WEB + name + EXTENSION_PNG;
  } else {
    // NOT running on the web! You can check for additional platforms here.
    return ICON_PNG_PATH_MOBILE + name + EXTENSION_PNG;
  }
}

String getLogoPngSourcePath(String name) {
  if (kIsWeb) {
    // running on the web!
    return LOGO_PNG_PATH_WEB + name + EXTENSION_PNG;
  } else {
    // NOT running on the web! You can check for additional platforms here.
    return LOGO_PNG_PATH_MOBILE + name + EXTENSION_PNG;
  }
}


String getSvgSourcePath(String name) => ICON_SVG_PATH_MOBILE + name + EXTENSION_SVG;