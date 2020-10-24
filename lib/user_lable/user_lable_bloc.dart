import 'package:bloc/bloc.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/authentication/authentication_state.dart';
import 'package:ui_practice/repository/user_repository.dart';
import 'package:ui_practice/user_lable/user_lable_event.dart';
import 'package:ui_practice/user_lable/user_lable_state.dart';
import 'dart:async';

class UserLableBloc extends Bloc<UserLableEvent, UserLableState> {
  StreamSubscription authBlocSubscription;
  final AuthenticationBloc _authenticationBloc;
  final UserRepository _userRepo;

  UserLableBloc(this._authenticationBloc, this._userRepo)
      : super(UserLableStateInitial()) {
    authBlocSubscription = _authenticationBloc.listen((state) {
      if (state is AuthenticationAuthenticated) {
        add(UserLableAutheticatedEvent());
      }
    });
  }

  Stream<UserLableState> _broadCastEvent() async* {
    var name = await _userRepo.getUserName();
    yield UserLableStateAutheticated(name);
  }

  @override
  Stream<UserLableState> mapEventToState(UserLableEvent event) async* {
    if (event is UserLableAutheticatedEvent) {
      var name = await _userRepo.getUserName();
      yield UserLableStateAutheticated(name);
    }
  }

  Future<void> close() {
    authBlocSubscription.cancel();
    return super.close();
  }
}
