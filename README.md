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
CustomStateView<bool>(
    key: stateKey,
    stateBuilder: (context, states, customState) {
        if (states.contains(true)) {
            return Text(
                '$_counter',
                style: Theme.of(context).textTheme.headline4,
                );
        } else {
            return Text(
                '$_counter',
                style: Theme.of(context)
                    .textTheme
                    .headline4
                    ?.apply(color: Colors.redAccent),
                );
        }
    },
),
```

* Change state

```dart
final GlobalKey<CustomState<bool>> stateKey = GlobalKey();
...
stateKey.currentState?.replaceCustomState({even});
```


## Features and bugs

Please file feature requests and bugs at the [issue tracker](https://github.com/sonnts996/custom_state/issues).