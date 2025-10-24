

import 'package:cinemapedia/domain/entities/movie.dart';

abstract class LocalStorageDataSource {
  Future<void> toggleFavorite (Movie movie);
  Future<bool> isMovieFavorite (int movieId);
  Future<List<Movie>> loadFavoritesMovies ({int limit = 10, offset = 0});


}