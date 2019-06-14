import './storage.dart';
import 'dart:convert';

class UserInfo {
  static updateUserInfo(value) async {
    await Storage.set('userInfo', value);
  }

  static setUserInfoItem(key, value) async {
    var userInfo = await getUserInfo();
    userInfo[key] = value;
    await updateUserInfo(userInfo);
  }

  static getUserInfo() async {
    return jsonDecode(await Storage.get('userInfo'));
  }

  static getUserItem(String key) async {
    Map<String, dynamic> userInfo = jsonDecode(await Storage.get('userInfo'));
    return userInfo[key];
  }
}