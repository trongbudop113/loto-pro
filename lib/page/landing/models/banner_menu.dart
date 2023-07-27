class BannerMenu {
  String? bannerID;
  String? bannerContent;
  String? bannerImage;
  String? page;

  BannerMenu(
      {this.bannerID,
        this.bannerContent,
        this.bannerImage,
        this.page
      });

  BannerMenu.fromJson(Map<String, dynamic> json) {
    bannerID = json['banner_id'];
    bannerContent = json['banner_name'];
    bannerImage = json['banner_image'];
    page = json['page'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['banner_id'] = this.bannerID;
    data['banner_name'] = this.bannerContent;
    data['banner_image'] = this.bannerImage;
    data['page'] = this.page;
    return data;
  }
}