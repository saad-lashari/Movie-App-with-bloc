import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:movie_app_with_bloc/bloc/landing_screen_bloc/landing_screen_bloc.dart';
import 'package:movie_app_with_bloc/presentation/screens/home/home_screen.dart';
import 'package:movie_app_with_bloc/resources/api_service.dart';

final List<Widget> screens = [
  const HomeScreen(),
  const Text('Search'),
  const Text('Favorite'),
  const Text('profiel')
];
List<BottomNavigationBarItem> items = [
  const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
  const BottomNavigationBarItem(icon: Icon(Icons.search), label: 'Search'),
  const BottomNavigationBarItem(icon: Icon(Icons.favorite), label: 'Favorite'),
  const BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile')
];

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  ApiService repository = ApiService();
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<LandingScreenBloc, LandingScreenState>(
      builder: (context, state) {
        return Scaffold(
            body: Center(child: screens[state.tabIndex]),
            bottomNavigationBar: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                backgroundColor: Colors.black,
                items: items,
                onTap: (index) {
                  BlocProvider.of<LandingScreenBloc>(context)
                      .add(TabChange(tabIndex: index));
                },
                currentIndex: state.tabIndex,
                selectedItemColor: Colors.white,
                unselectedItemColor: Colors.grey,
                showUnselectedLabels: false,
              ),
            ));
      },
    );
  }
}
