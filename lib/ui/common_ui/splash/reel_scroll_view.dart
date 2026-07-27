import 'dart:async';

import 'package:flutter/material.dart';

import '../../../utils/common_colors.dart';
import '../../../utils/local_images.dart';

// ──────────────────────────────────────────────────────────────────────────────
// ReelScrollView — Cinematic film-strip style horizontal reel scroll
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
  // Debounce timer — restarts auto-scroll after 1 s of user inactivity
  Timer? _resumeTimer;
  bool _userIsSwiping = false;

  // Swipe-hint oscillation
  late AnimationController _hintController;
  late Animation<double> _hintAnimation;

  static const double _viewportFraction = 0.62;

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

    _startAutoScroll();
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

  /// Cancels any pending resume and schedules a fresh 1-second countdown.
  /// Call this on every user interaction (tap, drag start, drag end).
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

  @override
  void dispose() {
    _autoScrollTimer?.cancel();
    _resumeTimer?.cancel();
    _hintController.dispose();
    _pageController.dispose();
    super.dispose();
  }

  // ──────────────────────────────────────────────── BUILD ───────────────────

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double topPad = MediaQuery.of(context).padding.top;
    final double bottomPad = MediaQuery.of(context).padding.bottom;
    final bool isLastPage = _currentIndex == _reelImages.length - 1;

    // Film-strip geometry
    const double sprocketH = 30.0;
    final double filmH = size.height * 0.50;
    final double cardH = filmH - sprocketH * 2;
    final double filmTopY = (size.height - filmH) / 2 - 20;

    return Scaffold(
      backgroundColor: Colors.white,
      body: GestureDetector(
        // Any tap immediately stops auto-scroll and starts the 1-s countdown.
        onTap: _scheduleResumeAutoScroll,
        onHorizontalDragStart: (_) {
          _userIsSwiping = true;
          _scheduleResumeAutoScroll();
        },
        onHorizontalDragEnd: (_) {
          _userIsSwiping = false;
          // Restart the 1-s countdown after the swipe ends.
          _scheduleResumeAutoScroll();
        },
        child: Stack(
          children: [
            // ── 1. Deep-space background ────────────────────────────────────
            _Background(size: size),

            // ── 2. Bottom center radial glow ─────────────────────────────────
            _BottomGlow(size: size),

            // ── 3. Film strip band + PageView ────────────────────────────────
            Positioned(
              top: filmTopY,
              left: 0,
              right: 0,
              height: filmH,
              child: _FilmBand(
                sprocketH: sprocketH,
                filmH: filmH,
                cardH: cardH,
                size: size,
                pageController: _pageController,
                pageOffset: _pageOffset,
                currentIndex: _currentIndex,
                images: _reelImages,
                onPageChanged: (i) => setState(() => _currentIndex = i),
              ),
            ),

            // // ── 4. Left / right darkness fade ────────────────────────────────
            // _EdgeFade(
            //     top: filmTopY, height: filmH, isLeft: true, width: size.width * 0.2),
            // _EdgeFade(
            //     top: filmTopY, height: filmH, isLeft: false, width: size.width * 0.2),

            // ── 5. Top header bar ─────────────────────────────────────────────
            _TopBar(topPad: topPad, onSkip: widget.onSkip),

            // ── 6. Bottom controls ────────────────────────────────────────────
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
    );
  }
}

// ══════════════════════════════════════════════════════════════════════════════
// PRIVATE WIDGETS
// ══════════════════════════════════════════════════════════════════════════════

// ── Background ────────────────────────────────────────────────────────────────

class _Background extends StatelessWidget {
  final Size size;
  const _Background({required this.size});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: size.width,
      height: size.height,
      decoration: const BoxDecoration(
        color: Colors.white,
      ),
    );
  }
}

// ── Bottom Glow ───────────────────────────────────────────────────────────────

class _BottomGlow extends StatelessWidget {
  final Size size;
  const _BottomGlow({required this.size});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: 0,
      left: 0,
      right: 0,
      child: Container(
        height: size.height * 0.38,
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0, 1.0),
            radius: 0.75,
            colors: [
              CommonColors.primaryColor.withAlpha(31),
              Colors.transparent,
            ],
          ),
        ),
      ),
    );
  }
}

// ── Film Band (strip + PageView) ──────────────────────────────────────────────

class _FilmBand extends StatelessWidget {
  final double sprocketH;
  final double filmH;
  final double cardH;
  final Size size;
  final PageController pageController;
  final double pageOffset;
  final int currentIndex;
  final List<String> images;
  final ValueChanged<int> onPageChanged;

  const _FilmBand({
    required this.sprocketH,
    required this.filmH,
    required this.cardH,
    required this.size,
    required this.pageController,
    required this.pageOffset,
    required this.currentIndex,
    required this.images,
    required this.onPageChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.0007) // perspective depth
        ..rotateX(-0.05), // very slight forward lean
      child: Stack(
        children: [
          // Film strip background + sprocket holes (scrolls with pageOffset)
          CustomPaint(
            painter: _FilmStripPainter(
              sprocketH: sprocketH,
              totalH: filmH,
              scrollOffset: pageOffset,
            ),
            size: Size(size.width, filmH),
          ),

          // PageView of images inside the center strip
          Positioned(
            top: sprocketH,
            left: 0,
            right: 0,
            height: cardH,
            child: PageView.builder(
              controller: pageController,
              itemCount: images.length,
              onPageChanged: onPageChanged,
              itemBuilder: (context, index) {
                final double delta = (pageOffset - index).abs();
                final double scale = (1.0 - delta * 0.14).clamp(0.77, 1.0);
                final double opacity = (1.0 - delta * 0.35).clamp(0.40, 1.0);
                final bool isActive = index == currentIndex;

                return AnimatedScale(
                  scale: scale,
                  duration: const Duration(milliseconds: 250),
                  curve: Curves.easeOut,
                  child: Opacity(
                    opacity: opacity,
                    child: Container(
                      margin: const EdgeInsets.symmetric(horizontal: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: isActive
                            ? Border.all(
                                color: CommonColors.primaryColor, width: 2.5)
                            : Border.all(
                                color: CommonColors.primaryColor.withAlpha(31),
                                width: 1),
                        boxShadow: isActive
                            ? [
                                BoxShadow(
                                  color:
                                      CommonColors.primaryColor.withAlpha(153),
                                  blurRadius: 22,
                                  spreadRadius: 1,
                                ),
                                BoxShadow(
                                  color: const Color(0xFFBD5E9E).withAlpha(71),
                                  blurRadius: 34,
                                  spreadRadius: 5,
                                ),
                              ]
                            : const [],
                      ),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(6),
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
        ],
      ),
    );
  }
}

// ── Edge Fade ─────────────────────────────────────────────────────────────────

class _EdgeFade extends StatelessWidget {
  final double top;
  final double height;
  final bool isLeft;
  final double width;

  const _EdgeFade({
    required this.top,
    required this.height,
    required this.isLeft,
    required this.width,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: top,
      left: isLeft ? 0 : null,
      right: isLeft ? null : 0,
      width: width,
      height: height,
      child: IgnorePointer(
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: isLeft ? Alignment.centerLeft : Alignment.centerRight,
              end: isLeft ? Alignment.centerRight : Alignment.centerLeft,
              colors: [
                Colors.white.withAlpha(235),
                Colors.transparent,
              ],
            ),
          ),
        ),
      ),
    );
  }
}

// ── Top Bar ───────────────────────────────────────────────────────────────────

class _TopBar extends StatelessWidget {
  final double topPad;
  final VoidCallback onSkip;

  const _TopBar({required this.topPad, required this.onSkip});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      top: 0,
      left: 0,
      right: 0,
      child: Container(
        padding:
            EdgeInsets.only(top: topPad + 6, left: 20, right: 20, bottom: 14),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Spacer to balance layout
            const SizedBox(width: 64),

            // Center brand title
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  'NeoW',
                  style: TextStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 22,
                    fontWeight: FontWeight.w900,
                    fontFamily: 'Outfit',
                    letterSpacing: 3,
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.star_rounded,
                        color: CommonColors.primaryColor, size: 9),
                    const SizedBox(width: 5),
                    Text(
                      'Your Wellness Journey',
                      style: TextStyle(
                        color: CommonColors.primaryColor.withAlpha(179),
                        fontSize: 10.5,
                        fontFamily: 'Outfit',
                        letterSpacing: 0.8,
                      ),
                    ),
                    const SizedBox(width: 5),
                    Icon(Icons.star_rounded,
                        color: CommonColors.primaryColor, size: 9),
                  ],
                ),
              ],
            ),

            // Skip button (Commented out)
            const SizedBox(width: 64),
            /*
            GestureDetector(
              onTap: onSkip,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
                decoration: BoxDecoration(
                  color: CommonColors.primaryColor.withAlpha(20),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: CommonColors.primaryColor.withAlpha(64), width: 1),
                ),
                child: Text(
                  'Skip',
                  style: TextStyle(
                    color: CommonColors.primaryColor,
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    fontFamily: 'Outfit',
                  ),
                ),
              ),
            ),
            */
          ],
        ),
      ),
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
      bottom: bottomPad + 18,
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
                children: [
                  Icon(Icons.touch_app_rounded,
                      color: CommonColors.blackColor.withAlpha(128), size: 19),
                  const SizedBox(width: 7),
                  Text(
                    'Swipe to explore',
                    style: TextStyle(
                      color: CommonColors.blackColor.withAlpha(128),
                      fontSize: 12.5,
                      fontFamily: 'Outfit',
                      letterSpacing: 0.5,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 14),

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
                    margin: const EdgeInsets.only(right: 5),
                    height: 7,
                    width: currentIndex == i ? 20 : 7,
                    decoration: BoxDecoration(
                      color: currentIndex == i
                          ? CommonColors.primaryColor
                          : CommonColors.primaryColor.withAlpha(51),
                      borderRadius: BorderRadius.circular(4),
                    ),
                  ),
                ),
              ),

              // Next / Get Started gradient button
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(28),
                  gradient: LinearGradient(
                    colors: isLastPage
                        ? [const Color(0xFF7B3FA8), const Color(0xFFBD5E9E)]
                        : [CommonColors.primaryColor, const Color(0xFF9B5FCA)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: CommonColors.primaryColor.withAlpha(128),
                      blurRadius: 14,
                      offset: const Offset(0, 4),
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
                          horizontal: 22, vertical: 12),
                      child: Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            isLastPage ? 'Get Started' : 'Next',
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
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
                            size: 17,
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
// FILM STRIP PAINTER — draws top & bottom sprocket strips with holes + numbers
// ══════════════════════════════════════════════════════════════════════════════

class _FilmStripPainter extends CustomPainter {
  final double sprocketH;
  final double totalH;

  /// Current page position from PageController (e.g. 0.0, 1.5, 2.73)
  final double scrollOffset;

  const _FilmStripPainter({
    required this.sprocketH,
    required this.totalH,
    required this.scrollOffset,
  });

  // Sprocket geometry constants
  static const double _spacing = 26.0; // gap between hole centres
  static const double _holeW = 13.0;
  static const double _holeH = 17.0;
  // How many pixels the strip moves per full page scroll.
  // 3 × spacing means the strip shifts 3 hole-widths per swipe.
  static const double _pxPerPage = _spacing * 3;

  @override
  void paint(Canvas canvas, Size size) {
    // ── Clip to bounds so holes outside the strip are not visible ─────────
    canvas.save();
    canvas.clipRect(Rect.fromLTWH(0, 0, size.width, size.height));

    // ── Strip backgrounds ─────────────────────────────────────────────────
    final stripPaint = Paint()
      ..color = const Color(0xFFF3EBF9)
      ..style = PaintingStyle.fill;

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, sprocketH), stripPaint);
    canvas.drawRect(
      Rect.fromLTWH(0, size.height - sprocketH, size.width, sprocketH),
      stripPaint,
    );

    // ── Separator lines (strip ↔ card area) ──────────────────────────────
    final edgePaint = Paint()
      ..color = CommonColors.primaryColor.withAlpha(77)
      ..strokeWidth = 1.2
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
        Offset(0, sprocketH), Offset(size.width, sprocketH), edgePaint);
    canvas.drawLine(Offset(0, size.height - sprocketH),
        Offset(size.width, size.height - sprocketH), edgePaint);

    // ── Compute horizontal shift (loops every _spacing px) ───────────────
    // As scrollOffset grows (user swipes left) the strip pulls left → shift < 0.
    final double rawShift = (scrollOffset * _pxPerPage) % _spacing;
    // Start drawing just before the left edge so no gap appears
    final double startX = -rawShift;

    final holePaint = Paint()
      ..color = const Color(0xFFE8DBF2)
      ..style = PaintingStyle.fill;

    final holeBorderPaint = Paint()
      ..color = const Color(0xFFD0B3E8)
      ..strokeWidth = 0.8
      ..style = PaintingStyle.stroke;

    final double topCY = sprocketH / 2;
    final double btmCY = size.height - sprocketH / 2;

    // ── Sprocket holes (scrolling) ────────────────────────────────────────
    double x = startX;
    while (x <= size.width + _spacing) {
      for (final double cy in [topCY, btmCY]) {
        final hole = RRect.fromRectAndRadius(
          Rect.fromCenter(center: Offset(x, cy), width: _holeW, height: _holeH),
          const Radius.circular(2.5),
        );
        canvas.drawRRect(hole, holePaint);
        canvas.drawRRect(hole, holeBorderPaint);
      }
      x += _spacing;
    }

    // ── Film frame labels (scrolling, one label per 2 holes) ─────────────
    _drawFrameLabels(canvas, size, rawShift);

    canvas.restore();
  }

  void _drawFrameLabels(Canvas canvas, Size size, double rawShift) {
    // Labels repeat every labelSpacing pixels
    const double labelSpacing = _spacing * 2; // one label every 2 holes
    final double labelShift = (scrollOffset * _pxPerPage) % labelSpacing;
    final labels = ['11A ▶', '12'];
    final labelStyle = TextStyle(
      color: CommonColors.primaryColor,
      fontSize: 6.5,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.2,
    );

    double x = -labelShift;
    int idx = 0;
    while (x <= size.width + labelSpacing) {
      final tp = TextPainter(
        text: TextSpan(text: labels[idx % labels.length], style: labelStyle),
        textDirection: TextDirection.ltr,
      )..layout();

      // Top strip — just below the top edge
      tp.paint(canvas, Offset(x + 2, 1.5));
      // Bottom strip — just below the bottom separator
      tp.paint(canvas, Offset(x + 2, size.height - sprocketH + 1.5));

      x += labelSpacing;
      idx++;
    }
  }

  @override
  bool shouldRepaint(covariant _FilmStripPainter old) =>
      old.scrollOffset != scrollOffset ||
      old.sprocketH != sprocketH ||
      old.totalH != totalH;
}
