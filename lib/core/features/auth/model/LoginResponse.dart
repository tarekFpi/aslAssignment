class LoginResponse {
  LoginResponse({
      int? statusCode, 
      bool? success, 
      String? message, 
      dynamic meta, 
      Data? data,}){
    _statusCode = statusCode;
    _success = success;
    _message = message;
    _meta = meta;
    _data = data;
}

  LoginResponse.fromJson(dynamic json) {
    _statusCode = json['statusCode'];
    _success = json['success'];
    _message = json['message'];
    _meta = json['meta'];
    _data = json['data'] != null ? Data.fromJson(json['data']) : null;
  }
  int? _statusCode;
  bool? _success;
  String? _message;
  dynamic _meta;
  Data? _data;

  int? get statusCode => _statusCode;
  bool? get success => _success;
  String? get message => _message;
  dynamic get meta => _meta;
  Data? get data => _data;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['statusCode'] = _statusCode;
    map['success'] = _success;
    map['message'] = _message;
    map['meta'] = _meta;
    if (_data != null) {
      map['data'] = _data?.toJson();
    }
    return map;
  }

}

class Data {
  Data({
      String? accessToken, 
      String? refreshToken,}){
    _accessToken = accessToken;
    _refreshToken = refreshToken;
}

  Data.fromJson(dynamic json) {
    _accessToken = json['accessToken'];
    _refreshToken = json['refreshToken'];
  }
  String? _accessToken;
  String? _refreshToken;

  String? get accessToken => _accessToken;
  String? get refreshToken => _refreshToken;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['accessToken'] = _accessToken;
    map['refreshToken'] = _refreshToken;
    return map;
  }

}