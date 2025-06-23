import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/page/statistic/app_color.dart';
import 'package:loto/page/statistic/models/raw_data.dart';
import 'package:loto/page/shopping/cart/models/order_cart.dart';
import 'package:loto/common/mesage_util.dart';

/// Binding class for StatisticController dependency injection
class StatisticBinding extends Bindings {
  @override
  void dependencies() {
    Get.lazyPut(() => StatisticController());
  }
}

/// Controller for managing statistics data and UI state
class StatisticController extends GetxController {

  final fashionColor = AppColors.contentColorRed;

  // Chart interaction state
  final RxInt selectedDataSetIndex = (-1).obs;
  final RxDouble angleValue = 0.0.obs;
  final RxBool relativeAngleMode = true.obs;
  final RxInt touchedIndex = (-1).obs;
  
  // Statistics data management
  final RxBool isLoading = false.obs;
  final RxString errorMessage = ''.obs;
  final RxList<OrderCart> orders = <OrderCart>[].obs;
  final RxMap<String, int> productStatistics = <String, int>{}.obs;
  final RxMap<String, double> revenueStatistics = <String, double>{}.obs;
  final RxMap<String, int> monthlyOrderStatistics = <String, int>{}.obs;
  final RxMap<String, double> monthlyRevenueStatistics = <String, double>{}.obs;

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  @override
  void onInit() {
    super.onInit();
    loadOrderStatistics();
  }

  /// Refresh statistics data
  Future<void> refreshData() async {
    await loadOrderStatistics();
  }
  
  /// Load order statistics from Firestore
  Future<void> loadOrderStatistics() async {
    try {
      isLoading.value = true;
      errorMessage.value = '';

      // Get orders document
      final ordersDoc = await _firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Orders.name)
          .get();

      if (!ordersDoc.exists) {
        errorMessage.value = 'Không tìm thấy dữ liệu đơn hàng';
        return;
      }

      _clearStatistics();

      // Parse orders data
      final lsOrderTime = LsOrderTime.fromJson(ordersDoc.data() as Map<String, dynamic>);

      // Process orders in parallel for better performance
      final futures = lsOrderTime.lsOrderTime.map((orderTime) => 
        _processOrderTime(orderTime)
      );
      
      await Future.wait(futures);
      
    } catch (e) {
      errorMessage.value = 'Lỗi khi tải dữ liệu thống kê: $e';
      MessageUtil.show(msg: 'Lỗi khi tải dữ liệu thống kê');
    } finally {
      isLoading.value = false;
    }
  }

  /// Clear all statistics data
  void _clearStatistics() {
    orders.clear();
    productStatistics.clear();
    revenueStatistics.clear();
    monthlyOrderStatistics.clear();
    monthlyRevenueStatistics.clear();
  }

  /// Process orders for a specific time period
  Future<void> _processOrderTime(OrderTime orderTime) async {
    if (orderTime.orderDateID?.isEmpty ?? true) return;
    
    final orderByMonth = await _getDateOrderByDate(orderTime.orderDateID!);
    
    // Process monthly statistics
    final monthKey = _getMonthKeyFromDateID(orderTime.orderDateID!);
    monthlyOrderStatistics[monthKey] = (monthlyOrderStatistics[monthKey] ?? 0) + orderByMonth.length;
    
    double monthlyRevenue = 0;
    for (var order in orderByMonth) {
      orders.add(order);
      _processOrderProducts(order);
      monthlyRevenue += order.totalPrice ?? 0;
    }
    
    monthlyRevenueStatistics[monthKey] = (monthlyRevenueStatistics[monthKey] ?? 0) + monthlyRevenue;
  }

  /// Process products in an order for statistics
  void _processOrderProducts(OrderCart order) {
    if (order.listProductItem == null) return;
    
    for (var productOrder in order.listProductItem!) {
      final quantity = productOrder.quantity.value;
      
      // Process main product (boxCake)
      if (productOrder.boxCake != null) {
        _addProductStatistics(
          productOrder.boxCake!.productName ?? 'Sản phẩm không tên',
          quantity,
          productOrder.productPrice * quantity,
        );
      }

      // Process moon cake products
      if (productOrder.productMoonCakeList != null) {
        for (var cakeProduct in productOrder.productMoonCakeList!) {
          _addProductStatistics(
            cakeProduct.productName ?? 'Sản phẩm không tên',
            quantity,
            (cakeProduct.productPrice ?? 0) * quantity,
          );
        }
      }
    }
  }

  /// Add product statistics
  void _addProductStatistics(String productName, int quantity, double revenue) {
    productStatistics[productName] = (productStatistics[productName] ?? 0) + quantity;
    revenueStatistics[productName] = (revenueStatistics[productName] ?? 0) + revenue;
  }

  /// Get orders by date ID
  Future<List<OrderCart>> _getDateOrderByDate(String orderDateID) async {
    try {
      final querySnapshot = await _firestore
          .collection(DataRowName.Cakes.name)
          .doc(DataCollection.Orders.name)
          .collection(orderDateID)
          .get();

      return querySnapshot.docs
          .map((doc) => OrderCart.fromJson(doc.data()))
          .toList();

    } catch (e) {
      print('Error in _getDateOrderByDate: $e');
      return [];
    }
  }
  
  /// Get top selling products by quantity
  List<MapEntry<String, int>> getTopSellingProducts({int limit = 5}) {
    if (productStatistics.isEmpty) return [];
    
    final sortedProducts = productStatistics.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedProducts.take(limit).toList();
  }
  
  /// Get top revenue products
  List<MapEntry<String, double>> getTopRevenueProducts({int limit = 5}) {
    if (revenueStatistics.isEmpty) return [];
    
    final sortedProducts = revenueStatistics.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    return sortedProducts.take(limit).toList();
  }
  
  /// Calculate total revenue
  double get totalRevenue {
    return revenueStatistics.values.fold(0.0, (sum, value) => sum + value);
  }
  
  /// Calculate total products sold
  int get totalProductsSold {
    return productStatistics.values.fold(0, (sum, value) => sum + value);
  }
  
  /// Get total number of orders
  int get totalOrders {
    return orders.length;
  }

  /// Get average order value
  double get averageOrderValue {
    if (totalOrders == 0) return 0.0;
    return totalRevenue / totalOrders;
  }

  /// Check if statistics data is available
  bool get hasData {
    return productStatistics.isNotEmpty || revenueStatistics.isNotEmpty;
  }

  /// Convert orderDateID to month key (YYYY-MM format)
  String _getMonthKeyFromDateID(String orderDateID) {
    // orderDateID format is typically YYYYMMDD or similar
    if (orderDateID.length >= 6) {
      final year = orderDateID.substring(0, 4);
      final month = orderDateID.substring(4, 6);
      return '$year-$month';
    }
    return orderDateID;
  }

  /// Get monthly order statistics sorted by month
  List<MapEntry<String, int>> getMonthlyOrderStatistics() {
    if (monthlyOrderStatistics.isEmpty) return [];
    
    final sortedMonths = monthlyOrderStatistics.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sortedMonths;
  }

  /// Get monthly revenue statistics sorted by month
  List<MapEntry<String, double>> getMonthlyRevenueStatistics() {
    if (monthlyRevenueStatistics.isEmpty) return [];
    
    final sortedMonths = monthlyRevenueStatistics.entries.toList()
      ..sort((a, b) => a.key.compareTo(b.key));
    return sortedMonths;
  }

  /// Get formatted month name from month key
  String getFormattedMonthName(String monthKey) {
    try {
      final parts = monthKey.split('-');
      if (parts.length == 2) {
        final year = parts[0];
        final month = int.parse(parts[1]);
        const monthNames = [
          'T1', 'T2', 'T3', 'T4', 'T5', 'T6',
          'T7', 'T8', 'T9', 'T10', 'T11', 'T12'
        ];
        if (month >= 1 && month <= 12) {
          return '${monthNames[month - 1]}/$year';
        }
      }
    } catch (e) {
      print('Error formatting month name: $e');
    }
    return monthKey;
  }

  /// Generate raw data sets for radar chart
  List<RawDataSet> rawDataSets() {
    final topProducts = getTopSellingProducts(limit: 5);
    
    if (topProducts.isEmpty) {
      return [
        RawDataSet(
          title: 'Chưa có dữ liệu',
          color: fashionColor,
          values: [0, 0, 0],
        ),
      ];
    }
    
    const colors = [
      AppColors.contentColorRed,
      AppColors.contentColorCyan,
      AppColors.contentColorWhite,
      AppColors.contentColorYellow,
      AppColors.contentColorGreen,
    ];
    
    return topProducts.asMap().entries.map((entry) {
      final index = entry.key;
      final product = entry.value;
      final productName = product.key;
      final quantity = product.value.toDouble();
      final revenue = revenueStatistics[productName] ?? 0;
      
      return RawDataSet(
        title: _truncateProductName(productName),
        color: colors[index % colors.length],
        values: [
          quantity,
          revenue / 1000, // Convert to thousands for better visualization
          quantity * 0.8, // Estimated value for third metric
        ],
      );
    }).toList();
  }

  /// Truncate product name for display
  String _truncateProductName(String name, {int maxLength = 15}) {
    return name.length > maxLength ? '${name.substring(0, maxLength)}...' : name;
  }

  /// Generate radar data sets for chart display
  List<RadarDataSet> showingDataSets() {
    return rawDataSets().asMap().entries.map((entry) {
      final index = entry.key;
      final rawDataSet = entry.value;
      final isSelected = _isDataSetSelected(index);

      return RadarDataSet(
        fillColor: isSelected
            ? rawDataSet.color.withOpacity(0.2)
            : rawDataSet.color.withOpacity(0.05),
        borderColor: isSelected 
            ? rawDataSet.color 
            : rawDataSet.color.withOpacity(0.25),
        entryRadius: isSelected ? 3.0 : 2.0,
        dataEntries: rawDataSet.values
            .map((value) => RadarEntry(value: value))
            .toList(),
        borderWidth: isSelected ? 2.3 : 2.0,
      );
    }).toList();
  }

  /// Check if a data set is selected
  bool _isDataSetSelected(int index) {
    return selectedDataSetIndex.value == -1 || selectedDataSetIndex.value == index;
  }

  /// Update selected data set index
  void updateSelectedDataSet(int index) {
    selectedDataSetIndex.value = selectedDataSetIndex.value == index ? -1 : index;
  }

  /// Reset chart selection
  void resetSelection() {
    selectedDataSetIndex.value = -1;
    touchedIndex.value = -1;
  }
}