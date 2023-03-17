
const ICON_PNG_PATH = "assets/images/";
const ICON_SVG_PATH = "assets/images/icon_svg/";

const String EXTENSION_PNG = ".png";
const String EXTENSION_SVG = ".svg";

class ImageResource {

  /// SVG File Path
  static String ic_arrow_connect = getSvgSourcePath("arrow_right");
  static String ic_arrow_right = getSvgSourcePath("ic_arrow_right");

  /// PNG File Path
  static String ic_app_loto = getPngSourcePath('loto');

}

String getPngSourcePath(String name) => ICON_PNG_PATH + name + EXTENSION_PNG;
String getSvgSourcePath(String name) => ICON_SVG_PATH + name + EXTENSION_SVG;