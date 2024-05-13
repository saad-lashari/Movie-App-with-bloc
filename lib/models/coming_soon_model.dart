import 'package:movie_app_with_bloc/utils/app_const.dart';

class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;
  final String releaseDate;
  double averageRating = 0.0; // Optional for movie ratings

  Movie({
    required this.id,
    required this.title,
    this.overview = '',
    this.posterPath = '',
    this.backdropPath = '',
    this.genreIds = const [],
    this.releaseDate = '',
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview']?.toString() ?? '',
        posterPath: json['poster_path']?.toString() ?? '',
        backdropPath: json['backdrop_path']?.toString() ?? '',
        genreIds: (json['genre_ids'] as List?)?.cast<int>() ?? const [],
        releaseDate: json['release_date']?.toString() ?? '',
      );

  String get fullPosterUrl => '$imageUrl$posterPath'; // Assuming base URL
}
