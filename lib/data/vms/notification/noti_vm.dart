class NotificationVM {
  String? title;
  String? body;
  String? sentTime;
  bool? isRead;
  String? redirectUrl ;

  NotificationVM(title, body,sentTime, {this.isRead = false,this.redirectUrl});

  NotificationVM.fromJson(Map<String, dynamic> json) {
    title = json['title'];
    body = json['body'];
    sentTime = json['sentTime'];
    isRead = json['isRead'] == 1;
    redirectUrl = json['redirectUrl'];

  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['title'] = title;
    data['body'] = body;
    data['sentTime'] = sentTime;
    data['isRead'] = '$isRead';
    data['redirectUrl'] = redirectUrl;
    return data;
  }
}
