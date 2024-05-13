part of 'home_screen_bloc.dart';

@immutable
class HomeScreenState {}

class HomeScreenLoading extends HomeScreenState {}

class HomeScreenLoaded extends HomeScreenState {
  final List<Movie> movies;

  HomeScreenLoaded({required this.movies});
}

class HomeScreenError extends HomeScreenState {
  final String error;

  HomeScreenError({required this.error});
}

class HomeScreenMessage extends HomeScreenState {
  final String message;

  HomeScreenMessage({required this.message});
}
