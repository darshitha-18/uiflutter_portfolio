import 'dart:async';
import 'dart:math' as math;
import 'package:flutter/material.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class HeroSection extends StatefulWidget {
  final VoidCallback onViewWork;
  final VoidCallback onContact;

  const HeroSection({
    super.key,
    required this.onViewWork,
    required this.onContact,
  });

  @override
  State<HeroSection> createState() => _HeroSectionState();
}

class _HeroSectionState extends State<HeroSection>
    with TickerProviderStateMixin {
  late final AnimationController _blobController;
  late final AnimationController _entrance;
  Timer? _rotatorTimer;
  int _roleIndex = 0;

  @override
  void initState() {
    super.initState();
    _blobController =
        AnimationController(vsync: this, duration: const Duration(seconds: 14))
          ..repeat();
    _entrance = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();
    _rotatorTimer = Timer.periodic(const Duration(milliseconds: 2600), (_) {
      if (!mounted) return;
      setState(() {
        _roleIndex = (_roleIndex + 1) % PortfolioData.roleRotator.length;
      });
    });
  }

  @override
  void dispose() {
    _blobController.dispose();
    _entrance.dispose();
    _rotatorTimer?.cancel();
    super.dispose();
  }

  Animation<double> _stagger(double start, double end) {
    return CurvedAnimation(
      parent: _entrance,
      curve: Interval(start, end, curve: Curves.easeOutCubic),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);
    final padH = Responsive.horizontalPadding(context);

    return SizedBox(
      height: MediaQuery.of(context).size.height,
      width: double.infinity,
      child: Stack(
        fit: StackFit.expand,
        children: [
          AnimatedBuilder(
            animation: _blobController,
            builder: (context, _) => CustomPaint(
              painter: _BlobPainter(_blobController.value),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: padH),
            child: Center(
              child: ConstrainedBox(
                constraints:
                    const BoxConstraints(maxWidth: Responsive.maxContentWidth),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _Fade(
                      animation: _stagger(0.0, 0.5),
                      child: Row(
                        children: [
                          Container(
                            width: 8,
                            height: 8,
                            decoration: const BoxDecoration(
                              color: AppColors.mint,
                              shape: BoxShape.circle,
                            ),
                          ),
                          const SizedBox(width: 10),
                          Text(
                            'OPEN TO INTERNSHIPS & COLLABORATIONS',
                            style: Theme.of(context).textTheme.labelSmall,
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 22),
                    _Fade(
                      animation: _stagger(0.1, 0.6),
                      child: Text(
                        'Hi, I\'m',
                        style: Theme.of(context).textTheme.headlineSmall
                            ?.copyWith(color: AppColors.textSecondary),
                      ),
                    ),
                    const SizedBox(height: 6),
                    _Fade(
                      animation: _stagger(0.15, 0.7),
                      child: Text(
                        PortfolioData.name,
                        style: (isMobile
                                ? Theme.of(context).textTheme.displayMedium
                                : Theme.of(context).textTheme.displayLarge)
                            ?.copyWith(fontSize: isMobile ? 40 : 64),
                      ),
                    ),
                    const SizedBox(height: 18),
                    _Fade(
                      animation: _stagger(0.25, 0.8),
                      child: Row(
                        children: [
                          const Text('▸ ',
                              style: TextStyle(
                                  color: AppColors.coral,
                                  fontWeight: FontWeight.bold)),
                          AnimatedSwitcher(
                            duration: const Duration(milliseconds: 400),
                            transitionBuilder: (child, anim) => FadeTransition(
                              opacity: anim,
                              child: SlideTransition(
                                position: Tween<Offset>(
                                  begin: const Offset(0, 0.3),
                                  end: Offset.zero,
                                ).animate(anim),
                                child: child,
                              ),
                            ),
                            child: Text(
                              PortfolioData.roleRotator[_roleIndex],
                              key: ValueKey(_roleIndex),
                              style: Theme.of(context)
                                  .textTheme
                                  .titleLarge
                                  ?.copyWith(
                                    color: AppColors.mint,
                                    fontSize: 20,
                                  ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 26),
                    _Fade(
                      animation: _stagger(0.35, 0.9),
                      child: ConstrainedBox(
                        constraints: const BoxConstraints(maxWidth: 600),
                        child: Text(
                          PortfolioData.summary,
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                      ),
                    ),
                    const SizedBox(height: 36),
                    _Fade(
                      animation: _stagger(0.45, 1.0),
                      child: Wrap(
                        spacing: 16,
                        runSpacing: 12,
                        children: [
                          _PrimaryButton(
                            label: 'View my work',
                            onTap: widget.onViewWork,
                          ),
                          _GhostButton(
                            label: 'Get in touch',
                            onTap: widget.onContact,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _Fade extends StatelessWidget {
  final Animation<double> animation;
  final Widget child;
  const _Fade({required this.animation, required this.child});

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) => Opacity(
        opacity: animation.value.clamp(0, 1),
        child: Transform.translate(
          offset: Offset(0, (1 - animation.value) * 18),
          child: child,
        ),
      ),
      child: child,
    );
  }
}

class _PrimaryButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _PrimaryButton({required this.label, required this.onTap});

  @override
  State<_PrimaryButton> createState() => _PrimaryButtonState();
}

class _PrimaryButtonState extends State<_PrimaryButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            color: _hovering ? AppColors.coralSoft : AppColors.coral,
            borderRadius: BorderRadius.circular(10),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.coral.withOpacity(0.35),
                      blurRadius: 24,
                      offset: const Offset(0, 8),
                    )
                  ]
                : [],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.label,
                style: const TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(width: 8),
              const Icon(Icons.arrow_forward_rounded,
                  size: 18, color: AppColors.background),
            ],
          ),
        ),
      ),
    );
  }
}

class _GhostButton extends StatefulWidget {
  final String label;
  final VoidCallback onTap;
  const _GhostButton({required this.label, required this.onTap});

  @override
  State<_GhostButton> createState() => _GhostButtonState();
}

class _GhostButtonState extends State<_GhostButton> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(horizontal: 26, vertical: 16),
          decoration: BoxDecoration(
            border: Border.all(
              color: _hovering ? AppColors.textPrimary : AppColors.border,
            ),
            borderRadius: BorderRadius.circular(10),
          ),
          child: Text(
            widget.label,
            style: TextStyle(
              color: _hovering ? AppColors.textPrimary : AppColors.textSecondary,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      ),
    );
  }
}

/// Two slow-drifting, softly blurred radial blobs used as ambient hero
/// background texture — cheap to paint, no images/assets required.
class _BlobPainter extends CustomPainter {
  final double t;
  _BlobPainter(this.t);

  @override
  void paint(Canvas canvas, Size size) {
    final blob1Center = Offset(
      size.width * (0.15 + 0.10 * (0.5 + 0.5 * _sin(t))),
      size.height * (0.25 + 0.08 * (0.5 + 0.5 * _cos(t))),
    );
    final blob2Center = Offset(
      size.width * (0.85 - 0.12 * (0.5 + 0.5 * _cos(t * 1.3))),
      size.height * (0.7 - 0.10 * (0.5 + 0.5 * _sin(t * 1.3))),
    );

    final paint1 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.coral.withOpacity(0.20),
          AppColors.coral.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: blob1Center, radius: size.width * 0.35))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    final paint2 = Paint()
      ..shader = RadialGradient(
        colors: [
          AppColors.mint.withOpacity(0.16),
          AppColors.mint.withOpacity(0.0),
        ],
      ).createShader(Rect.fromCircle(center: blob2Center, radius: size.width * 0.3))
      ..maskFilter = const MaskFilter.blur(BlurStyle.normal, 60);

    canvas.drawCircle(blob1Center, size.width * 0.35, paint1);
    canvas.drawCircle(blob2Center, size.width * 0.3, paint2);
  }

  double _sin(double t) => math.sin(t * 2 * math.pi);
  double _cos(double t) => math.cos(t * 2 * math.pi);

  @override
  bool shouldRepaint(covariant _BlobPainter oldDelegate) => oldDelegate.t != t;
}
