
class ScreenSizeConfig{
  ScreenSizeConfig({required this.key, required this.maxWidth});
  DeviceScreen key;
  double maxWidth;
  static List<ScreenSizeConfig> list = [
    ScreenSizeConfig(key:DeviceScreen.mobile,maxWidth:600),
    ScreenSizeConfig(key:DeviceScreen.tablet,maxWidth:1000),
    ScreenSizeConfig(key:DeviceScreen.desktop,maxWidth:1400),
  ];
}

enum DeviceScreen{
  mobile,
  tablet,
  desktop,
}
