import 'dart:async';
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
  final instance = FirebaseRemoteHelper._();

  FirebaseRemoteHelper._();

  final _ensureInitializedCompleter = Completer<bool>();

  Future<bool> get ensureInitialized => _ensureInitializedCompleter.future;

  Future<void> initial({
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

    _ensureInitializedCompleter.complete(true);
  }

  /// Get value as RemoteConfigValue
  RemoteConfigValue get(String key) {
    return FirebaseRemoteConfig.instance.getValue(key);
  }

  /// Get value as int
  int getInt(String key) => get(key).asInt();

  /// Get value as bool
  bool getBoolean(String key) => get(key).asBool();

  /// Get value as String
  String getString(String key) => get(key).asString();

  /// Get value as double
  double getDouble(String key) => get(key).asDouble();

  /// Get value as Map
  ///
  /// T is bool, number, string
  Map<String, T> getMap<T>(String key) => get(key).asMap<T>();
}
