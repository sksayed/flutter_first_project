import 'package:flutter_bloc/flutter_bloc.dart';
import '../repository/user_repository.dart';
import 'authentication_event.dart';
import 'authentication_state.dart';
import 'package:meta/meta.dart';
import 'package:bloc/bloc.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  final UserRepository userRepository;

  AuthenticationBloc({@required this.userRepository})
      : assert(userRepository != null),
        super(AuthenticationUninitialized());

  @override
  // TODO: implement initialState
  AuthenticationState get initialState => AuthenticationUninitialized();

  @override
  Stream<AuthenticationState> mapEventToState(
      AuthenticationEvent event) async* {
    if (event is AppStarted) {
      //do what you need to do during app start
      //check if the user has token
      final bool hasToken = await userRepository.hasToken();
      if (hasToken) {
        yield AuthenticationAuthenticated();
      } else {
        yield AuthenticationUnauthenticated();
      }
    }

    if (event is LoggedIn) {
      //do when user is logged in
      yield AuthenticationLoading();
      await userRepository.persistToken(token: event.token);
      yield AuthenticationAuthenticated();
    }

    if (event is LoggedOut) {
      //do when user is logged out
      yield AuthenticationLoading();
      await userRepository.deleteToken();
      yield AuthenticationUnauthenticated();
    }
  }
}
