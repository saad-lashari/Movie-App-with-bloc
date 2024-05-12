part of 'home_screen_bloc.dart';

@immutable
abstract class HomeScreenEvent {}

class HomeScreenInitial extends HomeScreenEvent {}

class LoadMoreMovies extends HomeScreenEvent {}
