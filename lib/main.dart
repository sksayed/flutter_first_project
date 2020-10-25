import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bloc/bloc.dart';
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

class App extends StatefulWidget {
  final UserRepository userRepository;

  const App({Key key, @required this.userRepository}) : super(key: key);

  @override
  _AppState createState() => _AppState();
}

class _AppState extends State<App> {
  AuthenticationBloc authenticationBloc;

  UserRepository get userRepository => widget.userRepository;

  @override
  void initState() {
    authenticationBloc = AuthenticationBloc(userRepository: userRepository);
    authenticationBloc.add(AppStarted());
    super.initState();
  }

  @override
  void dispose() {
    authenticationBloc.close();
    super.dispose();
  }

  @override
  Widget build(context) {
    return BlocProvider<AuthenticationBloc>(
      create: (context) => authenticationBloc,
      lazy: false,
      child: MaterialApp(
        home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
          builder: (context, AuthenticationState state) {
            if (state is AuthenticationUninitialized) {
              return SplashPage();
            }
            if (state is AuthenticationAuthenticated) {
              return HomePage(userRepository);
            }
            if (state is AuthenticationLoading) {
              return LoadingIndicator();
            }
            if (state is AuthenticationUnauthenticated) {
              return LoginPage(userRepository: userRepository);
            }

            return Scaffold(
              body: Center(
                child: Text("None of the state was invoked"),
              ),
            );
          },
        ),
      ),
    );
  }
}
