import 'package:dio/dio.dart';
import 'package:movix/core/api_config.dart';
import 'movie_details.dart';
import 'package:movix/features/movies/data/media_item.dart';

class MoviesApi {
  final dio = Dio(
    BaseOptions(
      baseUrl: ApiConfig.baseUrl,
      headers: {'Authorization': 'Bearer ${ApiConfig.token}'},
    ),
  );
  static Map<int, String> genres = {};

  Future<void> loadGenres() async {
    if (genres.isNotEmpty) return;
    for (final type in ['movie', 'tv']) {
      final response = await dio.get('/genre/$type/list');
      for (final genre in response.data['genres']) {
        genres[genre['id']] = genre['name'];
      }
    }
  }

  Future<Movie> getMovie(int id) async {
    final response = await dio.get(
      '/movie/$id',
      queryParameters: {'append_to_response': 'videos'},
    );
    return Movie.fromJson(response.data);
  }

  Future<Movie> findMovie(String name, String year) async {
    final response = await dio.get(
      '/search/movie',
      queryParameters: {'query': name, 'year': year},
    );
    final results = response.data['results'] as List;
    final id = results.first['id'];
    return getMovie(id);
  }

  Future<List<MediaItem>> getList(String path, String type) async {
    await loadGenres();
    final response = await dio.get(path);
    final results = response.data['results'] as List;
    return results.map((item) => MediaItem.fromJson(item, type)).toList();
  }

  Future<int> getCount(String path) async {
    final response = await dio.get(path);
    return response.data['total_results'];
  }
}