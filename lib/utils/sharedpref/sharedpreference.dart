import 'package:shared_preferences/shared_preferences.dart';

class LocalPreference {
  static SharedPreferences? _preferences;

  static const _keySingWith = 'SingWithKey';
  static const _keyUserRole = 'userRoles';
  static const _keyOrderId = 'orderId';
  //----------------------------------
  static Future clearAllPreference() => _preferences!.clear();
  //----------------------------------

  static Future init() async =>
      _preferences = await SharedPreferences.getInstance();
  //--------------------------------------------------------------
  static Future setSignWith(String? val) async =>
      await _preferences!.setString(_keySingWith, val!);
  static String? getSignWith() => _preferences?.getString(_keySingWith);
  static Future<bool>? deleteSignWith() => _preferences?.remove(_keySingWith);

  //------------------------------------------------------------------------
  static Future setUserRole(String? val) async =>
      await _preferences!.setString(_keyUserRole, val!);
  static String? getUserRole() => _preferences?.getString(_keyUserRole);
  static Future<bool>? deleteUserRole() => _preferences?.remove(_keyUserRole);

  //----------------------------------------------------------------------------
  static Future setOrderId(String? val) async =>
      await _preferences!.setString(_keyOrderId, val!);
  static String? getOrderId() => _preferences!.getString(_keyOrderId);
  static Future<bool>? deleteOrderId() => _preferences?.remove(_keyOrderId);
//--------------------------------------------------------------
//--------------------------------------------------------------
//--------------------------------------------------------------
//--------------------------------------------------------------
//--------------------------------------------------------------
}