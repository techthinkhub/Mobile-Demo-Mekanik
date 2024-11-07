import 'package:get_storage/get_storage.dart';
import 'package:mekanik/app/data/publik.dart';

class LocalStorages {
  static GetStorage boxToken = GetStorage('token-mekanik');
  static GetStorage boxPreferences = GetStorage('preferences-mekanik');

  // Token handling
  static Future<bool> hasToken() async {
    String token = await getToken;
    return token.isNotEmpty;
  }

  static Future<void> setToken(String token) async {
    await boxToken.write('token', token);
    Publics.controller.getToken.value = LocalStorages.getToken;
    return;
  }

  static String get getToken => boxToken.listenable.value['token'] ?? '';

  static Future<void> deleteToken() async {
    await boxToken.remove('token');
    Publics.controller.getToken.value = ''; // Set nilai token kosong setelah dihapus
  }

  // Keep me signed in handling
  static Future<void> setKeepMeSignedIn(bool keepSignedIn) async {
    await boxPreferences.write('keepMeSignedIn', keepSignedIn);
  }

  static Future<bool> getKeepMeSignedIn() async {
    return boxPreferences.read('keepMeSignedIn') ?? false;
  }

  static Future<void> deleteKeepMeSignedIn() async {
    await boxPreferences.remove('keepMeSignedIn');
  }

  // Logout function to clear both token and keep me signed in preference
  static Future<void> logout() async {
    await deleteToken(); // Panggil fungsi deleteToken
    await deleteKeepMeSignedIn(); // Hapus status keep me signed in
    // Tambahkan kode lain yang perlu dijalankan saat logout, jika ada
  }
}
