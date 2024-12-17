class StoryLineRes {
  String? timeline;
  String? storyImage;
  String? storyName;
  String? storyDetail;
  int? storySort;

  StoryLineRes(
      {this.timeline,
        this.storyImage,
        this.storyName,
        this.storyDetail,
        this.storySort});

  StoryLineRes.fromJson(Map<String, dynamic> json) {
    timeline = json['timeline'];
    storyImage = json['story_image'];
    storyName = json['story_name'];
    storyDetail = json['story_detail'];
    storySort = json['story_sort'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['timeline'] = this.timeline;
    data['story_image'] = this.storyImage;
    data['story_name'] = this.storyName;
    data['story_detail'] = this.storyDetail;
    data['story_sort'] = this.storySort;
    return data;
  }
}