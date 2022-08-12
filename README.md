# Firebase Remote Helper

This plugin makes it easier for you to use firebase remote config.

## Usage

Await for the initialization

``` dart
// Get the instance
final remoteHelper = FirebaseRemoteHelper.instance;

// Initialize
await remoteHelper.initial(
    fetchTimeout: const Duration(minutes: 1), // Optinal: default is 1 minute
    minimumFetchInterval: const Duration(minutes: 60), // Optinal: default is 60 minutes
    defaultParameters: {}, // Optinal: default is not set
);
```

Or you can call initial and await for it later:

``` dart
// Initialize
remoteHelper.initial(
    fetchTimeout: const Duration(minutes: 1), // Optinal: default is 1 minute
    minimumFetchInterval: const Duration(minutes: 60), // Optinal: default is 60 minutes
    defaultParameters: {}, // Optinal: default is not set
);

// And wait for the initial later
await remoteHelper.ensureInitialized;
```

Get value

``` dart
/// Return RemoteConfigValue
remoteHelper.get('key'); // .asBool, .asInt, .asDouble, .asString, .asMap, .asList

/// Number: 1
remoteHelper.getInt('key');

/// Boolean: true/false
remoteHelper.getBool('key');

/// Number: 1.0
remoteHelper.getDouble('key');

/// String: "something"
remoteHelper.getString('key');

/// JSON: ["something", "something other"]
remoteHelper.getMap('key');

/// JSON: {"someKey":"someValue", "someKey other":"someValue other"}
remoteHelper.getList('key');
```
