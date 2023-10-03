
import 'package:get/get.dart';
import 'package:loto/page/call_number/call_number_controller.dart';
import 'package:loto/page/call_number/call_number_page.dart';
import 'package:loto/page/caro_chess/caro_chess_controller.dart';
import 'package:loto/page/caro_chess/caro_chess_page.dart';
import 'package:loto/page/chat/chat_list_controller.dart';
import 'package:loto/page/chat/chat_list_page.dart';
import 'package:loto/page/contact/contact_controller.dart';
import 'package:loto/page/contact/contact_page.dart';
import 'package:loto/page/contact_manager/contact_manager_controller.dart';
import 'package:loto/page/home/home_controller.dart';
import 'package:loto/page/home/home_page.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/landing_page.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/page/login/login_page.dart';
import 'package:loto/page/menu/menu_controller.dart';
import 'package:loto/page/menu/menu_page.dart';
import 'package:loto/page/moon_cake/controller/moon_cake_controller.dart';
import 'package:loto/page/moon_cake/page/moon_cake_page.dart';
import 'package:loto/page/paper_manager/paper_manager_controller.dart';
import 'package:loto/page/paper_manager/paper_manager_page.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/page/profile/profile_page.dart';
import 'package:loto/page/room/room_controller.dart';
import 'package:loto/page/room/room_page.dart';
import 'package:loto/page/select/select_controller.dart';
import 'package:loto/page/select/select_page.dart';
import 'package:loto/page/statistic/statistic_controller.dart';
import 'package:loto/page/statistic/statistic_page.dart';
import 'package:loto/page/stories/stories_controller.dart';

import 'page/chat/chat_detail_controller.dart';
import 'page/chat/chat_detail_page.dart';
import 'page/contact_manager/contact_manager_page.dart';
import 'page/portfolior/portfolior_page.dart';
import 'page/stories/stories_page.dart';

class PageConfig {
  static String ROOM = '/room';
  static String MENU = '/menu';
  static String HOME = '/home';
  static String LOGIN = '/login';
  static String SELECT = '/select';
  static String MANAGER = '/manager';
  static String LANDING = '/landing';
  static String CONTACT = '/contact';
  static String TRIP = '/trip';
  static String STORIES = '/stories';
  static String CHAT = '/chat';
  static String CHAT_DETAIL = '/chat_detail';
  static String CARO_CHESS = '/caro';
  static String PROFILE = '/profile';
  static String CALL = '/call_number';
  static String MOON_CAKE = '/moon_cake';
  static String STATISTIC = '/statistic';
  static String PORTFOLIOR = '/portfolior';
  static String CONTACT_MANAGER = '/contact_manager';

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
      GetPage(
        name: MANAGER,
        page: () => PaperManagerPage(),
        binding: PaperManagerBinding(),
      ),
      GetPage(
        name: LANDING,
        page: () => LandingPage(),
        binding: LandingBinding(),
      ),
      GetPage(
        name: STORIES,
        page: () => StoriesPage(),
        binding: StoriesBinding(),
      ),
      GetPage(
        name: CONTACT,
        page: () => ContactPage(),
        binding: ContactBinding(),
      ),
      GetPage(
        name: CHAT,
        page: () => ChatListPage(),
        binding: ChatListBinding(),
      ),
      GetPage(
        name: CHAT_DETAIL,
        page: () => ChatDetailPage(),
        binding: ChatDetailBinding(),
      ),
      GetPage(
        name: CARO_CHESS,
        page: () => CaroChessPage(),
        binding: CaroChessBinding(),
      ),
      GetPage(
        name: PROFILE,
        page: () => ProfilePage(),
        binding: ProfileBinding(),
      ),
      GetPage(
        name: CALL,
        page: () => CallNumberPage(),
        binding: CallNumberBinding(),
      ),
      GetPage(
        name: MOON_CAKE,
        page: () => MoonCakePage(),
        binding: MoonCakeBinding(),
      ),
      GetPage(
        name: STATISTIC,
        page: () => StatisticPage(),
        binding: StatisticBinding(),
      ),
      GetPage(
        name: PORTFOLIOR,
        page: () => PortFoliorPage(),
        binding: PortFoliorBinding(),
      ),
      GetPage(
        name: CONTACT_MANAGER,
        page: () => ContactManagerPage(),
        binding: ContactManagerBinding(),
      ),
    ];
  }
}