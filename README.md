# Al Rasin — Portfolio

Personal portfolio built with Flutter Web.

**Live:** https://al-rasin.github.io

## Run locally

```sh
flutter pub get
flutter run -d chrome
```

## Build

```sh
flutter build web --release --wasm --pwa-strategy=none --base-href /
```

Every push to `main` is built and deployed to GitHub Pages by
`.github/workflows/deploy.yml`.

## Edit content

All text, links, live apps, projects and blog posts live in
`lib/data/portfolio_data.dart`. The Blog section only appears when
`blogPosts` has at least one post.
