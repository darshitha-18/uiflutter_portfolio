import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../data/portfolio_data.dart';
import '../theme/app_colors.dart';
import 'responsive.dart';
import 'scroll_reveal.dart';

class ContactSection extends StatelessWidget {
  const ContactSection({super.key});

  Future<void> _open(String url) async {
    final uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, webOnlyWindowName: '_blank');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: AppColors.backgroundAlt,
      padding: EdgeInsets.symmetric(
        horizontal: Responsive.horizontalPadding(context),
        vertical: 110,
      ),
      child: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 720),
          child: RevealOnScroll(
            child: Column(
              children: [
                Text(
                  'Let\'s build something together',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.displayMedium?.copyWith(
                        fontSize: Responsive.isMobile(context) ? 30 : 42,
                      ),
                ),
                const SizedBox(height: 18),
                Text(
                  'Whether it\'s an ML idea, an internship opportunity, or just '
                  'a chat about RAG pipelines — my inbox is open.',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(height: 40),
                _EmailButton(onTap: () => _open('mailto:${PortfolioData.email}')),
                const SizedBox(height: 36),
                Wrap(
                  alignment: WrapAlignment.center,
                  spacing: 28,
                  runSpacing: 16,
                  children: [
                    _SocialLink(
                      icon: Icons.code_rounded,
                      label: PortfolioData.github,
                      onTap: () => _open(PortfolioData.githubUrl),
                    ),
                    _SocialLink(
                      icon: Icons.business_center_rounded,
                      label: PortfolioData.linkedin,
                      onTap: () => _open(PortfolioData.linkedinUrl),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _EmailButton extends StatefulWidget {
  final VoidCallback onTap;
  const _EmailButton({required this.onTap});

  @override
  State<_EmailButton> createState() => _EmailButtonState();
}

class _EmailButtonState extends State<_EmailButton> {
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
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 18),
          decoration: BoxDecoration(
            gradient: AppColors.heroGlow,
            borderRadius: BorderRadius.circular(12),
            boxShadow: _hovering
                ? [
                    BoxShadow(
                      color: AppColors.coral.withOpacity(0.4),
                      blurRadius: 30,
                      offset: const Offset(0, 10),
                    )
                  ]
                : [],
          ),
          transform: Matrix4.translationValues(0, _hovering ? -3 : 0, 0),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.mail_outline_rounded, color: AppColors.background),
              const SizedBox(width: 12),
              Text(
                PortfolioData.email,
                style: const TextStyle(
                  color: AppColors.background,
                  fontWeight: FontWeight.w700,
                  fontSize: 15.5,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SocialLink extends StatefulWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;
  const _SocialLink({required this.icon, required this.label, required this.onTap});

  @override
  State<_SocialLink> createState() => _SocialLinkState();
}

class _SocialLinkState extends State<_SocialLink> {
  bool _hovering = false;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _hovering = true),
      onExit: (_) => setState(() => _hovering = false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(widget.icon,
                size: 18,
                color: _hovering ? AppColors.mint : AppColors.textSecondary),
            const SizedBox(width: 8),
            Text(
              widget.label,
              style: TextStyle(
                color: _hovering ? AppColors.textPrimary : AppColors.textSecondary,
                fontWeight: FontWeight.w600,
                decoration: _hovering ? TextDecoration.underline : TextDecoration.none,
                decorationColor: AppColors.mint,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
