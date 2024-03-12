import 'dart:async';
import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';

extension RemoteMap on RemoteConfigValue {
  /// Get value as Map.
  ///
  /// This method will try to cast to your return type.
  /// If error occurs, [onError] is returned. If [onError] is null, an exception will be thrown.
  ///
  /// If you met [ArgumentError] then you're using unsupported return types.
  Map<String, T> asMap<T>({Map<String, T>? onError = const {}}) {
    try {
      final json = jsonDecode(asString()) as Map<String, dynamic>?;
      FirebaseRemoteHelper._printDebug('asMap json: $json');

      if (json != null) {
        return json.cast<String, T>();
      }
    } catch (e) {
      FirebaseRemoteHelper._printDebug('asMap ERROR: $e');
      if (onError == null) rethrow;
    }

    return onError ?? {};
  }

  /// Get value as List.
  ///
  /// List<T> with T is bool, number, string.
  ///
  /// If error occurs, [onError] is returned. If [onError] is null, an exception will be thrown.
  ///
  /// If you met [ArgumentError] then you're using unsupported return types.
  List<T> asList<T>({List<T>? onError = const []}) {
    try {
      final json = jsonDecode(asString()) as List<dynamic>?;
      FirebaseRemoteHelper._printDebug('asList json: $json');

      if (json != null) {
        return json.cast<T>();
      }
    } catch (e) {
      FirebaseRemoteHelper._printDebug('asList ERROR: $e');
      if (onError == null) rethrow;
    }

    return onError ?? [];
  }
}

class FirebaseRemoteHelper {
  /// Get the instance of FirebaseRemoteHelper.
  static final instance = FirebaseRemoteHelper._();

  static bool _debugLog = false;

  FirebaseRemoteHelper._();

  final _ensureInitializedCompleter = Completer<bool>();

  /// Return when the plugin is initialized.
  ///
  /// Returns a [bool] that is true if the config parameters were activated.
  /// Returns a [bool] that is false if the config parameters were already activated.
  Future<bool> get ensureInitialized => _ensureInitializedCompleter.future;

  /// Initialize the plugin
  Future<void> initial({
    /// Timeout. Default is 1 minute.
    Duration fetchTimeout = const Duration(minutes: 1),

    /// Minimum fetch interval. Default is 60 minutes.
    Duration minimumFetchInterval = const Duration(minutes: 60),

    /// Default parameters. Supports ints, bools, Strings, Lists and Maps.
    ///
    /// List is known as JSON with `[]` bracket on firebase remote config
    /// Only support num, bool and String as return type of List.
    ///
    /// Map is known as JSON with `{}` bracket on firebase remote config
    /// Only support num, bool and String as return type of Map's values.
    ///
    /// Throw [ArgumentError] if you're using unsupported type.
    ///
    /// Ex:
    /// {
    ///    'bool': true,
    ///    'int': 5,
    ///    'String': 'This is string',
    ///    'mapInt': {'a': 1, 'b': 2},
    ///    'mapString': {'a': 'a', 'b': 'b'},
    ///    'mapBool': {'a': true, 'b': false},
    ///    'listInt': [1, 2, 3],
    ///    'listString': ['a', 'b', 'c'],
    ///    'listBool': [true, false, true],
    /// }
    Map<String, dynamic>? defaultParameters,

    /// Show debug log
    bool debugLog = false,
  }) async {
    try {
      _debugLog = debugLog;

      // Prevent initialize this plugin again.
      if (_ensureInitializedCompleter.isCompleted) return;

      await FirebaseRemoteConfig.instance.ensureInitialized();

      final remoteConfig = FirebaseRemoteConfig.instance;

      await remoteConfig.setConfigSettings(
        RemoteConfigSettings(
            fetchTimeout: fetchTimeout,
            minimumFetchInterval: minimumFetchInterval),
      );

      if (defaultParameters != null) {
        final formatedParameters = _formatParameters(defaultParameters);
        await remoteConfig.setDefaults(formatedParameters);

        _printDebug('Set default values: $formatedParameters');
      }

      await remoteConfig.fetch().timeout(fetchTimeout, onTimeout: () {
        _printDebug('Timeout is exceeded, run `fetch` again in background`');
        remoteConfig.fetchAndActivate();
      });

      final isActivated = await remoteConfig.activate();

      _ensureInitializedCompleter.complete(isActivated);
      _printDebug('Initialized');
    } catch (e) {
      _printDebug(
          '! Cannot connect to the firebase config server with error: $e');
    }
  }

  /// Only for testing.
  @visibleForTesting
  static Map<String, dynamic> formatParameters(Map<String, dynamic> params) =>
      _formatParameters(params);

  /// Format parameters.
  static Map<String, dynamic> _formatParameters(Map<String, dynamic> params) {
    return params.map((key, value) {
      if (value is num || value is bool || value is String) {
        return MapEntry(key, value);
      }

      if (value is Map<String, Object> || value is List<Object>) {
        return MapEntry(key, jsonEncode(value));
      }

      if (value is Map) {
        throw ArgumentError(
            'Invalid value type "${value.runtimeType}" for key "$key". '
            'Map must be a Map<String, Object>');
      }

      if (value is List) {
        throw ArgumentError(
          'Invalid value type "${value.runtimeType}" for key "$key". '
          'List must be a List<Object>',
        );
      }

      throw ArgumentError(
        'Invalid value type "${value.runtimeType}" for key "$key". '
        'Only booleans, numbers, strings, List<Object> and Map<String, Object> are supported as config values. '
        "If you're trying to pass a json object – convert it to string beforehand",
      );
    });
  }

  /// Get value as RemoteConfigValue.
  RemoteConfigValue get(String key) {
    return FirebaseRemoteConfig.instance.getValue(key);
  }

  /// Get value as int.
  int getInt(String key) => get(key).asInt();

  /// Get value as bool.
  bool getBool(String key) => get(key).asBool();

  /// Get value as String.
  String getString(String key) => get(key).asString();

  /// Get value as double.
  double getDouble(String key) => get(key).asDouble();

  /// Get value as Map.
  ///
  /// Result: Map<String, T> with T is bool, number, string. If error occurs, [onError] is returned.
  /// If [onError] is null, an exception will be thrown.
  Map<String, T> getMap<T>(
    String key, {
    Map<String, T>? onError = const {},
  }) =>
      get(key).asMap<T>(onError: onError);

  /// Get value as List.
  ///
  /// List<T> with T is bool, number, string. If error occurs, [onError] is returned.
  /// If [onError] is null, an exception will be thrown.
  List<T> getList<T>(
    String key, {
    List<T>? onError = const [],
  }) =>
      get(key).asList<T>(onError: onError);

  static void _printDebug(Object? object) {
    // ignore: avoid_print
    if (_debugLog) print('[FirebaseRemoteHelper] $object');
  }
}
