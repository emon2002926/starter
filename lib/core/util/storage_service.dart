import 'package:get_storage/get_storage.dart';

class StorageService {
  static final _box = GetStorage();
  static const _tokenKey = 'access_token';
  static const _refreshTokenKey = 'refresh_token';
  static const _langKey = 'app_lang_code';

  static const _roleKey = 'user_role';

  // Access Token
  static Future<void> saveToken(String accessToken) async {
    await _box.write(_tokenKey, accessToken);
  }

  static String? get accessToken => _box.read(_tokenKey);
  static bool get hasToken => accessToken != null && accessToken!.isNotEmpty;

  // Refresh Token
  static Future<void> saveRefreshToken(String refreshToken) async {
    await _box.write(_refreshTokenKey, refreshToken);
  }

  static String? get refreshToken => _box.read(_refreshTokenKey);

  // User Role
  static Future<void> saveRole(String role) async {
    await _box.write(_roleKey, role);
  }

  static String? get userRole => _box.read(_roleKey);

  // Clear methods
  static Future<void> clearToken() async {
    await _box.remove(_tokenKey);
    await _box.remove(_refreshTokenKey);
  }

  static Future<void> logout() async {
    // Keep language preference across logout.
    final lang = _box.read(_langKey);
    await _box.erase();
    if (lang != null) {
      await _box.write(_langKey, lang);
    }
  }
}