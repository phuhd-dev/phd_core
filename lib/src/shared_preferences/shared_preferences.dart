import 'package:flutter_secure_storage/flutter_secure_storage.dart';

import 'base_preferences.dart';
import '../constants.dart';

class SharedPreferences extends BasePreference {
  SharedPreferences({String groupId, String accountName})
      : super(
          androidOptions: AndroidOptions(),
          iosOptions: IOSOptions(
            groupId: groupId,
            accountName: accountName ?? IOSOptions.defaultAccountName,
          ),
        );

  Future<String> get accessToken async => await getValue(PreferenceKey.accessToken, isSecure: true);

  Future setAccessToken(String accessToken) async => await setSecureValue(PreferenceKey.accessToken, accessToken);

  Future clearAccessToken() async => await remove(PreferenceKey.accessToken, isSecure: true);

  Future<String> get refreshToken async => await getValue(PreferenceKey.refreshToken, isSecure: true);

  Future setRefreshToken(String refreshToken) async => await setSecureValue(PreferenceKey.refreshToken, refreshToken);

  Future clearRefreshToken() async => await remove(PreferenceKey.refreshToken, isSecure: true);

  Future<String> get expiresIn async => await getValue(PreferenceKey.expiresIn, isSecure: true);

  Future setExpiresIn(String expiresIn) async => await setSecureValue(PreferenceKey.expiresIn, expiresIn);

  Future clearExpiresIn() async => await remove(PreferenceKey.expiresIn, isSecure: true);
}
