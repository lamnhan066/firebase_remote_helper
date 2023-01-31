import 'dart:convert';

import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:firebase_remote_helper/firebase_remote_helper.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Check all possible return types', () {
    // Default parameters
    final Map<String, dynamic> parameters = {
      'bool': true,
      'int': 5,
      'String': 'This is string',
      'mapInt': {'a': 1, 'b': 2},
      'mapString': {'a': 'a', 'b': 'b'},
      'mapBool': {'a': true, 'b': false},
      'mapBoolJson': jsonEncode({'a': true, 'b': false}),
      'listInt': [1, 2, 3],
      'listString': ['a', 'b', 'c'],
      'listBool': [true, false, true],
      'listBoolJson': jsonEncode([true, false, true]),
    };

    // Format values
    final Map<String, dynamic> formated =
        FirebaseRemoteHelper.formatParameters(parameters);

    // Convert formated values to RemoteConfigValues
    final Map<String, RemoteConfigValue> configValues = formated.map(
      (key, value) => MapEntry(
        key,
        RemoteConfigValue(
          const Utf8Codec().encode(value.toString()),
          ValueSource.valueDefault,
        ),
      ),
    );

    expect(parameters['bool'], equals(configValues['bool']?.asBool()));
    expect(parameters['int'], equals(configValues['int']?.asInt()));
    expect(parameters['String'], equals(configValues['String']?.asString()));
    expect(parameters['mapInt'], equals(configValues['mapInt']?.asMap<int>()));
    expect(parameters['mapString'],
        equals(configValues['mapString']?.asMap<String>()));
    expect(
        parameters['mapBool'], equals(configValues['mapBool']?.asMap<bool>()));
    expect(parameters['mapBool'],
        equals(configValues['mapBoolJson']?.asMap<bool>()));
    expect(
        parameters['listInt'], equals(configValues['listInt']?.asList<int>()));
    expect(parameters['listString'],
        equals(configValues['listString']?.asList<String>()));
    expect(parameters['listBool'],
        equals(configValues['listBool']?.asList<bool>()));
    expect(parameters['listBool'],
        equals(configValues['listBoolJson']?.asList<bool>()));
  });

  test('Using unsupported types', () {
    // Default parameters
    final Map<String, dynamic> parameters = {
      'map': {1: 1, 'b': 2},
    };

    // Format values
    try {
      FirebaseRemoteHelper.formatParameters(parameters);
    } catch (e) {
      expect(e, isA<ArgumentError>());
    }
  });
}
