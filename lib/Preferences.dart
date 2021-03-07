
import 'package:shared_preferences/shared_preferences.dart';

const String APP_SUFFIX = "_app";

// Future<String> readStringPref(String key) async {
//   final prefs = await SharedPreferences.getInstance();
//   return prefs.getString(key) ?? null;
// }

// void saveStringPref(String key, String value) async{
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setString(key, value);
// }
//
// void saveStringListPref(String key, List<String> value) async{
//   final prefs = await SharedPreferences.getInstance();
//   prefs.setStringList(key, value);
// }

Future<Map<String, String>> loadAppNameValue() async {
  final prefs = await SharedPreferences.getInstance();
  Map<String, String> appNames = new Map<String, String>();
  prefs.getKeys().forEach((key) {
    if(key.endsWith(APP_SUFFIX)) {
      var name = key.substring(0, key.length - APP_SUFFIX.length);
      if( name.isNotEmpty) {
        var url = prefs.getString(key);
        appNames[name] = url;
      }
    }
  });
  
  return appNames;
}

void saveAppNameValue(String name, String url) async {
  if(name.isNotEmpty && url.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(name + APP_SUFFIX, url);
  }
}

void deleteFromPref(String name) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(name + APP_SUFFIX);
}
