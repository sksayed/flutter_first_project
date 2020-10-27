import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
import 'package:ui_practice/app.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/authentication/authentication_event.dart';
import 'package:ui_practice/authentication/authentication_state.dart';
import 'package:ui_practice/bloc/bloc_observer.dart';
import 'package:ui_practice/repository/user_repository.dart';
import 'package:ui_practice/ui/homepage.dart';
import 'package:ui_practice/ui/loginpage.dart';
import 'package:ui_practice/ui/splash_page.dart';
import 'package:ui_practice/ui/statelesswidget.dart';
import 'package:meta/meta.dart';

void main() {
  Bloc.observer = SimpleBlocObserver();
  runApp(App(userRepository: UserRepository()));
}

class SimpleBlocDelegate {
  @override
  void onTransition(Transition transition) {
    print(transition.toString());
  }
}


