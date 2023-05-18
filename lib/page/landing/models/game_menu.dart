class GameMenu {
  String? gameID;
  String? gameName;
  String? page;
  String? gameIcon;

  GameMenu(
      {this.gameID,
        this.gameName,
        this.page,
        this.gameIcon
      });

  GameMenu.fromJson(Map<String, dynamic> json) {
    gameID = json['game_id'];
    gameName = json['game_name'];
    page = json['page'];
    gameIcon = json['game_icon'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['game_id'] = this.gameID;
    data['game_name'] = this.gameName;
    data['page'] = this.page;
    data['game_icon'] = this.gameIcon;
    return data;
  }
}