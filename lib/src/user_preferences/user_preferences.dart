import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {

  static final UserPreferences _instance = new UserPreferences._internal();

  factory UserPreferences() {
    return _instance;
  }

  UserPreferences._internal();

  SharedPreferences _prefs;

  initPrefs() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // GETTERS and SETTERS
  get token {
    return this._prefs.getString('token') ?? '';
  }
  set token (String value) {
    this._prefs.setString('token', value);
  }

  /*
  get secondaryColor {
    return this._prefs.getBool('secondaryColor') ?? false;
  }
  set secondaryColor (bool value) {
    this._prefs.setBool('secondaryColor', value);
  }


  get username {
    return this._prefs.getString('username') ?? '';
  }
  set username (String value) {
    this._prefs.setString('username', value);
  }

  get lastPage {
    return this._prefs.getString('lastPage') ?? 'home';
  }
  set lastPage (String value) {
    this._prefs.setString('lastPage', value);
  }
  */

}