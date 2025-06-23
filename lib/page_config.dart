
import 'package:get/get.dart';
import 'package:loto/middleware/my_order_middleware.dart';
import 'package:loto/middleware/recipe_middleware.dart';
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
import 'package:loto/page/profile/image_server/choose_image/choose_image_controller.dart';
import 'package:loto/page/profile/image_server/choose_image/choose_image_page.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_controller.dart';
import 'package:loto/page/profile/order_manager/order_detail_manager/order_detail_manager_page.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/edit_page_manager_controller.dart';
import 'package:loto/page/profile/page_manager/edit_page_manager/edit_page_manager_page.dart';
import 'package:loto/page/profile/page_manager/page_manager/page_manager_controller.dart';
import 'package:loto/page/profile/page_manager/page_manager/page_manager_page.dart';
import 'package:loto/page/profile/product_manager/product_detail_manager/product_detail_manager_controller.dart';
import 'package:loto/page/profile/product_manager/product_detail_manager/product_detail_manager_page.dart';
import 'package:loto/page/profile/product_manager/product_manager/product_manager_controller.dart';
import 'package:loto/page/profile/product_manager/product_manager/product_manager_page.dart';
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
import 'package:loto/page/shopping/payment_info/payment_info_controller.dart';
import 'package:loto/page/shopping/payment_info/payment_info_page.dart';
import 'package:loto/page/shopping/recipe/recipe_controller.dart';
import 'package:loto/page/shopping/recipe/recipe_detail_controller.dart';
import 'package:loto/page/shopping/recipe/recipe_detail_page.dart';
import 'package:loto/page/shopping/recipe/recipe_page.dart';
import 'package:loto/page/shopping/view_order/view_order_controller.dart';
import 'package:loto/page/shopping/view_order/view_order_page.dart';
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
import 'page/profile/voucher_collection_page.dart';
import 'page/profile/voucher_manager/voucher_manager_controller.dart';
import 'page/profile/voucher_manager/voucher_manager_page.dart';
import 'page/profile/voucher_manager/voucher_detail_manager_controller.dart';
import 'page/profile/voucher_manager/voucher_detail_manager_page.dart';
import 'package:loto/page/admin/admin_controller.dart';
import 'package:loto/page/admin/admin_page.dart';

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
  static String CHOOSE_IMAGE = '/choose_image';
  static String RECIPE = '/recipe';
  static String RECIPE_DETAIL = '/recipe_detail';
  static String PAYMENT_INFO = '/payment_info';
  static String VIEW_ORDER = '/view_order';
  static String VOUCHER_COLLECTION = '/voucher-collection';
  static String VOUCHER_MANAGER = '/voucher-manager';
  static String VOUCHER_DETAIL_MANAGER = '/voucher-detail-manager';
  static String ADMIN = '/admin';

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
        page: () => const LoginPage(),
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
        middlewares: [
          MyOrderMiddleware()
        ]
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
        page: () => const CartPage(),
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
        page: () => const ProfileManagerPage(),
        binding: ProfileManagerBinding(),
      ),
      GetPage(
        name: COOKING,
        page: () => const ProfileManagerPage(),
        binding: ProfileManagerBinding(),
      ),
      GetPage(
        name: COOKING_MANAGER,
        page: () => const ProfileManagerPage(),
        binding: ProfileManagerBinding(),
      ),
      GetPage(
        name: ORDER_DETAIL_MANAGER,
        page: () => const OrderDetailManagerPage(),
        binding: OrderDetailManagerBinding(),
      ),
      GetPage(
        name: EDIT_PRODUCT_MANAGER,
        page: () => const ProductDetailManagerPage(),
        binding: ProductDetailManagerBinding(),
      ),
      GetPage(
        name: CHOOSE_IMAGE,
        page: () => const ChooseImagePage(),
        binding: ChooseImageBinding(),
      ),
      GetPage(
        name: RECIPE,
        page: () => const RecipePage(),
        binding: RecipeBinding(),
        middlewares: [
          RecipeMiddleware(),
        ]
      ),
      GetPage(
        name: RECIPE_DETAIL,
        page: () => const RecipeDetailPage(),
        binding: RecipeDetailBinding(),
      ),
      GetPage(
        name: PAYMENT_INFO,
        page: () => const PaymentInfoPage(),
        binding: PaymentInfoBinding(),
      ),
      GetPage(
        name: VIEW_ORDER,
        page: () => const ViewOrderPage(),
        binding: ViewOrderBinding(),
        middlewares: [
          MyOrderMiddleware()
        ]
      ),
      GetPage(
        name: VOUCHER_COLLECTION,
        page: () => const VoucherCollectionPage(),
        binding: ProfileBinding(),
      ),
      GetPage(
        name: VOUCHER_MANAGER,
        page: () => const VoucherManagerPage(),
        binding: VoucherManagerBinding(),
      ),
      GetPage(
        name: VOUCHER_DETAIL_MANAGER,
        page: () => const VoucherDetailManagerPage(),
        binding: VoucherDetailManagerBinding(),
      ),
      GetPage(
        name: ADMIN,
        page: () => const AdminPage(),
        binding: AdminBinding(),
      ),
    ];
  }
}