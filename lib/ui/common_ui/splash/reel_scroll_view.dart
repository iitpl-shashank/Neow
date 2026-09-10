import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import '../../../utils/local_images.dart';

// ──────────────────────────────────────────────────────────────────────────────
// ReelScrollView — Cinematic 3D curved film-strip horizontal reel scroll
// ──────────────────────────────────────────────────────────────────────────────

class ReelScrollView extends StatefulWidget {
  final VoidCallback onFinish;
  final VoidCallback onSkip;

  const ReelScrollView({
    super.key,
    required this.onFinish,
    required this.onSkip,
  });

  @override
  State<ReelScrollView> createState() => _ReelScrollViewState();
}

class _ReelScrollViewState extends State<ReelScrollView>
    with TickerProviderStateMixin {
  late PageController _pageController;
  int _currentIndex = 0;
  double _pageOffset = 0.0;
  Timer? _autoScrollTimer;
  Timer? _resumeTimer;
  bool _userIsSwiping = false;

  AudioPlayer? _swipeAudioPlayer;

  // Swipe-hint oscillation
  late AnimationController _hintController;
  late Animation<double> _hintAnimation;

  static const double _viewportFraction = 0.64;

  final List<String> _reelImages = [
    LocalImages.reel_1,
    LocalImages.reel_2,
    LocalImages.reel_3,
    LocalImages.reel_4,
    LocalImages.reel_5,
    LocalImages.reel_6,
    LocalImages.reel_7,
    LocalImages.reel_8,
    LocalImages.reel_9,
    LocalImages.reel_10,
  ];

  // ──────────────────────────────────────────── LIFECYCLE ───────────────────

  @override
  void initState() {
    super.initState();

    _pageController = PageController(viewportFraction: _viewportFraction);
    _pageController.addListener(() {
      if (_pageController.hasClients) {
        setState(() => _pageOffset = _pageController.page ?? 0.0);
      }
    });

    _hintController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..repeat(reverse: true);

    _hintAnimation = Tween<double>(begin: 0, end: 10).animate(
      CurvedAnimation(parent: _hintController, curve: Curves.easeInOut),
    );

    _initAudioPlayer();
    _startAutoScroll();
  }

  Future<void> _initAudioPlayer() async {
    try {
      _swipeAudioPlayer = AudioPlayer();
      await _swipeAudioPlayer?.setAsset('assets/audio/swoosh_sound.mp3');
    } catch (e) {
      debugPrint('Error loading swipe sound: $e');
    }
  }

  void _startAutoScroll() {
    _autoScrollTimer?.cancel();
    _autoScrollTimer = Timer.periodic(const Duration(seconds: 3), (_) {
      if (!_userIsSwiping && mounted && _pageController.hasClients) {
        final int next =
            _currentIndex < _reelImages.length - 1 ? _currentIndex + 1 : 0;
        _pageController.animateToPage(
          next,
          duration: const Duration(milliseconds: 600),
          curve: Curves.easeInOut,
        );
      }
    });
  }

  void _scheduleResumeAutoScroll() {
    _autoScrollTimer?.cancel();
    _resumeTimer?.cancel();
    _resumeTimer = Timer(const Duration(seconds: 1), () {
      if (mounted) _startAutoScroll();
    });
  }

  void _goToNext() {
    if (_currentIndex < _reelImages.length - 1) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 450),
        curve: Curves.easeInOut,
      );
    } else {
      widget.onFinish();
    }
  }

  void _playSwipeSound() {
    try {
      _swipeAudioPlayer?.seek(Duration.zero);
      _swipeAudioPlayer?.play();
    } catch (e) {
      debugPrint('Error playing swipe sound: $e');
    }
  }

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeTimer?.cancel();
    _hintController.dispose();
    _pageController.dispose();
    _swipeAudioPlayer?.dispose();
    super.dispose();
  }

  // ──────────────────────────────────────────────── BUILD ───────────────────

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double topPad = MediaQuery.of(context).padding.top;
    final double bottomPad = MediaQuery.of(context).padding.bottom;
    final bool isLastPage = _currentIndex == _reelImages.length - 1;

    // Film-strip geometry constants - compact vertical spacing
    const double sprocketH = 38.0;
    final double filmH = size.height * 0.63;
    final double filmTopY = topPad + 140;

    return Scaffold(
      backgroundColor: const Color(0xFFEADBFF),
      body: GestureDetector(
        onTap: _scheduleResumeAutoScroll,
        onHorizontalDragStart: (_) {
          _userIsSwiping = true;
          _scheduleResumeAutoScroll();
        },
        onHorizontalDragEnd: (_) {
          _userIsSwiping = false;
          _scheduleResumeAutoScroll();
        },
        child: Container(
          width: size.width,
          height: size.height,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Color(0xFFEADBFF),
                Color(0xFFE7DAF7),
                Color(0xFFE1D0F5),
              ],
            ),
          ),
          child: Stack(
            children: [
              // ── 1. Film strip band + PageView (Centered neatly with reduced gap) ─
              Positioned(
                top: filmTopY,
                left: 0,
                right: 0,
                height: filmH,
                child: _FilmBand(
                  sprocketH: sprocketH,
                  filmH: filmH,
                  size: size,
                  pageController: _pageController,
                  pageOffset: _pageOffset,
                  currentIndex: _currentIndex,
                  images: _reelImages,
                  onPageChanged: (i) {
                    if (_currentIndex != i) {
                      _playSwipeSound();
                      setState(() => _currentIndex = i);
                    }
                  },
                ),
              ),

              // ── 2. Top header bar (Centered larger logo & subtitle) ─────────
              _TopBar(
                topPad: topPad,
              ),

              // ── 3. Bottom controls (Tighter spacing) ────────────────────────
              _BottomControls(
                bottomPad: bottomPad,
                currentIndex: _currentIndex,
                total: _reelImages.length,
                isLastPage: isLastPage,
                hintAnimation: _hintAnimation,
                onNext: _goToNext,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// PRIVATE WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

// ── Top Bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final double topPad;

  const _TopBar({
    required this.topPad,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding: EdgeInsets.only(
          top: topPad + 4,
          left: 18,
          right: 18,
          bottom: 4,
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Prominent Logo without circle
            Image.asset(
              LocalImages.neowLogoWithoutCircle,
              height: 120,
              fit: BoxFit.contain,
            ),
            const SizedBox(height: 2),
            Row(
              mainAxisSize: MainAxisSize.min,
              children: const [
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF6B42A6),
                  size: 11,
                ),
                SizedBox(width: 5),
                Text(
                  'Your Wellness Journey begins',
                  style: TextStyle(
                    color: Color(0xFF533187),
                    fontSize: 12.5,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                    letterSpacing: 0.3,
                  ),
                ),
                SizedBox(width: 5),
                Icon(
                  Icons.auto_awesome,
                  color: Color(0xFF6B42A6),
                  size: 11,
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

// ── Film Band (strip + PageView) ──────────────────────────────────────────────

class _FilmBand extends StatelessWidget {
  final double sprocketH;
  final double filmH;
  final Size size;
  final PageController pageController;
  final double pageOffset;
  final int currentIndex;
  final List<String> images;
  final ValueChanged<int> onPageChanged;

  const _FilmBand({
    required this.sprocketH,
    required this.filmH,
    required this.size,
    required this.pageController,
    required this.pageOffset,
    required this.currentIndex,
    required this.images,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // ── PageView of cards with 3D perspective depth ───────────────────────
        Positioned.fill(
          child: Padding(
            padding: EdgeInsets.symmetric(vertical: sprocketH * 0.45),
            child: PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: onPageChanged,
              clipBehavior: Clip.none,
              itemBuilder: (context, index) {
                final double pageDiff = (pageOffset - index);
                final double absDiff = pageDiff.abs();

                // 3D Perspective parameters
                final double scale = (1.0 - absDiff * 0.08).clamp(0.86, 1.0);
                final double opacity = (1.0 - absDiff * 0.20).clamp(0.65, 1.0);
                // Subtle Y-axis rotation (turns side cards inward like a curved panorama)
                final double rotationY = (-pageDiff * 0.12).clamp(-0.25, 0.25);

                return Transform(
                  alignment: pageDiff < 0
                      ? Alignment.centerLeft
                      : Alignment.centerRight,
                  transform: Matrix4.identity()
                    ..setEntry(3, 2, 0.0014) // 3D depth perspective
                    ..rotateY(rotationY)
                    ..scaleByDouble(scale, scale, 1.0, 1.0),
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      margin: const EdgeInsets.symmetric(
                        horizontal: 8,
                        vertical: 6,
                      ),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(22),
                        boxShadow: [
                          // Multi-layered realistic 3D depth shadow
                          BoxShadow(
                            color: const Color(0xFF4E287D).withAlpha(55),
                            blurRadius: 22,
                            spreadRadius: 2,
                            offset: const Offset(0, 8),
                          ),
                          BoxShadow(
                            color: const Color(0xFF8F6ECB).withAlpha(35),
                            blurRadius: 10,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(22),
                        child: Image.asset(
                          images[index],
                          fit: BoxFit.cover,
                          width: double.infinity,
                          height: double.infinity,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ),

        // ── 3D Arched Film Strip Painted Overlay ───────────────────────
        Positioned.fill(
          child: IgnorePointer(
            child: CustomPaint(
              painter: _CurvedFilmStripPainter(
                sprocketH: sprocketH,
                totalH: filmH,
                scrollOffset: pageOffset,
                viewportFraction: 0.64,
                screenWidth: size.width,
              ),
              size: Size(size.width, filmH),
            ),
          ),
        ),
      ],
    );
  }
}

// ── Bottom Controls ───────────────────────────────────────────────────────────

class _BottomControls extends StatelessWidget {
  final double bottomPad;
  final int currentIndex;
  final int total;
  final bool isLastPage;
  final Animation<double> hintAnimation;
  final VoidCallback onNext;

  const _BottomControls({
    required this.bottomPad,
    required this.currentIndex,
    required this.total,
    required this.isLastPage,
    required this.hintAnimation,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: bottomPad + 12,
      left: 24,
      right: 24,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // ── Swipe hint ────────────────────────────────────────────────────
          AnimatedBuilder(
            animation: hintAnimation,
            builder: (_, __) => Transform.translate(
              offset: Offset(-hintAnimation.value, 0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: const [
                  Icon(
                    Icons.touch_app_rounded,
                    color: Color(0xFF4A2B6F),
                    size: 20,
                  ),
                  SizedBox(width: 7),
                  Text(
                    'Swipe to explore',
                    style: TextStyle(
                      color: Color(0xFF4A2B6F),
                      fontSize: 13,
                      fontWeight: FontWeight.w600,
                      fontFamily: 'Outfit',
                      letterSpacing: 0.3,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          // ── Dots + Next button ────────────────────────────────────────────
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Animated pill dots
              Row(
                children: List.generate(
                  total,
                  (i) => AnimatedContainer(
                    duration: const Duration(milliseconds: 280),
                    curve: Curves.easeInOut,
                    margin: const EdgeInsets.only(right: 6),
                    height: 7,
                    width: currentIndex == i ? 22 : 7,
                    decoration: BoxDecoration(
                      color: currentIndex == i
                          ? const Color(0xFF6B42A6)
                          : const Color(0xFFC7B3E5),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Next / Get Started 3D pill button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: const LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Color(0xFF7A4DBE),
                      Color(0xFF62369C),
                    ],
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: const Color(0xFF62369C).withAlpha(100),
                      blurRadius: 16,
                      offset: const Offset(0, 6),
                    ),
                    BoxShadow(
                      color: Colors.white.withAlpha(70),
                      blurRadius: 4,
                      offset: const Offset(0, -1),
                    ),
                  ],
                ),
                child: Material(
                  color: Colors.transparent,
                  child: InkWell(
                    onTap: onNext,
                    borderRadius: BorderRadius.circular(28),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 24,
                        vertical: 11,
                      ),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLastPage ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                              fontFamily: 'Outfit',
                            ),
                          ),
                          const SizedBox(width: 6),
                          Icon(
                            isLastPage
                                ? Icons.rocket_launch_rounded
                                : Icons.arrow_forward_rounded,
                            color: Colors.white,
                            size: 18,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// 3D REALISTIC CURVED FILM STRIP PAINTER
// ══════════════════════════════════════════════════════════════════════════════

class _CurvedFilmStripPainter extends CustomPainter {
  final double sprocketH;
  final double totalH;
  final double scrollOffset;
  final double viewportFraction;
  final double screenWidth;

  const _CurvedFilmStripPainter({
    required this.sprocketH,
    required this.totalH,
    required this.scrollOffset,
    required this.viewportFraction,
    required this.screenWidth,
  });

  // Sprocket geometry
  static const double _spacing = 26.0;
  static const double _holeW = 12.0;
  static const double _holeH = 14.0;
  static const double _pxPerPage = _spacing * 3;
  static const double _archDrop = 12.0; // 3D curve arch depth

  /// Calculates parabolic arch offset for a given X coordinate
  double _getArchDisplacement(double x, double width) {
    final double u = (x - width / 2) / (width / 2);
    final double c = (1.0 - u * u).clamp(0.0, 1.0);
    return _archDrop * c;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final double w = size.width;
    final double h = size.height;

    const double topMargin = 4.0;
    const double btmMargin = 4.0;

    // ── 1. Ambient Drop Shadow underneath the entire film reel ───────────
    final bottomShadowPath = Path();
    bottomShadowPath.moveTo(0, h - btmMargin - _archDrop);
    bottomShadowPath.quadraticBezierTo(
        w / 2, h - btmMargin, w, h - btmMargin - _archDrop);
    bottomShadowPath.lineTo(w, h - btmMargin - _archDrop + 6);
    bottomShadowPath.quadraticBezierTo(
        w / 2, h - btmMargin + 6, 0, h - btmMargin - _archDrop + 6);
    bottomShadowPath.close();

    final ambientShadowPaint = Paint()
      ..color = const Color(0xFF5E3992).withAlpha(45)
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 10);
    canvas.drawPath(bottomShadowPath, ambientShadowPaint);

    // ── 2. Top Arched Rail Path ──────────────────────────────────────────
    final Path topPath = Path();
    topPath.moveTo(0, topMargin + _archDrop);
    topPath.quadraticBezierTo(w / 2, topMargin, w, topMargin + _archDrop);
    topPath.lineTo(w, topMargin + _archDrop + sprocketH);
    topPath.quadraticBezierTo(
        w / 2, topMargin + sprocketH, 0, topMargin + _archDrop + sprocketH);
    topPath.close();

    // ── 3. Bottom Arched Rail Path ───────────────────────────────────────
    final Path bottomPath = Path();
    bottomPath.moveTo(0, h - btmMargin - _archDrop - sprocketH);
    bottomPath.quadraticBezierTo(w / 2, h - btmMargin - sprocketH, w,
        h - btmMargin - _archDrop - sprocketH);
    bottomPath.lineTo(w, h - btmMargin - _archDrop);
    bottomPath.quadraticBezierTo(
        w / 2, h - btmMargin, 0, h - btmMargin - _archDrop);
    bottomPath.close();

    // ── 4. 3D Gradient Shading for Rails ─────────────────────────────────
    final topGradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFFA684DF), // Top highlight
          Color(0xFF936ECF), // Mid body
          Color(0xFF875EC4), // Lower shadow crease
        ],
      ).createShader(Rect.fromLTWH(0, 0, w, sprocketH + _archDrop + topMargin))
      ..style = PaintingStyle.fill;

    final btmGradientPaint = Paint()
      ..shader = const LinearGradient(
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
        colors: [
          Color(0xFF875EC4), // Upper shadow crease
          Color(0xFF936ECF), // Mid body
          Color(0xFFA684DF), // Bottom highlight rim
        ],
      ).createShader(Rect.fromLTWH(0, h - sprocketH - _archDrop - btmMargin, w,
          sprocketH + _archDrop + btmMargin))
      ..style = PaintingStyle.fill;

    canvas.drawPath(topPath, topGradientPaint);
    canvas.drawPath(bottomPath, btmGradientPaint);

    // ── 5. 3D Edge Bevels & Highlights ───────────────────────────────────
    // Top outer highlight rim
    final topHighlightPaint = Paint()
      ..color = Colors.white.withAlpha(120)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final topHighlightPath = Path()
      ..moveTo(0, topMargin + _archDrop)
      ..quadraticBezierTo(w / 2, topMargin, w, topMargin + _archDrop);
    canvas.drawPath(topHighlightPath, topHighlightPaint);

    // Top inner crease shadow
    final topInnerShadowPaint = Paint()
      ..color = const Color(0xFF4F277D).withAlpha(110)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final topInnerPath = Path()
      ..moveTo(0, topMargin + _archDrop + sprocketH)
      ..quadraticBezierTo(
          w / 2, topMargin + sprocketH, w, topMargin + _archDrop + sprocketH);
    canvas.drawPath(topInnerPath, topInnerShadowPaint);

    // Bottom inner crease shadow
    final btmInnerShadowPaint = Paint()
      ..color = const Color(0xFF4F277D).withAlpha(110)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;
    final btmInnerPath = Path()
      ..moveTo(0, h - btmMargin - _archDrop - sprocketH)
      ..quadraticBezierTo(w / 2, h - btmMargin - sprocketH, w,
          h - btmMargin - _archDrop - sprocketH);
    canvas.drawPath(btmInnerPath, btmInnerShadowPaint);

    // Bottom outer highlight rim
    final btmHighlightPaint = Paint()
      ..color = Colors.white.withAlpha(90)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;
    final btmHighlightPath = Path()
      ..moveTo(0, h - btmMargin - _archDrop)
      ..quadraticBezierTo(w / 2, h - btmMargin, w, h - btmMargin - _archDrop);
    canvas.drawPath(btmHighlightPath, btmHighlightPaint);

    // ── 6. Realistic 3D Punched Sprocket Holes (with inner shadow & bevel) ─
    final double rawShift = (scrollOffset * _pxPerPage) % _spacing;
    final double startX = -rawShift;

    final holeBgPaint = Paint()
      ..color = const Color(0xFFEADBFF)
      ..style = PaintingStyle.fill;

    final holeTopShadowPaint = Paint()
      ..color = const Color(0xFF4C257C).withAlpha(150)
      ..strokeWidth = 1.0
      ..style = PaintingStyle.stroke;

    final holeBtmHighlightPaint = Paint()
      ..color = Colors.white.withAlpha(190)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final holeBorderPaint = Paint()
      ..color = const Color(0xFF7E5BBF).withAlpha(100)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    double x = startX;
    while (x <= w + _spacing) {
      final double arch = _getArchDisplacement(x, w);

      // ── Top rail 3D hole ──
      final double topHoleCY = topMargin + (_archDrop - arch) + (sprocketH / 2);
      final topHoleRect = Rect.fromCenter(
        center: Offset(x, topHoleCY),
        width: _holeW,
        height: _holeH,
      );
      final topHoleRRect =
          RRect.fromRectAndRadius(topHoleRect, const Radius.circular(3.5));

      // Hole background fill
      canvas.drawRRect(topHoleRRect, holeBgPaint);
      canvas.drawRRect(topHoleRRect, holeBorderPaint);

      // Top inner shadow (embossed cut)
      canvas.drawLine(
        Offset(topHoleRect.left + 2, topHoleRect.top + 0.5),
        Offset(topHoleRect.right - 2, topHoleRect.top + 0.5),
        holeTopShadowPaint,
      );
      // Bottom rim light
      canvas.drawLine(
        Offset(topHoleRect.left + 2, topHoleRect.bottom - 0.5),
        Offset(topHoleRect.right - 2, topHoleRect.bottom - 0.5),
        holeBtmHighlightPaint,
      );

      // ── Bottom rail 3D hole ──
      final double btmHoleCY =
          h - btmMargin - (_archDrop - arch) - (sprocketH / 2);
      final btmHoleRect = Rect.fromCenter(
        center: Offset(x, btmHoleCY),
        width: _holeW,
        height: _holeH,
      );
      final btmHoleRRect =
          RRect.fromRectAndRadius(btmHoleRect, const Radius.circular(3.5));

      // Hole background fill
      canvas.drawRRect(btmHoleRRect, holeBgPaint);
      canvas.drawRRect(btmHoleRRect, holeBorderPaint);

      // Top inner shadow
      canvas.drawLine(
        Offset(btmHoleRect.left + 2, btmHoleRect.top + 0.5),
        Offset(btmHoleRect.right - 2, btmHoleRect.top + 0.5),
        holeTopShadowPaint,
      );
      // Bottom rim light
      canvas.drawLine(
        Offset(btmHoleRect.left + 2, btmHoleRect.bottom - 0.5),
        Offset(btmHoleRect.right - 2, btmHoleRect.bottom - 0.5),
        holeBtmHighlightPaint,
      );

      x += _spacing;
    }

    // ── 7. 3D Rounded Vertical Frame Columns Between Cards ───────────────
    final double cardWidth = w * viewportFraction;
    final double cardSpacing = cardWidth;
    final double centerOffset = w / 2;

    for (int i = -2; i <= 12; i++) {
      final double dividerCenterX =
          centerOffset + (i - scrollOffset) * cardSpacing - cardSpacing / 2;
      if (dividerCenterX >= -40 && dividerCenterX <= w + 40) {
        final double arch = _getArchDisplacement(dividerCenterX, w);
        final double topY = topMargin + (_archDrop - arch) + sprocketH - 2;
        final double btmY = h - btmMargin - (_archDrop - arch) - sprocketH + 2;

        if (btmY > topY) {
          final dividerRect = Rect.fromCenter(
            center: Offset(dividerCenterX, (topY + btmY) / 2),
            width: 10,
            height: btmY - topY,
          );
          final dividerRRect =
              RRect.fromRectAndRadius(dividerRect, const Radius.circular(3));

          // 3D pillar gradient
          final pillarPaint = Paint()
            ..shader = const LinearGradient(
              begin: Alignment.centerLeft,
              end: Alignment.centerRight,
              colors: [
                Color(0xFFA684DF), // left highlight
                Color(0xFF936ECF), // center body
                Color(0xFF7E5BBF), // right shadow
              ],
            ).createShader(dividerRect)
            ..style = PaintingStyle.fill;

          canvas.drawRRect(dividerRRect, pillarPaint);
        }
      }
    }
  }

  @override
  bool shouldRepaint(covariant _CurvedFilmStripPainter old) =>
      old.scrollOffset != scrollOffset ||
      old.sprocketH != sprocketH ||
      old.totalH != totalH;
}
