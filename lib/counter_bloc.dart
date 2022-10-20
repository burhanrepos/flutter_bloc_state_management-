import 'dart:async';

enum CounterAction { Increment, Decrement, Reset }

class CounterBloc {
  int counter = 0;

  final _stateStreamController = StreamController<int>();
  StreamSink<int> get counterSink => _stateStreamController.sink;
  Stream<int> get counterStream => _stateStreamController.stream;

  final _eventStreamController = StreamController<dynamic>();
  StreamSink<dynamic> get eventSink => _eventStreamController.sink;
  Stream<dynamic> get eventStream => _eventStreamController.stream;

  CounterBloc() {
    counter = 0;
    eventStream.listen((event) {
      if (event == CounterAction.Increment)
        counter++;
      else if (event == CounterAction.Decrement && counter > 0) {
        counter--;
      } else if (event == CounterAction.Reset) counter = 0;

      counterSink.add(counter);
    });
  }
}
