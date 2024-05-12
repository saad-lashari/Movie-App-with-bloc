class Movie {
  final int id;
  final String title;
  final String overview;
  final String posterPath;
  final String backdropPath;
  final List<int> genreIds;
  final String releaseDate;

  Movie({
    required this.id,
    required this.title,
    required this.overview,
    required this.posterPath,
    required this.backdropPath,
    required this.genreIds,
    required this.releaseDate,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
        id: json['id'] as int,
        title: json['title'] as String,
        overview: json['overview'] as String,
        posterPath: json['poster_path'] as String,
        backdropPath: json['backdrop_path'] as String,
        genreIds: (json['genre_ids'] as List).cast<int>(),
        releaseDate: json['release_date'] as String,
      );
}
