import 'dart:ffi';

import 'package:salla/shared/imports/exports.dart';

class CashHelper
{
  static late SharedPreferences sharedprefrences ;
  static Future init() async
  {
     sharedprefrences = await SharedPreferences.getInstance();
  }
   static Future setData({
    required String key  ,
  required dynamic value ,
}) async
  {
    if(value is int) {
      await sharedprefrences.setInt(key, value);
    } else if (value is String) {
      await sharedprefrences.setString(key, value);
    } else if (value is double) {
      await sharedprefrences.setDouble(key, value);
    }
    else {
      await sharedprefrences.setBool(key, value);
    }
  }

  static bool? getBool({
  required String key
})
  {
    return sharedprefrences.getBool(key);
  }

  static String? getString({
    required String key
  })
  {
    return sharedprefrences.getString(key);
  }
  static Future<bool> removeData({
  required String key
})async
  {
    return await sharedprefrences.remove(key);
  }
}