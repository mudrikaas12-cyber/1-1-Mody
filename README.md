# Assets Directory

This directory contains all static assets used in the Mody Alumni Connect application.

## Directory Structure

```
assets/
├── images/          # Application images and graphics
├── icons/           # Custom icons and SVG files
└── fonts/           # Custom font files
```

## Images

Place your application images in the `images/` directory:

- Logo files
- Splash screen images
- Default profile pictures
- Onboarding graphics
- Feature illustrations

**Recommended formats:** PNG, JPG, SVG

## Icons

Place custom icons in the `icons/` directory:

- App icon (for launcher)
- Navigation icons
- Feature icons
- Category icons

**Recommended format:** SVG or PNG (multiple sizes)

## Fonts

### Required Fonts

Download Poppins font family from [Google Fonts](https://fonts.google.com/specimen/Poppins):

Required weights:
- `Poppins-Regular.ttf` (400)
- `Poppins-Medium.ttf` (500)
- `Poppins-SemiBold.ttf` (600)
- `Poppins-Bold.ttf` (700)

### Installation Steps

1. Download Poppins from Google Fonts
2. Extract the font files
3. Copy the required .ttf files to `assets/fonts/`
4. Fonts are already declared in `pubspec.yaml`

## Usage in Code

### Images
```dart
// Using Image.asset
Image.asset('assets/images/logo.png')

// Using AssetImage
decoration: BoxDecoration(
  image: DecorationImage(
    image: AssetImage('assets/images/background.png'),
  ),
)
```

### Icons
```dart
// Using SvgPicture (if using SVG)
SvgPicture.asset(
  'assets/icons/custom_icon.svg',
  width: 24,
  height: 24,
)
```

### Fonts
```dart
// Fonts are automatically applied through theme
// See lib/utils/theme.dart for configuration

// Custom usage
Text(
  'Hello',
  style: TextStyle(
    fontFamily: 'Poppins',
    fontWeight: FontWeight.bold,
  ),
)
```

## Asset Organization Best Practices

### Naming Convention
- Use lowercase with underscores: `user_profile.png`
- Be descriptive: `alumni_icon_active.svg`
- Include dimensions for icons: `icon_24x24.png`

### Image Optimization
- Compress images before adding
- Use appropriate formats:
  - PNG for graphics with transparency
  - JPG for photos
  - SVG for scalable icons
- Provide multiple resolutions if needed (1x, 2x, 3x)

### Size Guidelines
- App icon: 1024x1024px
- Profile images: 400x400px
- Thumbnails: 100x100px
- Icons: 24x24px, 48x48px

## Adding New Assets

1. Place files in appropriate directory
2. Update `pubspec.yaml` if needed:
   ```yaml
   flutter:
     assets:
       - assets/images/new_image.png
   ```
3. Run `flutter pub get`
4. Use in your code

## Required Assets for App

### Essential Images
- [ ] App logo (for splash screen)
- [ ] Default profile picture
- [ ] Empty state illustrations

### Fonts
- [x] Poppins (configured in pubspec.yaml)

### Icons
- [ ] Custom app icon (use flutter_launcher_icons)

## Generating App Icons

Use `flutter_launcher_icons` package:

1. Add a 1024x1024 PNG image: `assets/icons/app_icon.png`
2. Configuration is in `pubspec.yaml`
3. Run: `flutter pub run flutter_launcher_icons:main`

## Notes

- Keep assets under 1MB when possible
- Use lazy loading for large images
- Cache network images appropriately
- Consider using placeholders for slow loading

## Resources

- [Google Fonts](https://fonts.google.com/)
- [Unsplash](https://unsplash.com/) - Free images
- [Flaticon](https://www.flaticon.com/) - Free icons
- [unDraw](https://undraw.co/) - Free illustrations
- [TinyPNG](https://tinypng.com/) - Image compression
