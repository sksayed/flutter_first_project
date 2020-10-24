import 'package:bloc/bloc.dart';
import 'package:ui_practice/homepage/home_page_state.dart';
import 'package:ui_practice/homepage/nav_drawer_button_event.dart';

class HomePageBloc extends Bloc<NavDrawerButtonEvent, HomePageState> {
  HomePageBloc() : super(HomePageInitial());

  @override
  // TODO: implement initialState
  HomePageState get initialState => HomePageInitial();

  @override
  Stream<HomePageState> mapEventToState(NavDrawerButtonEvent event) async* {}
}
