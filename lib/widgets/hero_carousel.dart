import 'dart:async';
import 'package:flutter/material.dart';

class HeroCarousel extends StatefulWidget {
  final String imageUrl;
  const HeroCarousel({super.key, required this.imageUrl});

  @override
  State<HeroCarousel> createState() => _HeroCarouselState();
}

class _HeroCarouselState extends State<HeroCarousel> {
  final PageController _controller = PageController();
  int _index = 0;
  bool _paused = false;
  Timer? _autoTimer;
  Timer? _idleResumeTimer;

  final List<_SlideData> _slides = [];

  @override
  void initState() {
    super.initState();
    _slides.addAll([
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'Essential Range - over 20% off!',
        body: 'Over 20% off our Essential Range. Come and grab yours while stock lasts.',
        ctaLabel: 'BROWSE COLLECTION',
        onTapRoute: '/shop',
      ),
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'The Print Shack',
        body: 'Let\'s create something uniquely you with our personalization service - from £3 for one line of text.',
        ctaLabel: 'FIND OUT MORE',
        onTapRoute: '/print-shack',
      ),
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'Hungry?',
        body: 'We got this 🍕',
        ctaLabel: 'ORDER DOMINO\'S PIZZA NOW',
        onTapRoute: '/hungry',
      ),
      _SlideData(
        imageUrl: widget.imageUrl,
        title: 'What\'s your next move...',
        body: 'Are you with us?',
        ctaLabel: 'FIND YOUR STUDENT ACCOMMODATION',
        onTapRoute: '/accommodation',
      ),
    ]);

    _controller.addListener(() {
      final newIndex = _controller.page?.round() ?? 0;
      if (newIndex != _index) setState(() => _index = newIndex);
    });
    _startAutoPlay();
  }

  void _startAutoPlay() {
    _autoTimer?.cancel();
    _autoTimer = Timer.periodic(const Duration(seconds: 5), (_) {
      if (!_paused && mounted) _next();
    });
  }

  void _togglePause() {
    setState(() => _paused = !_paused);
    if (!_paused) _restartAutoAfterIdle();
  }

  void _pauseForUser() {
    if (_paused) return;
    setState(() => _paused = true);
    _idleResumeTimer?.cancel();
  }

  void _restartAutoAfterIdle() {
    _idleResumeTimer?.cancel();
    _idleResumeTimer = Timer(const Duration(seconds: 6), () {
      if (mounted) setState(() => _paused = false);
    });
  }

  @override
  void dispose() {
    _autoTimer?.cancel();
    _idleResumeTimer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _prev() {
    _pauseForUser();
    final target = (_index - 1).clamp(0, _slides.length - 1);
    _controller.animateToPage(target, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    _restartAutoAfterIdle();
  }

  void _next() {
    _pauseForUser();
    final target = (_index + 1) % _slides.length;
    _controller.animateToPage(target, duration: const Duration(milliseconds: 250), curve: Curves.easeOut);
    _restartAutoAfterIdle();
  }

  void _jumpTo(int i) {
    _pauseForUser();
    _controller.animateToPage(i, duration: const Duration(milliseconds: 200), curve: Curves.easeOut);
    _restartAutoAfterIdle();
  }

  @override
  Widget build(BuildContext context) {
    final w = MediaQuery.of(context).size.width;
    final height = w < 600 ? 300.0 : 340.0;

    return SizedBox(
      height: height,
      width: double.infinity,
      child: NotificationListener<ScrollNotification>(
        onNotification: (notification) {
          if (notification is ScrollUpdateNotification) {
            _pauseForUser();
          } else if (notification is ScrollEndNotification) {
            _restartAutoAfterIdle();
          }
          return false;
        },
        child: Stack(
          children: [
            PageView.builder(
              controller: _controller,
              itemCount: _slides.length,
              itemBuilder: (context, i) => _HeroSlide(data: _slides[i]),
            ),
            Positioned(
              left: 0,
              right: 0,
              bottom: 10,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
                  decoration: BoxDecoration(
                    color: Colors.black.withOpacity(0.35),
                    borderRadius: BorderRadius.circular(16),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _prev,
                        icon: const Icon(Icons.chevron_left, color: Colors.white, size: 20),
                        tooltip: 'Previous',
                      ),
                      const SizedBox(width: 6),
                      Row(
                        mainAxisSize: MainAxisSize.min,
                        children: List.generate(_slides.length, (i) {
                          final active = i == _index;
                          return GestureDetector(
                            onTap: () => _jumpTo(i),
                            child: Container(
                              width: active ? 10 : 8,
                              height: active ? 10 : 8,
                              margin: const EdgeInsets.symmetric(horizontal: 3),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: active ? Colors.white : Colors.white.withOpacity(0.6),
                              ),
                            ),
                          );
                        }),
                      ),
                      const SizedBox(width: 6),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _next,
                        icon: const Icon(Icons.chevron_right, color: Colors.white, size: 20),
                        tooltip: 'Next',
                      ),
                      const SizedBox(width: 8),
                      IconButton(
                        padding: EdgeInsets.zero,
                        constraints: const BoxConstraints(),
                        onPressed: _togglePause,
                        icon: Icon(_paused ? Icons.play_arrow : Icons.pause, color: Colors.white, size: 20),
                        tooltip: _paused ? 'Resume' : 'Pause',
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _HeroSlide extends StatelessWidget {
  final _SlideData data;
  const _HeroSlide({required this.data});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Positioned.fill(
          child: Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                image: NetworkImage(data.imageUrl),
                fit: BoxFit.cover,
              ),
            ),
            child: Container(color: Colors.black.withOpacity(0.65)),
          ),
        ),
        Positioned(
          left: 24,
          right: 24,
          top: 60,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                data.title,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 28, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 12),
              Text(
                data.body,
                textAlign: TextAlign.center,
                style: const TextStyle(fontSize: 17, color: Colors.white),
              ),
              const SizedBox(height: 22),
              ElevatedButton(
                onPressed: () => Navigator.pushReplacementNamed(context, data.onTapRoute),
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFF4d2963),
                  foregroundColor: Colors.white,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
                  padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
                ),
                child: Text(data.ctaLabel, style: const TextStyle(fontSize: 13, letterSpacing: 0.6)),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _SlideData {
  final String imageUrl;
  final String title;
  final String body;
  final String ctaLabel;
  final String onTapRoute;

  const _SlideData({
    required this.imageUrl,
    required this.title,
    required this.body,
    required this.ctaLabel,
    required this.onTapRoute,
  });
}