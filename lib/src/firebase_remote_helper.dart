import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';

extension RemoteMap on RemoteConfigValue {
  /// Get value as Map
  ///
  /// Result: Map<String, T> with T is bool, number, string
  Map<String, T> asMap<T>() {
    final json = jsonDecode(asString());

    if (json != null) return Map<String, T>.from(json);

    return {};
  }

  /// Get value as List
  ///
  /// List<T> with T is bool, number, string
  List<T> asList<T>() {
    final json = jsonDecode(asString());

    if (json != null) return List<T>.from(json);

    return [];
  }
}

class FirebaseRemoteHelper {
  static final instance = FirebaseRemoteHelper._();

  FirebaseRemoteHelper._();

  final _ensureInitializedCompleter = Completer<bool>();

  /// Return when the plugin is initialized
  ///
  /// Returns a [bool] that is true if the config parameters were activated.
  /// Returns a [bool] that is false if the config parameters were already activated.
  Future<bool> get ensureInitialized => _ensureInitializedCompleter.future;

  /// Initialize the plugin
  Future<void> initial({
    Duration fetchTimeout = const Duration(minutes: 1),
    Duration minimumFetchInterval = const Duration(minutes: 60),
    Map<String, dynamic>? defaultParameters,
  }) async {
    // Prevent initialize this plugin again
    if (_ensureInitializedCompleter.isCompleted) return;

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

    final isActivated = await remoteConfig.fetchAndActivate();

    _ensureInitializedCompleter.complete(isActivated);
  }

  /// Get value as RemoteConfigValue
  RemoteConfigValue get(String key) {
    return FirebaseRemoteConfig.instance.getValue(key);
  }

  /// Get value as int
  int getInt(String key) => get(key).asInt();

  /// Get value as bool
  bool getBool(String key) => get(key).asBool();

  /// Get value as String
  String getString(String key) => get(key).asString();

  /// Get value as double
  double getDouble(String key) => get(key).asDouble();

  /// Get value as Map
  ///
  /// Result: Map<String, T> with T is bool, number, string
  Map<String, T> getMap<T>(String key) => get(key).asMap<T>();

  /// Get value as List
  ///
  /// List<T> with T is bool, number, string
  List<T> getList<T>(String key) => get(key).asList<T>();
}
