import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:ui_practice/authentication/authentication_bloc.dart';
import 'package:ui_practice/authentication/authentication_event.dart';
import 'package:ui_practice/login/login_event.dart';
import 'package:ui_practice/login/login_state.dart';
import 'package:ui_practice/repository/user_repository.dart';

class LoginBloc extends Bloc<LoginEvent, LoginState> {
  final UserRepository userRepository;
  final AuthenticationBloc authenticationBloc;

  LoginBloc({@required this.userRepository, @required this.authenticationBloc})
      : assert(userRepository != null),
        assert(authenticationBloc != null),
        super(LoginInitial());

  
  LoginState get initialState => LoginInitial();

  @override
  Stream<LoginState> mapEventToState(LoginEvent event) async* {
    if (event is LoginButtonPressed) {
      yield LoginLoading();
      try {
        final token = await userRepository.authenticate(
            username: event.username, password: event.password);
        print(token);
        print(authenticationBloc.getMyName());
        authenticationBloc.add(LoggedIn(token: token));
        yield LoginInitial();
      } catch (exp) {
        yield LoginFailure(error: exp.toString());
      }
    }
  }
}
