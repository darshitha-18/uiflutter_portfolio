import 'package:flutter/material.dart';

/// A tiny, dependency-free "scroll spy" that pings its listeners on every
/// scroll notification. [RevealOnScroll] widgets subscribe to it and check
/// their own position on each tick — this avoids pulling in a package such
/// as `visibility_detector` for a fairly small amount of behaviour.
class ScrollRevealController extends ChangeNotifier {
  void tick() => notifyListeners();
}

/// Provides a [ScrollRevealController] to the widget tree below it and wires
/// it to any [ScrollNotification] that bubbles up from descendants.
class ScrollRevealScope extends StatefulWidget {
  final Widget child;
  const ScrollRevealScope({super.key, required this.child});

  static ScrollRevealController of(BuildContext context) {
    final scope =
        context.dependOnInheritedWidgetOfExactType<_ScrollRevealInherited>();
    assert(scope != null, 'No ScrollRevealScope found in context');
    return scope!.controller;
  }

  @override
  State<ScrollRevealScope> createState() => _ScrollRevealScopeState();
}

class _ScrollRevealScopeState extends State<ScrollRevealScope> {
  final ScrollRevealController _controller = ScrollRevealController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        _controller.tick();
        return false;
      },
      child: _ScrollRevealInherited(
        controller: _controller,
        child: widget.child,
      ),
    );
  }
}

class _ScrollRevealInherited extends InheritedWidget {
  final ScrollRevealController controller;
  const _ScrollRevealInherited({
    required this.controller,
    required super.child,
  });

  @override
  bool updateShouldNotify(_ScrollRevealInherited oldWidget) => false;
}

/// Fades and slides [child] into place the first time it becomes at least
/// partially visible within the viewport. Purely additive/cosmetic — if
/// anything goes wrong while measuring, it simply falls back to visible.
class RevealOnScroll extends StatefulWidget {
  final Widget child;
  final Duration delay;
  final double offsetY;

  const RevealOnScroll({
    super.key,
    required this.child,
    this.delay = Duration.zero,
    this.offsetY = 32,
  });

  @override
  State<RevealOnScroll> createState() => _RevealOnScrollState();
}

class _RevealOnScrollState extends State<RevealOnScroll> {
  bool _revealed = false;
  ScrollRevealController? _controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _controller?.removeListener(_check);
    _controller = ScrollRevealScope.of(context);
    _controller!.addListener(_check);
    WidgetsBinding.instance.addPostFrameCallback((_) => _check());
  }

  @override
  void dispose() {
    _controller?.removeListener(_check);
    super.dispose();
  }

  void _check() {
    if (_revealed || !mounted) return;
    final renderObject = context.findRenderObject();
    if (renderObject is! RenderBox || !renderObject.attached) return;
    final size = MediaQuery.of(context).size;
    final position = renderObject.localToGlobal(Offset.zero);
    final visible = position.dy < size.height * 0.92 &&
        position.dy + renderObject.size.height > 0;
    if (visible) {
      Future.delayed(widget.delay, () {
        if (mounted) setState(() => _revealed = true);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _revealed ? 1 : 0,
      duration: const Duration(milliseconds: 550),
      curve: Curves.easeOut,
      child: AnimatedSlide(
        offset: _revealed ? Offset.zero : Offset(0, widget.offsetY / 100),
        duration: const Duration(milliseconds: 550),
        curve: Curves.easeOutCubic,
        child: widget.child,
      ),
    );
  }
}
