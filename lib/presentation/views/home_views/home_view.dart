import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '/presentation/providers/providers.dart';
import '/presentation/widgets/widgets.dart';

class HomeView extends ConsumerStatefulWidget {
  const HomeView({super.key});

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends ConsumerState<HomeView> {
  @override
  void initState() {
    super.initState();

    ref.read(nowPlayingMoviesProvider.notifier).loadNextPage();

    ref.read(popularMoviesProvider.notifier).loadNextPage();

    ref.read(upcomingMoviesProvider.notifier).loadNextPage();

    ref.read(topRatedMoviesProvider.notifier).loadNextPage();
  }

  @override
  Widget build(BuildContext context) {
    final initialLoading = ref.watch(initialLoadingPorvider);

    if (initialLoading) return const FullScreenLoader();

    final slideShowMovies = ref.watch(moviesSlideshowProviver);
    final nowPlayingMovies = ref.watch(nowPlayingMoviesProvider);
    final popularMovies = ref.watch(popularMoviesProvider);
    final upcomingMovies = ref.watch(upcomingMoviesProvider);
    final topRatedMovies = ref.watch(topRatedMoviesProvider);

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
                    movies: upcomingMovies,
                    title: 'próximos',
                    subTitle: '20',
                    loadNextPage:
                        ref.read(upcomingMoviesProvider.notifier).loadNextPage,
                  ),

                  const SizedBox(height: 10),

                  //* topRatedMovies

                  MovieHorizontalListView(
                    movies: topRatedMovies,
                    title: 'Mais votado',
                    subTitle: '20',
                    loadNextPage:
                        ref.read(topRatedMoviesProvider.notifier).loadNextPage,
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
