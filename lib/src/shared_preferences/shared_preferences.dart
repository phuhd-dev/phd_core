// import 'package:secure_storage/secure_storage.dart';
// import 'base_preferences.dart';
// import '../constants.dart';
//
// class SharedPreferences extends BasePreference {
//
//   SharedPreferences({AndroidOptions androidOptions, IOSOptions iosOptions}) : super(androidOptions: androidOptions, iosOptions: iosOptions);
//
//   Future<String> get accessToken async => await getValue(PreferenceKey.accessToken, isSecure: true);
//
//   Future setAccessToken(String accessToken) async => await setSecureValue(PreferenceKey.accessToken, accessToken);
//
//   Future<String> get refreshToken async => await getValue(PreferenceKey.refreshToken, isSecure: true);
//
//   Future setRefreshToken(String refreshToken) async => await setSecureValue(PreferenceKey.refreshToken, refreshToken);
//
//   Future<String> get expiresIn async => await getValue(PreferenceKey.expiresIn, isSecure: true);
//
//   Future setExpiresIn(String expiresIn) async => await setSecureValue(PreferenceKey.expiresIn, expiresIn);
// }
