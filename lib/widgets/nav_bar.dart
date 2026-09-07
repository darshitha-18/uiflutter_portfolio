import 'package:flutter/material.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';

class NavItem {
  final String label;
  final VoidCallback onTap;
  const NavItem(this.label, this.onTap);
}

/// A slim, glass-morphic top bar. Collapses into a compact menu icon that
/// opens a full-screen overlay on narrow layouts.
class NavBar extends StatefulWidget {
  final List<NavItem> items;
  const NavBar({super.key, required this.items});

  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  bool _menuOpen = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = !Responsive.isDesktop(context);
    return Stack(
      children: [
        Container(
          height: 68,
          padding:
              EdgeInsets.symmetric(horizontal: Responsive.horizontalPadding(context)),
          decoration: BoxDecoration(
            color: AppColors.background.withOpacity(0.86),
            border: const Border(
              bottom: BorderSide(color: AppColors.border, width: 1),
            ),
          ),
          child: Row(
            children: [
              _Logo(),
              const Spacer(),
              if (!isMobile)
                Row(
                  children: [
                    for (final item in widget.items) _NavLabel(item: item),
                  ],
                )
              else
                IconButton(
                  splashRadius: 20,
                  icon: Icon(
                    _menuOpen ? Icons.close_rounded : Icons.menu_rounded,
                    color: AppColors.textPrimary,
                  ),
                  onPressed: () => setState(() => _menuOpen = !_menuOpen),
                ),
            ],
          ),
        ),
        if (isMobile && _menuOpen)
          Positioned(
            top: 68,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.backgroundAlt,
              padding: const EdgeInsets.symmetric(vertical: 8),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final item in widget.items)
                    ListTile(
                      title: Text(
                        item.label,
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      onTap: () {
                        setState(() => _menuOpen = false);
                        item.onTap();
                      },
                    ),
                ],
              ),
            ),
          ),
      ],
    );
  }
}

class _Logo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: const BoxDecoration(
            color: AppColors.coral,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 10),
        Text(
          'bindu.darshitha',
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
                fontFeatures: const [],
                letterSpacing: -0.2,
              ),
        ),
      ],
    );
  }
}

class _NavLabel extends StatefulWidget {
  final NavItem item;
  const _NavLabel({required this.item});

  @override
  State<_NavLabel> createState() => _NavLabelState();
}

class _NavLabelState extends State<_NavLabel> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 14),
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        onEnter: (_) => setState(() => _hovering = true),
        onExit: (_) => setState(() => _hovering = false),
        child: GestureDetector(
          onTap: widget.item.onTap,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                widget.item.label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: _hovering
                          ? AppColors.textPrimary
                          : AppColors.textSecondary,
                      fontWeight: FontWeight.w600,
                    ),
              ),
              const SizedBox(height: 4),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                height: 2,
                width: _hovering ? 18 : 0,
                color: AppColors.coral,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
