import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/authentication/authentication_event.dart';
import 'package:ui_practice/homepage/home_bloc.dart';
import 'package:ui_practice/homepage/home_page_event.dart';

class DefaultHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print(" inside defalut homepage and its context is " + context.toString());
    return Container(
        child: Center(
      child: Column(
        children: [
          Text(context.toString()),
          RaisedButton(
            child: Text('logout'),
            onPressed: () {
              var c = BlocProvider.of<AuthenticationBloc>(context);
              print(c.toString() + " " + c.getMyName());
              //implement the logic
              // BlocProvider.of<AuthenticationBloc>(context).add(LoggedOut());
              BlocProvider.of<HomePageBloc>(context)
                  .add(HomePageModifiedButtonPressedEvent());
              /*BlocProvider.of<HomePageBloc>(context)
                      .add(HomePageLogoutButtonClicked());
                  print(c.toString() + " " + c.getMyName());*/
            },
          ),
        ],
      ),
    ));
  }
}
