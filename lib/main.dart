import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:movie_app_with_bloc/bloc/home_screen_bloc/home_screen_bloc.dart';
import 'package:movie_app_with_bloc/bloc/landing_screen_bloc/landing_screen_bloc.dart';
import 'package:movie_app_with_bloc/presentation/screens/landing/landing_screen.dart';
import 'package:movie_app_with_bloc/resources/api_service.dart';

void main() async {
  await dotenv.load(fileName: '.env');
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => LandingScreenBloc()),
        BlocProvider(
            create: (_) => HomeScreenBloc(apiService: ApiService())
              ..add(HomeScreenInitial()))
      ],
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Movie App',
        home: LandingScreen(),
      ),
    );
  }
}
