import 'package:equatable/equatable.dart';

abstract class HomePageState extends Equatable {
  @override
  List<Object> get props => [];
}

class HomePageInitial extends HomePageState {}

class HomePageFirstButtonState extends HomePageState {}

class HomePageSecondButtonState extends HomePageState {}

class HomePageThirdButtonState extends HomePageState {}
