/// A single anime entry for a Home screen poster tile.
///
/// All titles are real, well-known anime (so the artwork/names mean
/// something), but the rating/SUB/DUB/episode/genre values here are
/// made up for demo styling — they are not pulled from any live
/// catalog or API.
class AnimeTitle {
  final String title;
  final String asset;
  final double rating;
  final bool dub;
  final String episodesLabel;
  final List<String> genres;

  const AnimeTitle({
    required this.title,
    required this.asset,
    required this.rating,
    required this.dub,
    required this.episodesLabel,
    this.genres = const [],
  });
}

/// Genre chips shown in the Home screen filter bar, in display order.
const List<String> allGenres = [
  'Action',
  'Adventure',
  'Comedy',
  'Drama',
  'Fantasy',
  'Isekai',
  'Mystery',
  'Romance',
  'Sci-Fi',
  'Slice of Life',
  'Sports',
  'Supernatural',
];

const List<AnimeTitle> trendingNow = [
  AnimeTitle(
    title: 'Attack on Titan',
    asset: 'assets/images/anime/attack_on_titan.webp',
    rating: 9.0,
    dub: true,
    episodesLabel: '25 eps',
    genres: ['Action', 'Drama', 'Fantasy'],
  ),
  AnimeTitle(
    title: 'Jujutsu Kaisen',
    asset: 'assets/images/anime/jujutsu_kaisen.webp',
    rating: 8.6,
    dub: true,
    episodesLabel: '24 eps',
    genres: ['Action', 'Supernatural'],
  ),
  AnimeTitle(
    title: 'Demon Slayer: Kimetsu no Yaiba',
    asset: 'assets/images/anime/demon_slayer.webp',
    rating: 8.5,
    dub: true,
    episodesLabel: '26 eps',
    genres: ['Action', 'Fantasy', 'Supernatural'],
  ),
  AnimeTitle(
    title: 'One Piece',
    asset: 'assets/images/anime/one_piece.webp',
    rating: 8.7,
    dub: true,
    episodesLabel: '1000+ eps',
    genres: ['Action', 'Adventure', 'Comedy'],
  ),
  AnimeTitle(
    title: 'My Hero Academia',
    asset: 'assets/images/anime/my_hero_academia.webp',
    rating: 7.9,
    dub: true,
    episodesLabel: '13 eps',
    genres: ['Action', 'Comedy'],
  ),
  AnimeTitle(
    title: 'Death Note',
    asset: 'assets/images/anime/death_note.webp',
    rating: 8.6,
    dub: true,
    episodesLabel: '37 eps',
    genres: ['Mystery', 'Supernatural', 'Drama'],
  ),
  AnimeTitle(
    title: 'Case Closed',
    asset: 'assets/images/anime/case_closed.webp',
    rating: 8.1,
    dub: false,
    episodesLabel: '1100+ eps',
    genres: ['Mystery'],
  ),
  AnimeTitle(
    title: "Steel Ball Run: JoJo's Bizarre Adventure",
    asset: 'assets/images/anime/steel_ball_run_jojo.webp',
    rating: 8.4,
    dub: false,
    episodesLabel: '12 eps',
    genres: ['Action', 'Adventure'],
  ),
];

const List<AnimeTitle> becauseYouWatched = [
  AnimeTitle(
    title: 'Steins;Gate 0',
    asset: 'assets/images/anime/steinsgate_0.webp',
    rating: 8.2,
    dub: false,
    episodesLabel: '23 eps',
    genres: ['Sci-Fi', 'Drama'],
  ),
  AnimeTitle(
    title: 'Dorohedoro Season 2',
    asset: 'assets/images/anime/dorohedoro_s2.webp',
    rating: 7.9,
    dub: false,
    episodesLabel: '12 eps',
    genres: ['Action', 'Fantasy', 'Supernatural'],
  ),
  AnimeTitle(
    title: 'Kaiju No. 8',
    asset: 'assets/images/anime/kaiju_no_8.webp',
    rating: 7.8,
    dub: false,
    episodesLabel: 'Special',
    genres: ['Action', 'Sci-Fi'],
  ),
  AnimeTitle(
    title: 'Super Dragon Ball Heroes',
    asset: 'assets/images/anime/super_dragon_ball_heroes.webp',
    rating: 6.8,
    dub: false,
    episodesLabel: '50 eps',
    genres: ['Action', 'Adventure'],
  ),
  AnimeTitle(
    title: 'Battle Through the Heavens',
    asset: 'assets/images/anime/battle_through_the_heavens.webp',
    rating: 7.0,
    dub: false,
    episodesLabel: '40 eps',
    genres: ['Action', 'Fantasy', 'Isekai'],
  ),
  AnimeTitle(
    title: 'Ascendance of a Bookworm',
    asset: 'assets/images/anime/ascendance_of_a_bookworm.webp',
    rating: 8.0,
    dub: false,
    episodesLabel: '15 eps',
    genres: ['Isekai', 'Fantasy', 'Drama'],
  ),
  AnimeTitle(
    title: 'Medalist',
    asset: 'assets/images/anime/medalist.webp',
    rating: 8.1,
    dub: false,
    episodesLabel: '24 eps',
    genres: ['Sports', 'Drama'],
  ),
];

const List<AnimeTitle> newReleases = [
  AnimeTitle(
    title: 'Kill Blue',
    asset: 'assets/images/anime/kill_blue.webp',
    rating: 6.9,
    dub: false,
    episodesLabel: '12 eps',
    genres: ['Action', 'Drama'],
  ),
  AnimeTitle(
    title: "I'm a Noble on the Brink of Ruin",
    asset: 'assets/images/anime/noble_on_the_brink_of_ruin.webp',
    rating: 6.7,
    dub: false,
    episodesLabel: '12 eps',
    genres: ['Isekai', 'Fantasy', 'Comedy'],
  ),
  AnimeTitle(
    title: 'Second Prettiest Girl in My Class',
    asset: 'assets/images/anime/second_prettiest_girl.webp',
    rating: 6.3,
    dub: false,
    episodesLabel: '12 eps',
    genres: ['Romance', 'Comedy'],
  ),
  AnimeTitle(
    title: 'I Want to End This Love Game',
    asset: 'assets/images/anime/end_this_love_game.webp',
    rating: 6.0,
    dub: false,
    episodesLabel: '12 eps',
    genres: ['Romance', 'Comedy'],
  ),
  AnimeTitle(
    title: 'Initial D Legend 3: Dream',
    asset: 'assets/images/anime/initial_d_legend_3.webp',
    rating: 7.4,
    dub: false,
    episodesLabel: 'Movie',
    genres: ['Sports', 'Drama'],
  ),
  AnimeTitle(
    title: 'Pokémon Horizons: The Series',
    asset: 'assets/images/anime/pokemon_horizons.webp',
    rating: 6.6,
    dub: true,
    episodesLabel: '40 eps',
    genres: ['Adventure', 'Comedy'],
  ),
  AnimeTitle(
    title: 'Crayon Shin-chan',
    asset: 'assets/images/anime/shin_chan.webp',
    rating: 7.5,
    dub: true,
    episodesLabel: '1000+ eps',
    genres: ['Comedy', 'Slice of Life'],
  ),
];

/// Home screen rows, in display order.
const Map<String, List<AnimeTitle>> animeByRow = {
  'Trending Now': trendingNow,
  'Because You Watched': becauseYouWatched,
  'New Releases': newReleases,
};
