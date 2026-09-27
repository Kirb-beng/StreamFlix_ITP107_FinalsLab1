import 'package:flutter/material.dart';
import '../theme/streamflix_theme.dart';

/// Full-bleed background: an original abstract poster-grid pattern
/// (assets/images/streamflix_bg.jpg) darkened with a gradient scrim so
/// the white/navy UI stays readable on top.
class StreamflixBackground extends StatelessWidget {
  final Widget child;
  const StreamflixBackground({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset(
          'assets/images/streamflix_bg.jpg',
          fit: BoxFit.cover,
        ),
        // Dark scrim so text/inputs stay legible over the busy pattern.
        DecoratedBox(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                StreamflixColors.black.withOpacity(0.55),
                StreamflixColors.black.withOpacity(0.75),
                StreamflixColors.black.withOpacity(0.92),
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        ),
        SafeArea(
          child: child,
        ),
      ],
    );
  }
}

/// The "STREAMFLIX" wordmark: an Orbitron display face filled with a
/// magenta-to-cyan neon gradient and a soft matching glow behind it,
/// instead of the classic solid-color-with-outline streaming logo.
class StreamflixLogo extends StatelessWidget {
  final double fontSize;
  const StreamflixLogo({super.key, this.fontSize = 32});

  @override
  Widget build(BuildContext context) {
    final baseStyle = StreamflixTextStyles.logo.copyWith(fontSize: fontSize);
    return Stack(
      alignment: Alignment.center,
      children: [
        // Blurred glow copy sitting behind the crisp text.
        Text(
          'STREAMFLIX',
          style: baseStyle.copyWith(
            foreground: Paint()
              ..color = StreamflixColors.primary.withOpacity(0.65)
              ..maskFilter =
                  const MaskFilter.blur(BlurStyle.normal, 10),
          ),
        ),
        // Crisp gradient-filled wordmark on top.
        ShaderMask(
          shaderCallback: (bounds) =>
              StreamflixColors.brandGradient.createShader(bounds),
          child: Text('STREAMFLIX', style: baseStyle),
        ),
      ],
    );
  }
}

/// Simple reusable fade + rise-in animation, used to animate the
/// Login/Sign-Up form cards and the Home screen content into view.
class FadeSlideIn extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final Duration duration;
  const FadeSlideIn({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.duration = const Duration(milliseconds: 500),
  });

  @override
  State<FadeSlideIn> createState() => _FadeSlideInState();
}

class _FadeSlideInState extends State<FadeSlideIn>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _opacity;
  late final Animation<Offset> _offset;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    final curved = CurvedAnimation(parent: _controller, curve: Curves.easeOut);
    _opacity = curved;
    _offset = Tween<Offset>(
      begin: const Offset(0, 0.08),
      end: Offset.zero,
    ).animate(curved);

    Future.delayed(widget.delay, () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: _opacity,
      child: SlideTransition(position: _offset, child: widget.child),
    );
  }
}
