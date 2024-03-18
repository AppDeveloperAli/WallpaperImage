import 'package:image_switch_pro/exports.dart';

class WallpaperChanger {
  static const MethodChannel _channel = MethodChannel('wallpaper_changer');

  static Future<bool> changeWallpaper(String imagePath) async {
    try {
      final bool success = await _channel
          .invokeMethod('changeWallpaper', {'imagePath': imagePath});
      return success;
    } catch (e) {
      debugPrint('Error changing wallpaper: $e');
      return false;
    }
  }
}
