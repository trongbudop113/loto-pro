import 'package:flutter/foundation.dart' show kIsWeb;

const ICON_PNG_PATH_WEB = "images/";
const LOGO_PNG_PATH_WEB = "logo/";
const ICON_PNG_PATH_MOBILE = "assets/images/";
const LOGO_PNG_PATH_MOBILE = "assets/logo/";
const ICON_SVG_PATH_WEB = "images/icon_svg/";
const ICON_SVG_PATH_MOBILE = "assets/images/icon_svg/";

const String EXTENSION_PNG = ".png";
const String EXTENSION_SVG = ".svg";

class ImageResource {

  /// SVG File Path
  static String ic_arrow_connect = getSvgSourcePath("arrow_right");
  static String ic_arrow_right = getSvgSourcePath("ic_arrow_right");

  /// PNG File Path
  static String ic_app_loto = getPngSourcePath('loto');

  static String ic_app_logo = getLogoPngSourcePath('ic_app_128');

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