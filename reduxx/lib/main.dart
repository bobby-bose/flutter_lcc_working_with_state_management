import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:redux/redux.dart';

void main() {
  final store = Store<int>(counterReducer, initialState: 0);

  runApp(MyApp(store: store));
}

int counterReducer(int state, dynamic action) {
  if (action == CounterActions.increment) {
    return state + 1;
  } else if (action == CounterActions.decrement) {
    return state - 1;
  }
  return state;
}

enum CounterActions { increment, decrement }

class MyApp extends StatelessWidget {
  final Store<int> store;

  MyApp({required this.store});

  @override
  Widget build(BuildContext context) {
    return StoreProvider<int>(
      store: store,
      child: MaterialApp(
        title: 'Flutter Redux Example',
        theme: ThemeData(primarySwatch: Colors.blue),
        home: CounterPage(),
      ),
    );
  }
}

class CounterPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Counter')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            StoreConnector<int, int>(
              converter: (store) => store.state,
              builder: (context, count) {
                return Text('Count: $count', style: TextStyle(fontSize: 24));
              },
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                StoreConnector<int, VoidCallback>(
                  converter: (store) =>
                      () => store.dispatch(CounterActions.increment),
                  builder: (context, callback) {
                    return ElevatedButton(
                      child: Text('Increment'),
                      onPressed: callback,
                    );
                  },
                ),
                SizedBox(width: 16),
                StoreConnector<int, VoidCallback>(
                  converter: (store) =>
                      () => store.dispatch(CounterActions.decrement),
                  builder: (context, callback) {
                    return ElevatedButton(
                      child: Text('Decrement'),
                      onPressed: callback,
                    );
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
