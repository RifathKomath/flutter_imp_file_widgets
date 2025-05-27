import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:valet_parking_app/app/view/auth/login_view.dart';
import '../../app/model/auth/auth_response.dart';
import '../../config.dart';
import 'screen_util.dart';

class SharedPref {
  SharedPreferences? sharedPref;

  Future<SharedPreferences> get _instance async =>
      sharedPref ??= await SharedPreferences.getInstance();

  Future<SharedPreferences> init() async {
    sharedPref = await _instance;
    return sharedPref!;
  }

  Future<bool> save({required String key, required dynamic value}) async {
    print('IsMultipleImageEnable3$value');
    if (sharedPref == null) await init();
    switch (value.runtimeType) {
      case const (String):
        return await sharedPref!.setString(key, value);
      case const (bool):
        return await sharedPref!.setBool(key, value);
      case const (int):
        return await sharedPref!.setInt(key, value);
      case const (double):
        return await sharedPref!.setDouble(key, value);
      default:
        return await sharedPref!.setString(key, jsonEncode(value));
    }
  }

    Future<UserData?> getUserData() async {
    if (sharedPref == null) await init();
    final String? userDataJson = sharedPref?.getString("userdata");
    if (userDataJson != null) {
      userData = UserData.fromJson(jsonDecode(userDataJson));
      return userData;
    }
    return null;
  }

  Future<Map<String, String>?> getLastUserCredentials() async {
    if (sharedPref == null) await init();
    final username = sharedPref!.getString('lastUsername');
    final password = sharedPref!.getString('lastPassword');

    if (username != null && password != null) {
      return {'username': username, 'password': password};
    }
    return null;
  }
  // Future<UserData?> getUserData() async {
  //   if (sharedPref == null) await init();
  //   final String? userDataJson = sharedPref?.getString("userdata");
  //   if (userDataJson != null) {
  //     userData = UserData.fromJson(jsonDecode(userDataJson));
  //     return userData;
  //   }
  //   return null;
  // }

  logout() async {
    if (sharedPref == null) await init();
    sharedPref!.remove("token");
    sharedPref!.remove("userdata");
    Screen.openAsNewPage(const LoginView());
  }
}
