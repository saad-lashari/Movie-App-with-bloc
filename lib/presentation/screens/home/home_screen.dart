import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_bloc/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:movie_app_with_bloc/bloc/landing_screen_bloc/landing_screen_bloc.dart';
import 'package:movie_app_with_bloc/presentation/screens/home/main_widget_card.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Watch'),
        actions: [
          IconButton(
            onPressed: () async {
              BlocProvider.of<LandingScreenBloc>(context)
                  .add(TabChange(tabIndex: 1));
            },
            icon: const Icon(Icons.search),
          )
        ],
      ),
      body: BlocConsumer<HomeScreenBloc, HomeScreenState>(
        listener: (context, state) {
          if (state is HomeScreenError) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(
                content: Text(state.error),
              ),
            );
          }
        },
        builder: (context, state) {
          if (state is HomeScreenLoading) {
            return const Center(child: CircularProgressIndicator());
          } else if (state is HomeScreenError) {
            return Center(child: Text(state.error));
          } else if (state is HomeScreenLoaded) {
            return NotificationListener<ScrollNotification>(
              onNotification: (ScrollNotification scrollInfo) {
                if (scrollInfo.metrics.maxScrollExtent ==
                        scrollInfo.metrics.pixels &&
                    !context.read<HomeScreenBloc>().isLoading &&
                    !context.read<HomeScreenBloc>().hasReachedEnd) {
                  context.read<HomeScreenBloc>().add(LoadMoreMovies());
                  return true;
                }
                return false;
              },
              child: ListView.separated(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemCount: state.movies.length + 1,
                itemBuilder: (context, index) {
                  if (index < state.movies.length) {
                    return MainMovieCard(
                      movie: state.movies[index],
                    );
                  } else {
                    return _buildLoader(context);
                  }
                },
              ),
            );
          } else {
            return const Center(child: Text('Failed to load movies'));
          }
        },
      ),
    );
  }

  Widget _buildLoader(BuildContext context) {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
