# Firebase Remote Helper

## Usage

``` dart
// Get the instance
final remoteHelper = FirebaseRemoteHelper.instance;

// Initialize
await remoteHelper.initial(
    fetchTimeout: const Duration(minutes: 1), // Default is 1 minute
    minimumFetchInterval: const Duration(minutes: 60), // Default is 60 minutes
    defaultParameters: {}, // Default is not set
});

// Or you can call initial
remoteHelper.initial(
    fetchTimeout: const Duration(minutes: 1), // Default is 1 minute
    minimumFetchInterval: const Duration(minutes: 60), // Default is 60 minutes
    defaultParameters: {}, // Default is not set
});
// And wait for the initial later
await remoteHelper.ensureInitialized;

// Get value 
remoteHelper.get('key'); // .asBool, .asInt, .asDouble, .asString, .asMap

remoteHelper.getInt('key');
remoteHelper.getBool('key');
remoteHelper.getDouble('key');
remoteHelper.getString('key');
remoteHelper.getMap('key');
```
