import 'package:cinemapedia/presentation/widgets/widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../providers/providers.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const name = 'home-screen';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: _HomeView(),
      bottomNavigationBar: CustomBottomNavigation(),
    );
  }
}

class _HomeView extends ConsumerStatefulWidget {
  const _HomeView();

  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends ConsumerState<_HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

    ref.read(popularMoviesProvider.notifier).loadNextPage();

    ref.read(upcomingMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final slideShowMovies = ref.watch(moviesSlideshowProviver);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);

    return CustomScrollView(
      slivers: [
        const SliverAppBar(
          floating: true,
          flexibleSpace: CustomAppbar(),
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            childCount: 1,
            (context, index) {
              return Column(
                children: [
                  MovieSlideshow(movies: slideShowMovies),
                  const SizedBox(height: 10),

                  //*em cinema

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'Em cinema',
                    subTitle: '20',
                    loadNextPage: ref
                        .read(nowPlayingMoviesProvider.notifier)
                        .loadNextPage,
                  ),

                  //*populares

                  MovieHorizontalListView(
                    movies: popularMovies,
                    title: 'Populares',
                    subTitle: '20',
                    loadNextPage:
                        ref.read(popularMoviesProvider.notifier).loadNextPage,
                  ),
                  const SizedBox(height: 10),

                  //*upcomingMovies

                  MovieHorizontalListView(
                    movies: nowPlayingMovies,
                    title: 'próximos',
                    subTitle: '20',
                    loadNextPage:
                        ref.read(upcomingMoviesProvider.notifier).loadNextPage,
                  ),
                  const SizedBox(height: 10),
                ],
              );
            },
          ),
        )
      ],
    );
  }
}
