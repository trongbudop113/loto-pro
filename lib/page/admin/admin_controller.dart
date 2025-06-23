import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/page/admin/admin_page.dart';
import 'package:loto/src/color_resource.dart';
import 'package:loto/page_config.dart';

class AdminController extends GetxController {
  // List of admin menu items
  final List<AdminMenuItem> adminMenuItems = [
    AdminMenuItem(
      title: 'Quản lý sản phẩm',
      subtitle: 'Thêm, sửa, xóa sản phẩm',
      icon: Icons.inventory_2,
      color: const Color(0xFF2196F3), // Blue
      route: '/product-management',
    ),
    AdminMenuItem(
      title: 'Quản lý đơn hàng',
      subtitle: 'Xem và xử lý đơn hàng',
      icon: Icons.shopping_cart,
      color: const Color(0xFF4CAF50), // Green
      route: '/order-management',
    ),
    AdminMenuItem(
      title: 'Quản lý người dùng',
      subtitle: 'Quản lý tài khoản user',
      icon: Icons.people,
      color: const Color(0xFFFF9800), // Orange
      route: '/user-management',
    ),
    AdminMenuItem(
      title: 'Xem phân tích',
      subtitle: 'Thống kê và báo cáo',
      icon: Icons.analytics,
      color: const Color(0xFF9C27B0), // Purple
      route: '/analytics',
    ),
    AdminMenuItem(
      title: 'Quản lý danh mục',
      subtitle: 'Phân loại sản phẩm',
      icon: Icons.category,
      color: const Color(0xFF00BCD4), // Cyan
      route: '/category-management',
    ),
    AdminMenuItem(
      title: 'Quản lý khuyến mãi',
      subtitle: 'Voucher và giảm giá',
      icon: Icons.local_offer,
      color: const Color(0xFFFFEB3B), // Yellow
      route: '/promotion-management',
    ),
    AdminMenuItem(
      title: 'Cài đặt hệ thống',
      subtitle: 'Cấu hình ứng dụng',
      icon: Icons.settings,
      color: const Color(0xFFF44336), // Red
      route: '/system-settings',
    ),
    AdminMenuItem(
      title: 'Quản lý nội dung',
      subtitle: 'Banner, tin tức, blog',
      icon: Icons.article,
      color: const Color(0xFFE91E63), // Pink
      route: '/content-management',
    ),
  ];

  @override
  void onInit() {
    super.onInit();
    // Initialize any required data
  }

  // Handle menu item tap
  void onMenuItemTap(AdminMenuItem item) {
    switch (item.route) {
      case '/product-management':
        _navigateToProductManagement();
        break;
      case '/order-management':
        _navigateToOrderManagement();
        break;
      case '/user-management':
        _navigateToUserManagement();
        break;
      case '/analytics':
        _navigateToAnalytics();
        break;
      case '/category-management':
        _navigateToCategoryManagement();
        break;
      case '/promotion-management':
        _navigateToPromotionManagement();
        break;
      case '/system-settings':
        _navigateToSystemSettings();
        break;
      case '/content-management':
        _navigateToContentManagement();
        break;
      default:
        _showComingSoon(item.title);
    }
  }

  void _navigateToProductManagement() {
    // Navigate to product management page
    Get.toNamed(PageConfig.PRODUCT_MANAGER);
  }

  void _navigateToOrderManagement() {
    // Navigate to order management page
    Get.toNamed(PageConfig.ORDER_MANAGER);
  }

  void _navigateToUserManagement() {
    // Navigate to user management page
    Get.toNamed(PageConfig.USER_MANAGER);
  }

  void _navigateToAnalytics() {
    // Navigate to analytics/statistics page
    Get.toNamed(PageConfig.STATISTIC);
  }

  void _navigateToCategoryManagement() {
    // Navigate to category management page
    // Get.toNamed('/category-management');
    _showComingSoon('Quản lý danh mục');
  }

  void _navigateToPromotionManagement() {
    // Navigate to promotion management page
    Get.toNamed(PageConfig.VOUCHER_MANAGER);
  }

  void _navigateToSystemSettings() {
    // Navigate to system settings page
    // Get.toNamed('/system-settings');
    _showComingSoon('Cài đặt hệ thống');
  }

  void _navigateToContentManagement() {
    // Navigate to content management page
    // Get.toNamed('/content-management');
    _showComingSoon('Quản lý nội dung');
  }

  void _showComingSoon(String feature) {
    Get.snackbar(
      'Thông báo',
      '$feature sẽ được phát triển trong phiên bản tiếp theo',
      snackPosition: SnackPosition.BOTTOM,
      backgroundColor: ColorResource.color_main_light,
      colorText: ColorResource.color_white_light,
      duration: const Duration(seconds: 2),
      borderRadius: 12,
      margin: const EdgeInsets.all(16),
    );
  }

  // Refresh admin data
  void refreshData() {
    // Implement refresh logic if needed
    update();
  }
}

class AdminBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut<AdminController>(() => AdminController());
  }
}