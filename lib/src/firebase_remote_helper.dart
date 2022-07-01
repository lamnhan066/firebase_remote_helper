import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

extension RemoteJson on RemoteConfigValue {
  Map<String, T> asMap<T>() {
    final json = jsonDecode(asString());

    if (json != null) return json as Map<String, T>;

    return {};
  }
}

class FirebaseRemoteHelper {
  FirebaseRemoteHelper._();

  static Future<void> initial({
    Duration fetchTimeout = const Duration(minutes: 1),
    Duration minimumFetchInterval = const Duration(minutes: 60),
    Map<String, dynamic>? defaultParameters,
  }) async {
    await FirebaseRemoteConfig.instance.ensureInitialized();

    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(
      RemoteConfigSettings(
          fetchTimeout: fetchTimeout,
          minimumFetchInterval: minimumFetchInterval),
    );

    if (defaultParameters != null) {
      await remoteConfig.setDefaults(defaultParameters);
    }

    await remoteConfig.fetchAndActivate();
  }

  /// Get value as RemoteConfigValue
  static RemoteConfigValue get(String key) {
    return FirebaseRemoteConfig.instance.getValue(key);
  }

  /// Get value as int
  static int getInt(String key) => get(key).asInt();

  /// Get value as bool
  static bool getBoolean(String key) => get(key).asBool();

  /// Get value as String
  static String getString(String key) => get(key).asString();

  /// Get value as double
  static double getDouble(String key) => get(key).asDouble();

  /// Get value as Map
  ///
  /// T is bool, number, string
  static Map<String, T> getMap<T>(String key) => get(key).asMap<T>();
}
