
import 'package:get/get.dart';
import 'package:loto/page/home/home_controller.dart';
import 'package:loto/page/home/home_page.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/page/login/login_page.dart';
import 'package:loto/page/menu/menu_controller.dart';
import 'package:loto/page/menu/menu_page.dart';
import 'package:loto/page/room/room_controller.dart';
import 'package:loto/page/room/room_page.dart';
import 'package:loto/page/select/select_controller.dart';
import 'package:loto/page/select/select_page.dart';

class PageConfig {
  static String ROOM = '/room';
  static String MENU = '/menu';
  static String HOME = '/home';
  static String LOGIN = '/login';
  static String SELECT = '/select';

  static List<GetPage> listPage(){
    return [
      GetPage(
        name: SELECT,
        page: () => SelectPage(),
        binding: SelectBinding(),
      ),
      GetPage(
        name: HOME,
        page: () => HomePage(),
        binding: HomeBinding(),
      ),
      GetPage(
        name: LOGIN,
        page: () => LoginPage(),
        binding: LoginBinding(),
      ),
      GetPage(
      name: ROOM,
        page: () => RoomPage(),
        binding: RoomBinding(),
      ),
      GetPage(
        name: MENU,
        page: () => MenuPage(),
        binding: MenuBinding(),
      ),
    ];
  }
}