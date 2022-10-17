# Firebase Remote Helper

This plugin makes it easier for you to use firebase remote config.

## Usage

Await for the initialization:

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
remoteHelper.getList('key');

/// JSON as Map:
/// Example value on firebase: {"someKey":"someValue", "someKey other":"someValue other"}
remoteHelper.getMap('key');
```

Get value as `RemoteConfigValue`:

``` dart
/// Return RemoteConfigValue
/// Then you can use .asBool, .asInt, .asDouble, .asString, .asMap, .asList
remoteHelper.get('key'); 
```
