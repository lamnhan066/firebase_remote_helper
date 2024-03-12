# Firebase Remote Helper

This plugin makes it easier for you to use firebase remote config.

## Usage

Await for the initialization:

``` dart
// Get the instance
final remoteHelper = FirebaseRemoteHelper.instance;

// Initialize
await remoteHelper.initial(
    fetchTimeout: const Duration(seconds: 3), // Optional: default is 1 minute
    minimumFetchInterval: const Duration(minutes: 60), // Optional: default is 60 minutes
    defaultParameters: {
        'bool': true,
        'int': 5,
        'String': 'This is string',
        'mapInt': {'a': 1, 'b': 2},
        'mapString': {'a': 'a', 'b': 'b'},
        'mapBool': {'a': true, 'b': false},
        'listInt': [1, 2, 3],
        'listString': ['a', 'b', 'c'],
        'listBool': [true, false, true],
    }, // Optional: default is not set
);
```

Or you can call initial and await for it later:

``` dart
// Initialize
remoteHelper.initial();

// And wait for the initial later
await remoteHelper.ensureInitialized;
```

**NOTE:** You should provide default values for all used parameters to avoid issues.

Get value as specific `type`:

``` dart
/// Number: 
/// Example value on firebase: 1
remoteHelper.getInt('key');

/// Boolean:
/// Example value on firebase: true/false
remoteHelper.getBool('key');

/// Number:
/// Example value on firebase: 1.0
remoteHelper.getDouble('key');

/// String: 
/// Example value on firebase: "something"
remoteHelper.getString('key');

/// JSON as List: 
/// Example value on firebase: ["something", "something other"]
///
/// Only support bool, num, String as return type of list
remoteHelper.getList<String>('key');

/// JSON as Map:
/// Example value on firebase: {"someKey": 1, "someKey other": 2}
///
/// Only support bool, num, String as return type of map's values
remoteHelper.getMap<int>('key');
```

Get value as `RemoteConfigValue`:

``` dart
/// Return RemoteConfigValue
/// Then you can use .asBool, .asInt, .asDouble, .asString, .asMap, .asList
remoteHelper.get('key'); 
```
