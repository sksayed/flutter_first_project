import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/authentication/authentication_event.dart';
import 'package:ui_practice/authentication/authentication_state.dart';
import 'package:ui_practice/repository/user_repository.dart';
import 'package:ui_practice/ui/flutter_secure_storage.dart';
import 'package:ui_practice/user_lable/user_lable_bloc.dart';
import 'package:ui_practice/user_lable/user_lable_event.dart';
import 'package:ui_practice/user_lable/user_lable_state.dart';

class HomePage extends StatefulWidget {
  final UserRepository _userRepository;

  HomePage(
    this._userRepository, {
    Key key,
  }) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  //it needs a appbar lable mvc
  // so it needs a bloc
  UserLableBloc userLableBloc;
  AuthenticationBloc _authenticationBloc;

  @override
  void initState() {
    // TODO: implement initState
    _authenticationBloc = BlocProvider.of<AuthenticationBloc>(context);
    userLableBloc = UserLableBloc(_authenticationBloc, widget._userRepository);
    userLableBloc.add(UserLableAutheticatedEvent());
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    userLableBloc.close();
    super.dispose();
  }

  @override
  Widget build(context) {
    return SafeArea(
      top: true,
      child: Scaffold(
          drawer: Drawer(
            semanticLabel: "i dont know what it is ",
            child: ListView(),
          ),
          appBar: AppBar(
            title: BlocBuilder<UserLableBloc, UserLableState>(
                cubit: userLableBloc,
                builder: (context, state) {
                  if (state is UserLableStateInitial) {
                    userLableBloc.add(UserLableAutheticatedEvent());
                  }
                  if (state is UserLableStateAutheticated) {
                    return Text(state.userName);
                  } else {
                    return Text("");
                  }
                }),
          ),
          body: Container(
            child: Center(
              child: RaisedButton(
                child: Text('logout'),
                onPressed: () {
                  //implement the logic
                  BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
                },
              ),
            ),
          )),
    );
  }
}
