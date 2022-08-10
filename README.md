# Firebase Remote Helper

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
remoteHelper.get('key'); // .asBool, .asInt, .asDouble, .asString, .asMap

remoteHelper.getInt('key');
remoteHelper.getBool('key');
remoteHelper.getDouble('key');
remoteHelper.getString('key');
remoteHelper.getMap('key');
```
