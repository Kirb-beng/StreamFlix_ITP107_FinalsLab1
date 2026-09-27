import 'package:flutter/material.dart';
import '../theme/streamflix_theme.dart';
import '../data/anime_titles.dart';

/// The asymmetric "cut-corner" shape used by every poster card and its
/// rating badge — a sharp corner on top-right/bottom-left and a
/// rounder corner on top-left/bottom-right, instead of a plain
/// uniformly-rounded rectangle.
const BorderRadius _cutCornerRadius = BorderRadius.only(
  topLeft: Radius.circular(16),
  bottomRight: Radius.circular(16),
  topRight: Radius.circular(3),
  bottomLeft: Radius.circular(3),
);

/// A single anime "poster" tile: cover art, a rating tag, the title,
/// and small SUB/DUB + episode-count info. On hover (desktop/web) or
/// press (mobile) it lifts upward and gets a two-tone neon glow border
/// instead of the plain scale-up + white-outline treatment.
class PosterTile extends StatefulWidget {
  final AnimeTitle anime;
  final double width;
  final double height;

  const PosterTile({
    super.key,
    required this.anime,
    required this.width,
    required this.height,
  });

  @override
  State<PosterTile> createState() => _PosterTileState();
}

class _PosterTileState extends State<PosterTile> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    final anime = widget.anime;
    // Fixed-height info strip (title + SUB/DUB/eps row) below the
    // poster art. Using fixed pixel rows (not a height that depends on
    // font metrics) so this can never trigger a RenderFlex overflow,
    // regardless of platform/browser font rendering.
    const double infoHeight = 58;

    return MouseRegion(
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 180),
        curve: Curves.easeOut,
        // A gentle upward lift on hover/press instead of scaling the
        // whole card up — keeps the card's footprint stable while
        // still giving clear hover feedback.
        transform: Matrix4.translationValues(0, _hovering ? -8 : 0, 0),
        transformAlignment: Alignment.center,
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: _cutCornerRadius,
          border: Border.all(
            color: _hovering ? StreamflixColors.secondary : Colors.transparent,
            width: 1.4,
          ),
          // Two-tone magenta/cyan glow instead of a flat drop shadow.
          boxShadow: _hovering
              ? [
                  BoxShadow(
                    color: StreamflixColors.primary.withOpacity(0.55),
                    blurRadius: 18,
                    spreadRadius: 0.5,
                    offset: const Offset(-2, 5),
                  ),
                  BoxShadow(
                    color: StreamflixColors.secondary.withOpacity(0.4),
                    blurRadius: 18,
                    spreadRadius: 0.5,
                    offset: const Offset(2, -2),
                  ),
                ]
              : const [],
        ),
        child: ClipRRect(
          borderRadius: _cutCornerRadius,
          child: ClipRect(
            child: LayoutBuilder(
              builder: (context, constraints) {
                // constraints.maxHeight is the space actually left for
                // this content *after* the Container's border has
                // taken its cut (BoxDecoration borders add implicit
                // padding equal to the border width on each side).
                // Deriving posterHeight from this, rather than from
                // widget.height directly, keeps posterHeight +
                // infoHeight exactly equal to what's really available,
                // so the Column can never overflow.
                final posterHeight = constraints.maxHeight - infoHeight;
                return Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SizedBox(
                      height: posterHeight,
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.asset(anime.asset, fit: BoxFit.cover),
                          // Slight top scrim so the rating badge stays
                          // readable over bright poster art.
                          DecoratedBox(
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                                  Colors.black.withOpacity(0.45),
                                  Colors.transparent,
                                ],
                                stops: const [0.0, 0.35],
                              ),
                            ),
                          ),
                          Positioned(
                            left: 4,
                            top: 4,
                            child: _RatingBadge(rating: anime.rating),
                          ),
                          if (_hovering)
                            Align(
                              alignment: Alignment.center,
                              child: Icon(
                                Icons.play_circle_outline,
                                color: StreamflixColors.secondary,
                                size: 26,
                              ),
                            ),
                        ],
                      ),
                    ),
                    // Fixed-height info strip below the poster art.
                    Container(
                      height: infoHeight,
                      color: StreamflixColors.nearBlack,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 5,
                        vertical: 4,
                      ),
                      // Expanded (not a fixed SizedBox height) so each row
                      // is handed a slice of whatever space is actually
                      // left — it can shrink to fit but can never demand
                      // more than it's given, so this Column can never
                      // RenderFlex-overflow no matter how a browser/
                      // engine measures the font's true glyph metrics.
                      child: ClipRect(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Text(
                                  anime.title,
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 10.5,
                                    fontWeight: FontWeight.w600,
                                    height: 1.0,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 3),
                            Expanded(
                              child: Align(
                                alignment: Alignment.centerLeft,
                                child: Row(
                                  mainAxisSize: MainAxisSize.min,
                                  children: [
                                    const _TinyTag(
                                      label: 'SUB',
                                      color: StreamflixColors.primary,
                                    ),
                                    if (anime.dub) ...[
                                      const SizedBox(width: 3),
                                      const _TinyTag(
                                        label: 'DUB',
                                        color: StreamflixColors.secondary,
                                      ),
                                    ],
                                    const SizedBox(width: 6),
                                    Flexible(
                                      child: Text(
                                        anime.episodesLabel,
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                        style: const TextStyle(
                                          color: StreamflixColors.grey,
                                          fontSize: 8.5,
                                          height: 1.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}

/// Small dark "★ 8.6" tag, outlined in neon cyan and cut on two
/// corners to match the card shape, overlaid top-left on the poster
/// art — replacing the solid-orange rating chip look.
class _RatingBadge extends StatelessWidget {
  final double rating;
  const _RatingBadge({required this.rating});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        color: StreamflixColors.black.withOpacity(0.75),
        border: Border.all(color: StreamflixColors.secondary, width: 1),
        borderRadius: const BorderRadius.only(
          topLeft: Radius.circular(2),
          topRight: Radius.circular(8),
          bottomRight: Radius.circular(2),
          bottomLeft: Radius.circular(8),
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Icon(Icons.star, color: StreamflixColors.secondary, size: 10),
          const SizedBox(width: 2),
          Text(
            rating.toStringAsFixed(1),
            style: const TextStyle(
              color: Colors.white,
              fontSize: 9.5,
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

/// Tiny pill used for the SUB / DUB availability labels.
class _TinyTag extends StatelessWidget {
  final String label;
  final Color color;
  const _TinyTag({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 3, vertical: 1),
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(2),
      ),
      child: Text(
        label,
        style: const TextStyle(
          color: Colors.white,
          fontSize: 7,
          fontWeight: FontWeight.w700,
          letterSpacing: 0.2,
        ),
      ),
    );
  }
}
