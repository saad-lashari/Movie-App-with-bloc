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
  bool isLoading = false;
  bool hasReachedEnd = false;

  HomeScreenBloc({required this.apiService}) : super(HomeScreenState()) {
    on<HomeScreenEvent>((event, emit) async {
      if (event is HomeScreenInitial) {
        emit(HomeScreenLoading());
        try {
          _movies = await apiService.getComingSoonMovies(page);
          if (_movies.isEmpty) {
            hasReachedEnd = true;
          }
          emit(HomeScreenLoaded(movies: _movies));
        } catch (_) {
          emit(HomeScreenError(
              error: 'Something went wrong: Check network connection'));
        }
      } else if (event is LoadMoreMovies && !isLoading && !hasReachedEnd) {
        isLoading = true;
        try {
          page++;
          final newMovies = await apiService.getComingSoonMovies(page);
          if (newMovies.isEmpty) {
            hasReachedEnd = true;
          } else {
            _movies.addAll(newMovies);
          }
          emit(HomeScreenLoaded(movies: _movies));
        } catch (_) {
          page--; // Revert page number on error
          emit(HomeScreenError(
              error:
                  'Failed to load more movies. Check your network connection.'));
        }
        isLoading = false;
      }
    });
  }
}
