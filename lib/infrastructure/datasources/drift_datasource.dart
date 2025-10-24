import 'package:cinemapedia/config/database/database.dart';
import 'package:cinemapedia/domain/datasources/local_storage_datasource.dart';
import 'package:cinemapedia/domain/entities/movie.dart';
import 'package:drift/drift.dart' as drift;

class DriftDatasource extends LocalStorageDataSource {
  final AppDatabase database;

  DriftDatasource([AppDatabase? databaseToUse])
      : database = databaseToUse ?? db;

  @override
  Future<bool> isMovieFavorite(int movieId) async {
    //Contruir Query
    final query = database.select(database.favoriteMovies)
      ..where((table) => table.movieId.equals(movieId));
    //Ejecutar Query

    final favoriteMovie = await query.getSingleOrNull();

    //Retonar resultado
    return favoriteMovie != null;
  }

  @override
  Future<List<Movie>> loadFavoritesMovies({int limit = 10, offset = 0}) async {
    final query = database.select(database.favoriteMovies)
      ..limit(limit, offset: offset);

    final favoriteMoviesRows = await query.get();

    final movies = favoriteMoviesRows.map((row) => Movie(
        adult: false,
        backdropPath: row.backdropPath,
        genreIds: const [],
        id: row.movieId,
        originalLanguage: '',
        originalTitle: row.originalTitle,
        overview: '',
        popularity: 0,
        posterPath: row.posterPath,
        releaseDate: DateTime.now(),
        title: row.title,
        video: false,
        voteAverage: row.voteAverage,
        voteCount: 0)).toList();

        return movies;
  }

  @override
  Future<void> toggleFavorite(Movie movie) async {
    final isFavorite = await isMovieFavorite(movie.id);

    if (isFavorite) {
      final deleteQuery = database.delete(database.favoriteMovies)
        ..where((table) => table.movieId.equals(movie.id));
      await deleteQuery.go();
      return;
    }

    await database.into(database.favoriteMovies).insert(
        FavoriteMoviesCompanion.insert(
            movieId: movie.id,
            backdropPath: movie.backdropPath,
            originalTitle: movie.originalTitle,
            posterPath: movie.posterPath,
            title: movie.title,
            voteAverage: drift.Value(movie.voteAverage)));
  }
}
