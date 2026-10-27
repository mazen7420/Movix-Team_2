import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../profile/cubit/profile_cubit.dart';
import '../../profile/screens/profile_screen.dart';
import '../cubit/home_tab_cubit.dart';
import '../widgets/home_header.dart';
import '../widgets/home_tabs.dart';
import '../widgets/search_bar_field.dart';
import '../widgets/hero_section.dart';
import '../widgets/explore_vaults.dart';
import '../widgets/section_container.dart';
import 'package:movix/features/movies/cubit/counts_cubit.dart';
import 'package:movix/features/movies/data/movies_api.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const List<String> hints = [
    'Search movies, TV shows, actors...',
    'Search movies...',
    'Search TV shows...',
    'Search actors...',
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => CountsCubit()..loadCounts(),
      child: Scaffold(
        backgroundColor: const Color(0xFF0B1512),
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                BlocBuilder<ProfileCubit, String>(
                  builder: (context, imagePath) {
                    return HomeHeader(
                      imagePath: imagePath,
                      onSettingsTap: () {
                        //setting page
                      },
                      onProfileTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const ProfileScreen()),
                        );
                      },
                    );
                  },
                ),
                const SizedBox(height: 20),

                BlocBuilder<HomeTabCubit, int>(
                  builder: (context, selectedTab) {
                    final counts = context.watch<CountsCubit>().state;
                    var all = 'All';
                    var movies = 'Movies';
                    var tvShows = 'TV Shows';
                    var actors = 'Actors';
                    if (!counts.loading && counts.error == null) {
                      all = 'All (${counts.movies + counts.tvShows + counts.actors})';
                      movies = 'Movies (${counts.movies})';
                      tvShows = 'TV Shows (${counts.tvShows})';
                      actors = 'Actors (${counts.actors})';
                    }

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SearchBarField(
                          hint: hints[selectedTab],
                          onChanged: (text) {
                          },
                          onSubmitted: (text) {
                          },
                        ),
                        const SizedBox(height: 16),
                        HomeTabs(
                          tabs: [all, movies, tvShows,actors],
                          selectedIndex: selectedTab,
                          onTap: (index) {
                            context.read<HomeTabCubit>().selectTab(index);
                          },
                        ),
                      ],
                    );
                  },
                ),
                const SizedBox(height: 20),
                const HeroSection(),
                const SizedBox(height: 24),
                const ExploreVaults(),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Discover',
                  fetch: () => MoviesApi().getList('/discover/movie', 'movie'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Trending',
                  fetch: () => MoviesApi().getList('/trending/all/day', 'movie'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Top Movies',
                  fetch: () => MoviesApi().getList('/movie/top_rated', 'movie'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Top TV Shows',
                  fetch: () => MoviesApi().getList('/tv/top_rated', 'tv'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Popular Movies',
                  fetch: () => MoviesApi().getList('/movie/popular', 'movie'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Popular TV Shows',
                  fetch: () => MoviesApi().getList('/tv/popular', 'tv'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Now Playing',
                  fetch: () => MoviesApi().getList('/movie/now_playing', 'movie'),
                ),
                const SizedBox(height: 24),
                SectionContainer(
                  title: 'Upcoming',
                  fetch: () => MoviesApi().getList('/movie/upcoming', 'movie'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}