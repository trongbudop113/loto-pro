enum MembershipTier {
  bronze,
  silver,
  gold,
  platinum
}

extension MembershipTierExtension on MembershipTier {
  String get name {
    switch (this) {
      case MembershipTier.bronze:
        return 'Bronze';
      case MembershipTier.silver:
        return 'Silver';
      case MembershipTier.gold:
        return 'Gold';
      case MembershipTier.platinum:
        return 'Platinum';
    }
  }

  String get displayName {
    switch (this) {
      case MembershipTier.bronze:
        return 'Thành viên Đồng';
      case MembershipTier.silver:
        return 'Thành viên Bạc';
      case MembershipTier.gold:
        return 'Thành viên Vàng';
      case MembershipTier.platinum:
        return 'Thành viên Bạch Kim';
    }
  }

  int get color {
    switch (this) {
      case MembershipTier.bronze:
        return 0xFFCD7F32; // Bronze color
      case MembershipTier.silver:
        return 0xFFC0C0C0; // Silver color
      case MembershipTier.gold:
        return 0xFFFFD700; // Gold color
      case MembershipTier.platinum:
        return 0xFFE5E4E2; // Platinum color
    }
  }

  String get icon {
    switch (this) {
      case MembershipTier.bronze:
        return '🥉';
      case MembershipTier.silver:
        return '🥈';
      case MembershipTier.gold:
        return '🥇';
      case MembershipTier.platinum:
        return '💎';
    }
  }

  int get requiredPoints {
    switch (this) {
      case MembershipTier.bronze:
        return 0;
      case MembershipTier.silver:
        return 1000;
      case MembershipTier.gold:
        return 5000;
      case MembershipTier.platinum:
        return 15000;
    }
  }

  static MembershipTier fromPoints(int points) {
    if (points >= MembershipTier.platinum.requiredPoints) {
      return MembershipTier.platinum;
    } else if (points >= MembershipTier.gold.requiredPoints) {
      return MembershipTier.gold;
    } else if (points >= MembershipTier.silver.requiredPoints) {
      return MembershipTier.silver;
    } else {
      return MembershipTier.bronze;
    }
  }

  static MembershipTier fromString(String? tierString) {
    switch (tierString?.toLowerCase()) {
      case 'silver':
        return MembershipTier.silver;
      case 'gold':
        return MembershipTier.gold;
      case 'platinum':
        return MembershipTier.platinum;
      default:
        return MembershipTier.bronze;
    }
  }
}