import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_bloc/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:movie_app_with_bloc/bloc/landing_screen_bloc/landing_screen_bloc.dart';
import 'package:movie_app_with_bloc/presentation/screens/home/main_widget_card.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_scrollListener);
  }

  void _scrollListener() {
    if (_scrollController.position.maxScrollExtent ==
        _scrollController.position.pixels) {
      BlocProvider.of<HomeScreenBloc>(context).add(LoadMoreMovies());
      log('Reached end of list');
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    log('message');
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
            return ListView.separated(
              controller: _scrollController,
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
                  return _buildLoader();
                }
              },
            );
          } else {
            return const Center(child: Text('Failed to load movies'));
          }
        },
      ),
    );
  }

  Widget _buildLoader() {
    return const Padding(
      padding: EdgeInsets.all(8.0),
      child: Center(
        child: CircularProgressIndicator(),
      ),
    );
  }
}
