# Firebase Remote Helper

## Usage

``` dart
// Initialize
await FirebaseRemoteHelper.initial(
    fetchTimeout: const Duration(minutes: 1), // Default is 1 minute
    minimumFetchInterval: const Duration(minutes: 60), // Default is 60 minutes
    defaultParameters: {}, // Default is not set
});

// Get value 
FirebaseRemoteHelper.get('key'); // ,asBool, .asInt, .asDouble, .asString, .asMap
FirebaseRemoteHelper.getInt('key');
FirebaseRemoteHelper.getBool('key');
FirebaseRemoteHelper.getDouble('key');
FirebaseRemoteHelper.getString('key');
FirebaseRemoteHelper.getMap('key');
```
