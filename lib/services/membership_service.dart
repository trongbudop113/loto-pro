import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:loto/database/data_name.dart';
import 'package:loto/models/membership_tier.dart';
import 'package:loto/models/user_login.dart';

class MembershipService {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  
  // Point calculation constants
  static const int POINTS_PER_ORDER = 100;
  static const int POINTS_PER_DOLLAR_SPENT = 1;
  static const int BONUS_POINTS_LOGIN = 10;
  static const int BONUS_POINTS_FIRST_ORDER = 500;
  static const int BONUS_POINTS_REFERRAL = 1000;

  /// Cập nhật điểm thành viên khi người dùng thực hiện đơn hàng
  static Future<void> updatePointsForOrder({
    required String userId,
    required double orderAmount,
    bool isFirstOrder = false,
  }) async {
    try {
      final userRef = _firestore.collection(DataRowName.Users.name).doc(userId);
      
      await _firestore.runTransaction((transaction) async {
        final userDoc = await transaction.get(userRef);
        
        if (!userDoc.exists) return;
        
        final userData = userDoc.data() as Map<String, dynamic>;
        final currentPoints = userData['membershipPoints'] ?? 0;
        final currentTotalSpent = userData['totalSpent'] ?? 0;
        final currentTotalOrders = userData['totalOrders'] ?? 0;
        
        // Tính điểm mới
        int newPoints = currentPoints;
        newPoints += POINTS_PER_ORDER; // Điểm cơ bản cho mỗi đơn hàng
        newPoints += (orderAmount * POINTS_PER_DOLLAR_SPENT).round(); // Điểm theo số tiền
        
        if (isFirstOrder) {
          newPoints += BONUS_POINTS_FIRST_ORDER; // Bonus cho đơn hàng đầu tiên
        }
        
        // Cập nhật dữ liệu
        transaction.update(userRef, {
          'membershipPoints': newPoints,
          'totalSpent': currentTotalSpent + orderAmount.round(),
          'totalOrders': currentTotalOrders + 1,
          'updateTime': DateTime.now().millisecondsSinceEpoch,
        });
      });
    } catch (e) {
      print('Error updating membership points: $e');
    }
  }

  /// Cập nhật điểm khi người dùng đăng nhập hàng ngày
  static Future<void> updatePointsForDailyLogin(String userId) async {
    try {
      final userRef = _firestore.collection(DataRowName.Users.name).doc(userId);
      final userDoc = await userRef.get();
      
      if (!userDoc.exists) return;
      
      final userData = userDoc.data() as Map<String, dynamic>;
      final lastLoginTime = userData['lastSignInTime'] ?? 0;
      final currentPoints = userData['membershipPoints'] ?? 0;
      
      // Kiểm tra xem có phải đăng nhập mới trong ngày không
      final now = DateTime.now();
      final lastLogin = DateTime.fromMillisecondsSinceEpoch(lastLoginTime);
      
      if (now.day != lastLogin.day || now.month != lastLogin.month || now.year != lastLogin.year) {
        await userRef.update({
          'membershipPoints': currentPoints + BONUS_POINTS_LOGIN,
          'updateTime': now.millisecondsSinceEpoch,
        });
      }
    } catch (e) {
      print('Error updating daily login points: $e');
    }
  }

  /// Khởi tạo thành viên mới
  static Future<void> initializeMembership(String userId) async {
    try {
      final userRef = _firestore.collection(DataRowName.Users.name).doc(userId);
      final now = DateTime.now().millisecondsSinceEpoch;
      
      await userRef.update({
        'membershipPoints': 0,
        'membershipLevel': MembershipTier.bronze.name,
        'totalSpent': 0,
        'totalOrders': 0,
        'membershipJoinDate': now,
        'updateTime': now,
      });
    } catch (e) {
      print('Error initializing membership: $e');
    }
  }

  /// Lấy thông tin xếp hạng của người dùng
  static Future<UserLogin?> getUserMembershipInfo(String userId) async {
    try {
      final userDoc = await _firestore.collection(DataRowName.Users.name).doc(userId).get();
      
      if (!userDoc.exists) return null;
      
      return UserLogin.fromJson(userDoc.data() as Map<String, dynamic>);
    } catch (e) {
      print('Error getting user membership info: $e');
      return null;
    }
  }

  /// Cập nhật điểm thưởng cho việc giới thiệu bạn bè
  static Future<void> updatePointsForReferral(String referrerId) async {
    try {
      final userRef = _firestore.collection(DataRowName.Users.name).doc(referrerId);
      final userDoc = await userRef.get();
      
      if (!userDoc.exists) return;
      
      final userData = userDoc.data() as Map<String, dynamic>;
      final currentPoints = userData['membershipPoints'] ?? 0;
      
      await userRef.update({
        'membershipPoints': currentPoints + BONUS_POINTS_REFERRAL,
        'updateTime': DateTime.now().millisecondsSinceEpoch,
      });
    } catch (e) {
      print('Error updating referral points: $e');
    }
  }

  /// Lấy danh sách top thành viên
  static Future<List<UserLogin>> getTopMembers({int limit = 10}) async {
    try {
      final querySnapshot = await _firestore
          .collection(DataRowName.Users.name)
          .orderBy('membershipPoints', descending: true)
          .limit(limit)
          .get();
      
      return querySnapshot.docs
          .map((doc) => UserLogin.fromJson(doc.data()))
          .toList();
    } catch (e) {
      print('Error getting top members: $e');
      return [];
    }
  }

  /// Kiểm tra và cập nhật cấp độ thành viên
  static Future<bool> checkAndUpdateMembershipTier(String userId) async {
    try {
      final userRef = _firestore.collection(DataRowName.Users.name).doc(userId);
      final userDoc = await userRef.get();
      
      if (!userDoc.exists) return false;
      
      final userData = userDoc.data() as Map<String, dynamic>;
      final currentPoints = userData['membershipPoints'] ?? 0;
      final currentLevel = userData['membershipLevel'];
      
      final newTier = MembershipTierExtension.fromPoints(currentPoints);
      final newLevel = newTier.name;
      
      if (currentLevel != newLevel) {
        await userRef.update({
          'membershipLevel': newLevel,
          'updateTime': DateTime.now().millisecondsSinceEpoch,
        });
        return true; // Có thay đổi cấp độ
      }
      
      return false; // Không có thay đổi
    } catch (e) {
      print('Error checking membership tier: $e');
      return false;
    }
  }
}