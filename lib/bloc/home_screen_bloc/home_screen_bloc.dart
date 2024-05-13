import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:movie_app_with_bloc/models/coming_soon_model.dart';
import 'package:movie_app_with_bloc/resources/api_service.dart';

part 'home_screen_event.dart';
part 'home_screen_state.dart';

class HomeScreenBloc extends Bloc<HomeScreenEvent, HomeScreenState> {
  final ApiService apiService;
  List<Movie> _movies = [];
  int page = 1;

  HomeScreenBloc({required this.apiService}) : super(HomeScreenState()) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is HomeScreenInitial) {
        emit(HomeScreenLoading());
        try {
          _movies = await apiService.getComingSoonMovies(page);
          if (_movies.isEmpty) {}
          emit(HomeScreenLoaded(movies: _movies));
        } catch (_) {
          emit(HomeScreenError(
              error: 'Something went wrong: Check network connection'));
        }
      } else if (event is LoadMoreMovies) {
        try {
          page++;
          final newMovies = await apiService.getComingSoonMovies(page);
          if (newMovies.isEmpty) {
            log('null');
          } else {
            for (var newMovie in newMovies) {
              bool movieExists =
                  _movies.any((movie) => movie.title == newMovie.title);
              if (!movieExists) {
                _movies.add(newMovie);
              }
            }
          }
          emit(HomeScreenLoaded(movies: _movies));
        } catch (e) {
          page--;
        }
      }
    });
  }
}
