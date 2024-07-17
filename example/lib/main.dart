import 'package:custom_state/custom_state.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  final GlobalKey<CustomState<CustomStateView, bool>> stateKey = GlobalKey();
  final GlobalKey<CustomState<StateButton, ButtonState>> stateButtonKey =
      GlobalKey();
  Set<ButtonState> buttonState = {ButtonState.fail};
  Set<bool> customState = {false};

  void _incrementCounter([int? reset]) {
    setState(() {
      _counter = reset ?? _counter + 1;
      final bool even = _counter % 2 == 0;
      customState = {even};
    });
    final bool even = _counter % 2 == 0;
    stateKey.currentState?.replaceCustomState({even});
    // stateButtonKey.currentState?.setCustomState(ButtonState.disable, even);
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Invoke "debug painting" (press "p" in the console, choose the
          // "Toggle Debug Paint" action from the Flutter Inspector in Android
          // Studio, or the "Toggle Debug Paint" command in Visual Studio Code)
          // to see the wireframe for each widget.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Padding(
                padding: EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  'You have pushed the button [+] this many times, Press first button for parity check, Press second button for reset:',
                  textAlign: TextAlign.center,
                )),
            CustomStateView<bool>(
              key: stateKey,
              stateBuilder: (context, states, customState) {
                if (states.contains(true)) {
                  return Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    '$_counter',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.apply(color: Colors.redAccent),
                  );
                }
              },
            ),
            CustomStateView<bool>(
              initialStates: const {false},
              states: customState,
              stateBuilder: (context, states, customState) {
                if (states.contains(true)) {
                  return Text(
                    '$_counter',
                    style: Theme.of(context).textTheme.headlineMedium,
                  );
                } else {
                  return Text(
                    '$_counter',
                    style: Theme.of(context)
                        .textTheme
                        .headlineMedium
                        ?.apply(color: Colors.redAccent),
                  );
                }
              },
            ),
            StateButton.future(
              key: stateButtonKey,
              successIcon: const Icon(Icons.check),
              failIcon: const Icon(Icons.close),
              loaderIcon: Transform.scale(
                  scale: 0.6,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )),
              futureOnTab: _updateState,
              style: StateButton.styleFrom(
                  minimumSize: const Size(100, 40),
                  success: Colors.greenAccent,
                  disable: Colors.grey,
                  fail: Colors.redAccent),
              initial: const Text('CHECK (2s)'),
              success: const Text('EVEN'),
              fail: const Text('ODD'),
              loader: const Text('Loading..'),
            ),
            StateButton(
              states: buttonState,
              successIcon: const Icon(Icons.check),
              failIcon: const Icon(Icons.close),
              loaderIcon: Transform.scale(
                  scale: 0.6,
                  child: const CircularProgressIndicator(
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                  )),
              onTap: (customState) {
                setState(() {
                  buttonState = {ButtonState.success};
                });
              },
              style: StateButton.styleFrom(
                  disable: Colors.grey,
                  minimumSize: const Size(100, 40),
                  success: Colors.greenAccent,
                  fail: Colors.redAccent),
              initial: const Text('CHECK (2s)'),
              success: const Text('EVEN'),
              fail: const Text('ODD'),
              loader: const Text('Loading..'),
            ),
            StateButton.future(
                futureOnTab: ({Set<ButtonState>? currentState}) async {
                  await Future.delayed(const Duration(seconds: 2));
                  _incrementCounter(0);
                  stateButtonKey.currentState
                      ?.replaceCustomState({ButtonState.initial});
                  return {ButtonState.success};
                },
                style: StateButton.styleFrom(minimumSize: const Size(100, 40)),
                initial: const Text('RESET (2s)')),
            StateTextButton.future(
                futureOnTab: _updateState,
                style: StateTextButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    success: Colors.green,
                    fail: Colors.red,
                    disable: Colors.grey),
                initial: const Text('RESET (2s)')),
            StateOutlinedButton.future(
                futureOnTab: _updateState,
                style: StateOutlinedButton.styleFrom(
                    minimumSize: const Size(100, 40),
                    success: Colors.green,
                    fail: Colors.red,
                    successSide: const BorderSide(color: Colors.green),
                    disable: Colors.grey),
                initial: const Text('RESET (2s)')),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }

  Future<Set<ButtonState>> _updateState(
      {Set<ButtonState>? currentState}) async {
    await Future.delayed(const Duration(seconds: 2));
    if (_counter % 2 == 0) {
      return {ButtonState.success, ButtonState.forceDisabled};
    } else {
      return {ButtonState.fail, ButtonState.forceDisabled};
    }
  }
}
