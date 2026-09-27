import 'package:flutter/material.dart';
import '../theme/streamflix_theme.dart';
import '../theme/responsive.dart';
import '../widgets/streamflix_background.dart';
import '../widgets/poster_tile.dart';
import '../data/anime_titles.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // null / 'All' means no genre filter is active.
  String? _selectedGenre;

  List<AnimeTitle> _filtered(List<AnimeTitle> titles) {
    if (_selectedGenre == null || _selectedGenre == 'All') return titles;
    return titles.where((t) => t.genres.contains(_selectedGenre)).toList();
  }

  @override
  Widget build(BuildContext context) {
    // The name passed as route arguments from Login or Sign-Up.
    final args = ModalRoute.of(context)?.settings.arguments;
    final String displayName =
        (args is String && args.trim().isNotEmpty) ? args.trim() : 'there';

    final rows = <MapEntry<String, List<AnimeTitle>>>[
      for (final entry in animeByRow.entries)
        MapEntry(entry.key, _filtered(entry.value)),
    ]..removeWhere((entry) => entry.value.isEmpty);

    return Scaffold(
      backgroundColor: StreamflixColors.black,
      body: SafeArea(
        child: Column(
          children: [
            // Streamflix-style top app bar with logo + profile avatar.
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  StreamflixLogo(fontSize: Responsive.logoFontSize(context) - 6),
                  Row(
                    children: [
                      const Icon(Icons.search, color: StreamflixColors.white),
                      const SizedBox(width: 20),
                      CircleAvatar(
                        radius: 14,
                        backgroundColor: StreamflixColors.primary,
                        child: Text(
                          displayName.isNotEmpty
                              ? displayName[0].toUpperCase()
                              : '?',
                          style: const TextStyle(
                            color: StreamflixColors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Container(
              width: double.infinity,
              color: StreamflixColors.black,
              padding: const EdgeInsets.only(bottom: 12),
              child: _GenreFilterBar(
                selected: _selectedGenre,
                onSelected: (g) => setState(() => _selectedGenre = g),
              ),
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Hero banner using the real Streamflix collage image,
                    // fading straight into the page background — just
                    // like the browse screen's featured-title hero.
                    FadeSlideIn(
                      child: SizedBox(
                        height: Responsive.heroHeight(context),
                        width: double.infinity,
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.asset(
                              'assets/images/streamflix_bg.jpg',
                              fit: BoxFit.cover,
                              alignment: Alignment.topCenter,
                            ),
                            DecoratedBox(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    StreamflixColors.black.withOpacity(0.45),
                                    StreamflixColors.black.withOpacity(0.9),
                                    StreamflixColors.black,
                                  ],
                                  stops: const [0.0, 0.6, 1.0],
                                ),
                              ),
                            ),
                            Positioned(
                              left: 20,
                              right: 20,
                              bottom: 20,
                              child: ConstrainedBox(
                                constraints: const BoxConstraints(maxWidth: 560),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Welcome, $displayName!',
                                      style: StreamflixTextStyles.heading,
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      'You are now signed in.',
                                      style: StreamflixTextStyles.greyBody,
                                    ),
                                    const SizedBox(height: 14),
                                    _LogoutButton(),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    if (rows.isEmpty)
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 40,
                        ),
                        child: Text(
                          'Wala pang titles sa genre na ito.',
                          style: StreamflixTextStyles.greyBody,
                        ),
                      ),
                    for (var i = 0; i < rows.length; i++) ...[
                      FadeSlideIn(
                        delay: Duration(milliseconds: 150 * (i + 1)),
                        child: _buildRow(context, rows[i].key, rows[i].value),
                      ),
                      const SizedBox(height: 28),
                    ],
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  /// A horizontally-scrolling row of anime poster tiles (real anime
  /// artwork, titles, star ratings, and SUB/DUB + episode info).
  /// Tile size scales up on wider (desktop-size) Chrome windows.
  Widget _buildRow(
    BuildContext context,
    String rowTitle,
    List<AnimeTitle> titles,
  ) {
    final tileWidth = Responsive.posterTileWidth(context);
    final tileHeight = Responsive.posterTileHeight(context);
    // Extra vertical space reserved above every tile so the hover lift
    // (-8px translate) and its glow/shadow always render fully inside
    // the row instead of being clipped by the ListView's bounds.
    const double hoverHeadroom = 16;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Text(
            rowTitle,
            style: StreamflixTextStyles.heading.copyWith(fontSize: 16),
          ),
        ),
        const SizedBox(height: 10),
        SizedBox(
          height: tileHeight + hoverHeadroom,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            itemCount: titles.length,
            separatorBuilder: (_, __) => const SizedBox(width: 8),
            itemBuilder: (context, index) {
              // Bottom-anchored: at rest, the tile sits flush with the
              // bottom of the row; on hover it lifts up into the
              // headroom above instead of overflowing past it.
              return Align(
                alignment: Alignment.bottomCenter,
                child: PosterTile(
                  anime: titles[index],
                  width: tileWidth,
                  height: tileHeight,
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

/// Horizontally-scrolling row of genre filter chips ("All", "Action",
/// "Isekai", ...) sitting under the top app bar. Selecting one filters
/// every row below to titles tagged with that genre — a piece of
/// interaction Netflix's own browse screen doesn't offer this way.
class _GenreFilterBar extends StatelessWidget {
  final String? selected;
  final ValueChanged<String?> onSelected;

  const _GenreFilterBar({required this.selected, required this.onSelected});

  @override
  Widget build(BuildContext context) {
    final chips = ['All', ...allGenres];
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: chips.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final label = chips[index];
          final isSelected =
              selected == label || (selected == null && label == 'All');
          return _GenreChip(
            label: label,
            selected: isSelected,
            onTap: () => onSelected(label == 'All' ? null : label),
          );
        },
      ),
    );
  }
}

class _GenreChip extends StatelessWidget {
  final String label;
  final bool selected;
  final VoidCallback onTap;

  const _GenreChip({
    required this.label,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 150),
        padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 8),
        decoration: BoxDecoration(
          gradient: selected ? StreamflixColors.brandGradient : null,
          color: selected ? null : StreamflixColors.fieldGrey,
          borderRadius: const BorderRadius.only(
            topLeft: Radius.circular(14),
            bottomRight: Radius.circular(14),
            topRight: Radius.circular(3),
            bottomLeft: Radius.circular(3),
          ),
          border: selected
              ? null
              : Border.all(color: StreamflixColors.grey.withOpacity(0.3)),
        ),
        child: Text(
          label,
          style: TextStyle(
            color: selected ? Colors.white : StreamflixColors.grey,
            fontSize: 12.5,
            fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
          ),
        ),
      ),
    );
  }
}

class _LogoutButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      style: ElevatedButton.styleFrom(
        backgroundColor: StreamflixColors.primary,
        foregroundColor: StreamflixColors.white,
        minimumSize: const Size(160, 44),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        textStyle:
            const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
        elevation: 0,
      ),
      onPressed: () {
        // Navigator method: pushNamedAndRemoveUntil
        // Clears the whole stack (Home, Sign-Up, etc.) and drops the
        // user back at a fresh Login screen.
        Navigator.of(context).pushNamedAndRemoveUntil(
          '/login',
          (route) => false,
        );
      },
      icon: const Icon(Icons.logout, size: 18),
      label: const Text('Logout'),
    );
  }
}
