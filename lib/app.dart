import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/authentication/authentication_event.dart';
import 'package:ui_practice/authentication/authentication_state.dart';
import 'package:ui_practice/repository/user_repository.dart';
import 'package:ui_practice/route/route_generator.dart';
import 'package:ui_practice/ui/homepage.dart';
import 'package:ui_practice/ui/loginpage.dart';
import 'package:ui_practice/ui/splash_page.dart';
import 'package:ui_practice/ui/statelesswidget.dart';

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
    return RepositoryProvider(
      create: (repositoryContext) => userRepository,
      child: BlocProvider<AuthenticationBloc>(
        create: (context) => authenticationBloc,
        lazy: false,
        child: MaterialApp(
          onGenerateRoute: RouteGenerator.generateRoute,
          home: BlocBuilder<AuthenticationBloc, AuthenticationState>(
            builder: (context, AuthenticationState state) {
              if (state is AuthenticationUninitialized) {
                return SplashPage();
              }
              if (state is AuthenticationAuthenticated) {
                return HomePage();
              }
              if (state is AuthenticationLoading) {
                return LoadingIndicator();
              }
              if (state is AuthenticationUnauthenticated) {
                return LoginPage();
              }

              return Scaffold(
                body: Center(
                  child: Text("None of the state was invoked"),
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
