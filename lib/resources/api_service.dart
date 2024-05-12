import 'dart:convert';
import 'dart:developer';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:http/http.dart' as http;
import 'package:movie_app_with_bloc/models/coming_soon_model.dart';
import 'package:movie_app_with_bloc/utils/app_const.dart';

class ApiService {
  Future<List<Movie>> getComingSoonMovies(int page) async {
    log('again');
    String? apiKey = dotenv.env['API_KEY'];
    final url = Uri.parse('$baseUrl?api_key=$apiKey&page=$page');
    try {
      return http
          .get(url)
          .then((resp) => jsonDecode(resp.body))
          .then((data) => data['results'])
          .then((value) => value
              .map<Movie>((movieJson) => Movie.fromJson(movieJson))
              .toList());
    } catch (e) {
      return [];
    }
  }
}
