import 'package:shared_preferences/shared_preferences.dart';

class CacheHelper{


  static SharedPreferences? sharedPreferences;


  static Future<SharedPreferences?> init() async {
    sharedPreferences =  await SharedPreferences.getInstance();
  }


  static Future<bool?> putBoolenData(String key,dynamic value) async{
    return await sharedPreferences?.setBool(key, value);
  }

  static Future<bool?> putStringData(String key,dynamic value) async{
    return await sharedPreferences?.setString(key, value);
  }


  static dynamic getData(String key) {
    return sharedPreferences?.get(key);
  }

  static dynamic DeleteData(String key) {
    return sharedPreferences?.remove(key);
  }

  static bool? getBoolenData(String key) {
    if (sharedPreferences!.getBool(key) != null){
      return sharedPreferences!.getBool(key);
    }else {
      return false;
    }
  }




}