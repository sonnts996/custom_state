## Getting started

Add dependency to your pubspec.yaml:

```yaml
custom_state: 'any'
```

## Usage

Import packages:

```dart
import 'package:custom_state/custom_state.dart';
```

### CustomView:

```dart
enum YourState{ initial, loading, done }
````

```dart
CustomStateView<YourState>(
    key: stateKey,
    stateBuilder: (context, states, customState) {
        if (states.contains(YourState.initial)) {
            return Text(
                'initial'
                );
        } else if (states.contains(YourState.loading)){
            return Text(
                'Loading'
                );
        } else {
            return Text(
            'Done'
            );
        } 
    },
),
```

* Change state

```dart
final GlobalKey<CustomState<YourState>> stateKey = GlobalKey();
...
stateKey.currentState?.replaceCustomState({YourState.loading});
```


## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/sonnts996/custom_state/issues).