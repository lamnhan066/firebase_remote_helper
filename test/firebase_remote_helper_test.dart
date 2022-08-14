import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';

void main() {
  test('Decode firebase remote config', () {
    // Map<String, String>
    var mapString = jsonEncode({'>=1.0.0': "yes"});
    print(Map<String, String>.from(jsonDecode(mapString)));
    // Map<String, int>
    mapString = jsonEncode({'>=1.0.0': 1});
    print(Map<String, int>.from(jsonDecode(mapString)));
    // Map<String, double>
    mapString = jsonEncode({'>=1.0.0': 1.0});
    print(Map<String, double>.from(jsonDecode(mapString)));
    // Map<String, bool>
    mapString = jsonEncode({'>=1.0.0': true});
    print(Map<String, bool>.from(jsonDecode(mapString)));
  });
}
