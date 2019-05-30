import './storage.dart';

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
    return await Storage.get('userInfo');
  }
}