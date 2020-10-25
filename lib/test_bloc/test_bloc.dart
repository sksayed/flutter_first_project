import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/test_bloc/test_bloc_event.dart';
import 'package:ui_practice/test_bloc/test_bloc_state.dart';

class TestBloc extends Bloc<TestEvent, TestState> {
  TestBloc() : super(TestState());

  String getMyName() {
    return "Sheikh Sayed Bin";
  }

  @override
  Stream<TestState> mapEventToState(TestEvent event) {}
}
