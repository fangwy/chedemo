class ShareModel {
  static const int ShareOpenTypePage = 0;
  static const int ShareOpenTypeUrl = 1;

  //打开类型 0.内部界面 1.链接 ...
  int openType = 0;
  //页码
  int pageId = 0;
  //外部链接
  String url = '';

  applyJson(Map<String, dynamic> json) {
    if (json.containsKey('open_type')) openType = json['open_type'];
    if (json.containsKey('page_id')) pageId = json['page_id'];
    if (json.containsKey('url')) url = json['url'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['open_type'] = openType;
    data['page_id'] = pageId;
    data['url'] = url;
    return data;
  }
}
