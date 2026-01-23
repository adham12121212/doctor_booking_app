
import 'package:shared_preferences/shared_preferences.dart';

class PrefHelper {
  static const String kIsOnboarding = 'is_onboarding';
  static const String kIsLoggedIn = 'is_logged_in';

  static Future<void> setIsOnboarding(bool value) async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(kIsOnboarding, value);
  }

  static Future<bool> getIsOnboarding() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool(kIsOnboarding) ?? false;
  }



}
