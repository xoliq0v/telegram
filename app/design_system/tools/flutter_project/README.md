# iOS Style Emoji Flutter Package

## 📱 Installation Guide

### 1. Add to pubspec.yaml:
```yaml
flutter:
  assets:
    - assets/emojis/
```

### 2. Install dependencies:
```bash
flutter pub get
```

### 3. Import and use:
```dart
import 'ios_emoji_renderer.dart';

// Basic usage
IOSEmojiRenderer(
  text: "Salom! 😀 Qanday holsiz? 😊👋",
  fontSize: 18,
)

// Message bubble
IOSMessageBubble(
  message: "Salom! 😊 Qanday holsiz?",
  isMe: false,
)
```

## 🎯 Features:
- ✅ Real iOS style emoji rendering
- ✅ High quality PNG images
- ✅ Automatic text + emoji mixing
- ✅ Message bubble component
- ✅ Customizable font sizes
- ✅ Error fallback to system emoji

## 🚀 Usage Examples:

### Simple Text with Emojis:
```dart
IOSEmojiRenderer(
  text: "Bu juda zo'r! 🎉🥳 Rahmat! 🙏",
  fontSize: 20,
)
```

### Custom Styling:
```dart
IOSEmojiRenderer(
  text: "Yaxshi! 😀 O'zingchi? 👋",
  fontSize: 16,
  textStyle: TextStyle(
    color: Colors.blue,
    fontWeight: FontWeight.w500,
  ),
)
```

### Message Bubbles:
```dart
Column(
  children: [
    IOSMessageBubble(
      message: "Salom! 😊",
      isMe: false,
    ),
    IOSMessageBubble(
      message: "Salom! 👋 Qanday holsiz?",
      isMe: true,
    ),
  ],
)
```

## 📦 File Structure:
```
lib/
  ios_emoji_renderer.dart
assets/
  emojis/
    emoji_1f600.png
    emoji_1f603.png
    ...
```

## 🔧 Customization:
- Change fontSize for different sizes
- Apply custom TextStyle
- Use in any widget tree
- Supports all standard emojis

Happy coding! 🎉
