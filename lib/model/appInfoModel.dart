class AppInfoModel {
  String? appname;
  String? os;
  String? ownername;
  String? xAPIToken;
  String? imageUrl;

  AppInfoModel(
      {this.appname, this.os, this.ownername, this.xAPIToken, this.imageUrl});

  AppInfoModel.fromJson(Map<String, dynamic> json) {
    appname = json['appname'];
    os = json['os'];
    ownername = json['ownername'];
    xAPIToken = json['X-API-Token'];
    imageUrl = json['imageUrl'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['appname'] = appname;
    data['os'] = os;
    data['ownername'] = ownername;
    data['X-API-Token'] = xAPIToken;
    data['imageUrl'] = imageUrl;
    return data;
  }
}
