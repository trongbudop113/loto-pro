
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
import 'package:loto/page/footer_manager/manager/footer_manager_controller.dart';
import 'package:loto/page/home/home_controller.dart';
import 'package:loto/page/home/home_page.dart';
import 'package:loto/page/hpbd/hpbd_controller.dart';
import 'package:loto/page/hpbd/hpbd_page.dart';
import 'package:loto/page/landing/landing_controller.dart';
import 'package:loto/page/landing/landing_page.dart';
import 'package:loto/page/login/login_controller.dart';
import 'package:loto/page/login/login_page.dart';
import 'package:loto/page/paper_manager/paper_manager_controller.dart';
import 'package:loto/page/paper_manager/paper_manager_page.dart';
import 'package:loto/page/portfolior/portfolior_controller.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_page.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/edit_page_manager_controller.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/edit_page_manager_page.dart';
import 'package:loto/page/profile/page_manager/page_manager/page_manager_controller.dart';
import 'package:loto/page/profile/page_manager/page_manager/page_manager_page.dart';
import 'package:loto/page/profile/product_manager/product_manager_controller.dart';
import 'package:loto/page/profile/product_manager/product_manager_page.dart';
import 'package:loto/page/profile/profile_controller.dart';
import 'package:loto/page/profile/profile_manager/profile_manager_controller.dart';
import 'package:loto/page/profile/profile_page.dart';
import 'package:loto/page/profile/user_manager/user_manager_controller.dart';
import 'package:loto/page/room/room_controller.dart';
import 'package:loto/page/room/room_page.dart';
import 'package:loto/page/select/select_controller.dart';
import 'package:loto/page/select/select_page.dart';
import 'package:loto/page/shopping/cart/cart_controller.dart';
import 'package:loto/page/shopping/cart/cart_page.dart';
import 'package:loto/page/shopping/moon_cake/controller/moon_cake_detail_controller.dart';
import 'package:loto/page/shopping/moon_cake/page/moon_cake_detail_page.dart';
import 'package:loto/page/statistic/statistic_controller.dart';
import 'package:loto/page/statistic/statistic_page.dart';
import 'package:loto/page/stories/stories_controller.dart';
import 'page/chat/chat_detail_controller.dart';
import 'page/chat/chat_detail_page.dart';
import 'page/contact_manager/contact_manager_page.dart';
import 'page/footer_manager/manager/footer_manager_page.dart';
import 'page/portfolior/portfolior_page.dart';
import 'page/profile/order_manager/order_manager/order_manager_controller.dart';
import 'page/profile/order_manager/order_manager/order_manager_page.dart';
import 'page/profile/profile_manager/profile_manager_page.dart';
import 'page/profile/user_manager/user_manager_page.dart';
import 'page/shopping/moon_cake/controller/moon_cake_controller.dart';
import 'page/shopping/moon_cake/page/moon_cake_page.dart';
import 'page/stories/stories_page.dart';

class PageConfig {
  static String ROOM = '/room';
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
  static String MOON_CAKE_DETAIL = '/moon_cake_detail';
  static String STATISTIC = '/statistic';
  static String PORTFOLIOR = '/portfolior';
  static String CONTACT_MANAGER = '/contact_manager';
  static String CART = '/cart_moon_cake';
  static String HPBD = '/hpbd';
  static String FOOTER_MANAGER = '/footer_manager';
  static String ORDER_MANAGER = '/order_manager';
  static String PRODUCT_MANAGER = '/product_manager';
  static String PAGE_MANAGER = '/page_manager';
  static String USER_MANAGER = '/user_manager';
  static String EDIT_PAGE_MANAGER = '/edit_page_manager';
  static String PROFILE_MANAGER = '/profile_manager';
  static String COOKING = '/cooking';
  static String COOKING_MANAGER = '/cooking_manager';
  static String ORDER_DETAIL_MANAGER = '/order_detail_manager';
  static String EDIT_PRODUCT_MANAGER = '/edit_product_manager';

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
      GetPage(
        name: CART,
        page: () => CartPage(),
        binding: CartBinding(),
      ),
      GetPage(
        name: MOON_CAKE_DETAIL,
        page: () => MoonCakeDetailPage(),
        binding: MoonCakeDetailBinding(),
      ),
      GetPage(
        name: HPBD,
        page: () => HPBDPage(),
        binding: HPBDBinding(),
      ),
      GetPage(
        name: FOOTER_MANAGER,
        page: () => FooterManagerPage(),
        binding: FooterManagerBinding(),
      ),
      GetPage(
        name: ORDER_MANAGER,
        page: () => OrderManagerPage(),
        binding: OrderManagerBinding(),
      ),
      GetPage(
        name: PRODUCT_MANAGER,
        page: () => ProductManagerPage(),
        binding: ProductManagerBinding(),
      ),
      GetPage(
        name: PAGE_MANAGER,
        page: () => PageManagerPage(),
        binding: PageManagerBinding(),
      ),
      GetPage(
        name: USER_MANAGER,
        page: () => UserManagerPage(),
        binding: UserManagerBinding(),
      ),
      GetPage(
        name: EDIT_PAGE_MANAGER,
        page: () => EditPageManagerPage(),
        binding: EditPageManagerBinding(),
      ),
      GetPage(
        name: PROFILE_MANAGER,
        page: () => ProfileManagerPage(),
        binding: ProfileManagerBinding(),
      ),
      GetPage(
        name: COOKING,
        page: () => ProfileManagerPage(),
        binding: ProfileManagerBinding(),
      ),
      GetPage(
        name: COOKING_MANAGER,
        page: () => ProfileManagerPage(),
        binding: ProfileManagerBinding(),
      ),
      GetPage(
        name: ORDER_DETAIL_MANAGER,
        page: () => OrderDetailManagerPage(),
        binding: OrderDetailManagerBinding(),
      ),
      GetPage(
        name: EDIT_PRODUCT_MANAGER,
        page: () => OrderDetailManagerPage(),
        binding: OrderDetailManagerBinding(),
      ),
    ];
  }
}