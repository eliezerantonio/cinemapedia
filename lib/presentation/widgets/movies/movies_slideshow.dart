import 'package:animate_do/animate_do.dart';
import 'package:card_swiper/card_swiper.dart';
import 'package:cinemapedia/domain/entities/movie_entity.dart';
import 'package:flutter/material.dart';

class MovieSlideshow extends StatelessWidget {
  const MovieSlideshow({super.key, required this.movies});
  final List<MovieEntity> movies;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    return SizedBox(
        width: double.infinity,
        height: 210,
        child: Swiper(
          itemCount: movies.length,
          autoplay: true, 
          viewportFraction: 0.8,
          pagination: SwiperPagination(
            builder: DotSwiperPaginationBuilder(
              activeColor: colors.primary,
              color: colors.secondary,
            ),
          ),
          scale: 0.9,
          itemBuilder: (context, index) => _Slide(
            movieEntity: movies[index],
          ),
        ));
  }
}

class _Slide extends StatelessWidget {
  final MovieEntity movieEntity;

  const _Slide({required this.movieEntity});

  @override
  Widget build(BuildContext context) {
    final decoration = BoxDecoration(
        borderRadius: BorderRadius.circular(20),
        boxShadow: const [
          BoxShadow(
            color: Colors.black45,
            blurRadius: 10,
            offset: Offset(0, 10),
          )
        ]);

    return Padding(
      padding: const EdgeInsets.only(bottom: 30),
      child: DecoratedBox(
        decoration: decoration,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Image.network(
            movieEntity.backdropPath,
            fit: BoxFit.cover,
            loadingBuilder: (context, child, loadingProgress) {
              if (loadingProgress != null) {
                return const DecoratedBox(
                    decoration: BoxDecoration(color: Colors.black12));
              }

              return FadeIn(child: child);
            },
          ),
        ),
      ),
    );
  }
}
