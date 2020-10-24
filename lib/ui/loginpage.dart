import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/login/login_bloc.dart';
import 'package:ui_practice/repository/user_repository.dart';
import 'package:ui_practice/ui/loginform.dart';
import 'package:meta/meta.dart';

class LoginPage extends StatefulWidget {
  final UserRepository userRepository;

  const LoginPage({Key key, @required this.userRepository})
      : assert(userRepository != null),
        super(key: key);

  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  LoginBloc _loginBloc;

  AuthenticationBloc _authenticationBloc;
  UserRepository get userRepo => widget.userRepository;

  @override
  void initState() {
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    _loginBloc = LoginBloc(
        userRepository: userRepo, authenticationBloc: _authenticationBloc);
    super.initState();
  }

  @override
  Widget build(context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: LoginForm(
        loginBloc: _loginBloc,
        authenticationBloc: _authenticationBloc,
      ),
    );
  }

  @override
  void dispose() {
    _loginBloc.close();
    super.dispose();
  }
}
