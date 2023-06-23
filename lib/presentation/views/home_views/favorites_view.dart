import 'package:cinemapedia/presentation/providers/storage/favorites_movies_provider.dart';
import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class FavoritesView extends ConsumerStatefulWidget {
  const FavoritesView({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends ConsumerState<FavoritesView> {
  bool isLastPage = false;
  bool isLoading = false;

  @override
  void initState() {
    super.initState();
    loadNextPage();
  }

  void loadNextPage() async {
    if (isLoading || isLastPage) return;

    isLoading = true;
    final movies =
        await ref.read(favoriteMoviesProvider.notifier).loadNextPage();

    isLoading = false;

    if (movies.isEmpty) {
      isLastPage = true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final favoritesMovies = ref.watch(favoriteMoviesProvider).values.toList();

    if (favoritesMovies.isEmpty) {
      final colors = Theme.of(context).colorScheme;
      return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.favorite_outline_sharp,
              color: colors.primary,
            ),
            const SizedBox(height: 10),
            const Text('Sem filmes favoritos'),
            const SizedBox(height: 20),
            FilledButton.tonal(
                onPressed: () {
                  context.push('/home/0');
                },
                child: const Text('Voltar'))
          ],
        ),
      );
    }
    return Scaffold(
      body: MovieMasonry(
        movies: favoritesMovies,
        loadNextPage: loadNextPage,
      ),
    );
  }
}
