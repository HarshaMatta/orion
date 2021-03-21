
import 'package:flutter/cupertino.dart';
import 'package:shared_preferences/shared_preferences.dart';

const String URL_SUFFIX = "_url";
const String ICON_SUFFIX = "_icon";
const String COLOR_SUFFIX = "_color";

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

class AppProps {
  String name;
  String url;
  int iconCodePoint;
  int color;
}

Future<Map<String, AppProps>> loadAppNameValue() async {
  final prefs = await SharedPreferences.getInstance();
  Map<String, AppProps> appNames = new Map<String, AppProps>();
  prefs.getKeys().forEach((key) {
    if(key.endsWith(URL_SUFFIX)) {
      var name = key.substring(0, key.length - URL_SUFFIX.length);
      if( name.isNotEmpty) {
        var props = new AppProps();
        props.name = name;
        props.url = prefs.getString(key);
        props.iconCodePoint = prefs.getInt(name+ICON_SUFFIX);
        props.color = prefs.getInt(name+COLOR_SUFFIX);
        appNames[name] = props;
      }
    }
  });
  
  return appNames;
}

void saveAppNameValue(String name, String url, int icon, int color) async {
  if(name.isNotEmpty && url.isNotEmpty) {
    final prefs = await SharedPreferences.getInstance();
    prefs.setString(name + URL_SUFFIX, url);
    prefs.setInt(name+ICON_SUFFIX, icon);
    prefs.setInt(name+COLOR_SUFFIX, color);
  }
}

void deleteFromPref(String name) async{
  final prefs = await SharedPreferences.getInstance();
  prefs.remove(name + URL_SUFFIX);
  prefs.remove(name + ICON_SUFFIX);
  prefs.remove(name + COLOR_SUFFIX);
}
