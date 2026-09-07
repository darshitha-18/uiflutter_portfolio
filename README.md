# Bindu Darshitha — Portfolio (Flutter Web)

A personal portfolio site built with **Flutter Web**, sourced entirely from
my resume. Dark, warm-ink theme with a coral/mint accent, animated hero,
scroll-reveal sections, and a responsive layout for desktop, tablet and
mobile.

## ✨ Sections

Hero → About → Skills → Projects → Education → Achievements & Certifications → Contact

## 🗂 Project structure

```
lib/
  main.dart                     # App entry point
  theme/
    app_colors.dart             # Color palette
    app_theme.dart              # ThemeData + typography
  models/
    portfolio_models.dart       # Data classes (Project, Skill, Education, ...)
  data/
    portfolio_data.dart         # All resume content lives here
  widgets/
    responsive.dart             # Breakpoint helpers
    scroll_reveal.dart          # Dependency-free scroll fade/slide-in
    hover_lift.dart             # Hover/press lift wrapper for cards
    section_header.dart         # Numbered section heading
    nav_bar.dart                # Top nav (desktop labels / mobile menu)
    hero_section.dart
    about_section.dart
    skills_section.dart
    projects_section.dart
    project_card.dart
    education_section.dart
    achievements_section.dart
    contact_section.dart
    footer.dart
  screens/
    home_screen.dart            # Assembles all sections, handles scroll-to
web/
  index.html, manifest.json     # Web shell (GitHub Pages-ready base href)
.github/workflows/deploy.yml    # CI: build + auto-deploy to gh-pages branch
```

All personal content (name, education, skills, projects, certifications,
achievements, contact links) lives in **`lib/data/portfolio_data.dart`** —
edit that one file to keep the site in sync with your resume.

## 🔧 Setup

This repo ships the `lib/`, `pubspec.yaml`, and a custom `web/index.html` +
`web/manifest.json`, but not the full platform scaffold (icons, favicon,
etc.) that `flutter create` normally generates. Set it up once like this:

```bash
# 1. Scaffold a fresh Flutter web app (creates web/icons, favicon, etc.)
flutter create --platforms=web bindu_portfolio
cd bindu_portfolio

# 2. Replace the generated files with the ones from this project:
#    - delete the generated lib/main.dart, copy this repo's lib/ folder in its place
#    - replace pubspec.yaml with this repo's pubspec.yaml
#    - replace web/index.html and web/manifest.json with this repo's versions
#      (keep the generated web/icons/ folder and web/favicon.png)

# 3. Install dependencies
flutter pub get

# 4. Run locally in Chrome
flutter run -d chrome
```

If you'd rather not scaffold manually, copy this repo's `lib/`, `pubspec.yaml`,
`web/index.html` and `web/manifest.json` into the freshly-created project,
overwriting the defaults — just keep the generated `web/icons/` and
`web/favicon.png`.

## 🏗 Build for the web

```bash
flutter build web --release
```

Output goes to `build/web/`. Open `build/web/index.html` via a local server
(not `file://`) to preview, e.g. `python3 -m http.server --directory build/web`.

## 🚀 Deploy to GitHub Pages

**Option A — automatic (recommended):** this repo already includes
`.github/workflows/deploy.yml`. Once pushed to GitHub with a `main` branch:

1. Push this project to a new GitHub repo (steps below).
2. In the repo, go to **Settings → Pages → Build and deployment → Source**
   and select **Deploy from a branch**, branch `gh-pages`, folder `/ (root)`.
3. Every push to `main` will rebuild and redeploy automatically. The
   workflow sets `--base-href "/<your-repo-name>/"` for you.

**Option B — manual:**

```bash
flutter build web --release --base-href "/your-repo-name/"
# copy build/web contents to a gh-pages branch and push it
```

## 📤 Push to GitHub

```bash
git init
git add .
git commit -m "Initial commit: Flutter portfolio"
git branch -M main
git remote add origin https://github.com/darshitha-18/your-repo-name.git
git push -u origin main
```

Then enable GitHub Pages as described above. Your site will be live at:

```
https://darshitha-18.github.io/your-repo-name/
```

## 📝 Notes

- No unnecessary packages: only `cupertino_icons` (default) and
  `url_launcher` (needed for the email/GitHub/LinkedIn links to open
  correctly on the web).
- All animations (scroll-reveal, hover lift, hero blobs, role rotator) are
  hand-rolled with Flutter's own `Animation`/`AnimatedX` widgets — no
  animation packages required.
- Update `lib/data/portfolio_data.dart` any time your resume changes; every
  other file just renders that data.
