import 'package:flutter/material.dart';

/// Wraps [child] with a subtle lift + border-glow on hover (desktop/web)
/// and a gentle press-scale on tap (mobile). Purely presentational.
class HoverLift extends StatefulWidget {
  final Widget child;
  final VoidCallback? onTap;

  const HoverLift({super.key, required this.child, this.onTap});

  @override
  State<HoverLift> createState() => _HoverLiftState();
}

class _HoverLiftState extends State<HoverLift> {
  bool _hovering = false;
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final scale = _pressed ? 0.98 : (_hovering ? 1.015 : 1.0);
    return MouseRegion(
      cursor: widget.onTap != null
          ? SystemMouseCursors.click
          : SystemMouseCursors.basic,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        onTapDown: (_) => setState(() => _pressed = true),
        onTapCancel: () => setState(() => _pressed = false),
        onTapUp: (_) => setState(() => _pressed = false),
        child: AnimatedScale(
          scale: scale,
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOut,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            transform: Matrix4.translationValues(0, _hovering ? -4 : 0, 0),
            child: widget.child,
          ),
        ),
      ),
    );
  }
}
