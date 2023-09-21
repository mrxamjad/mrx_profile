import 'package:shared_preferences/shared_preferences.dart';

class SharePref{

// Obtain shared preferences.
  static Future<void> setAdmin(bool status) async {
    // Obtain shared preferences.
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    try{
      await prefs.setBool('admin',status);
    }catch(e){
      print("Could not set admin");
    }


  }

  static Future<bool> checkAdmin() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    print(prefs.getBool('admin')?? false);


      return  prefs.getBool('admin')?? false;



  }
}