import 'package:flutter_dotenv/flutter_dotenv.dart';

class Environment {
  static String theMovieDbKey = dotenv.env['THE_MOVIE_KEY'] ?? 'no key';
}
