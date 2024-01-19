import 'package:image/image.dart' as imglib;
import 'package:camera/camera.dart';

import '../../utils/utils.dart';

imglib.Image? convertToImage(CameraImage image) {
  try {
    if (image.format.group == ImageFormatGroup.yuv420) {
      return _convertYUV420(image);
    } else if (image.format.group == ImageFormatGroup.bgra8888) {
      return _convertBGRA8888(image);
    }
    throw Exception('Image format not supported');
  } catch (e) {
    printIfDebug("ERROR:$e");
  }
  return null;
}

imglib.Image _convertBGRA8888(CameraImage image) {
  return imglib.Image.fromBytes(
    width: image.width,
    height: image.height,
    bytes: image.planes[0].bytes.buffer,
    format: imglib.Format.int16,
  );
}

imglib.Image _convertYUV420(CameraImage image) {
  int width = image.width;
  int height = image.height;
  var img = imglib.Image(width: width, height: height);
  const int hexFF = 0xFF000000;
  final int uvyButtonStride = image.planes[1].bytesPerRow;
  final int? uvPixelStride = image.planes[1].bytesPerPixel;
  for (int x = 0; x < width; x++) {
    for (int y = 0; y < height; y++) {
      final int uvIndex =
          uvPixelStride! * (x / 2).floor() + uvyButtonStride * (y / 2).floor();
      final int index = y * width + x;
      final yp = image.planes[0].bytes[index];
      final up = image.planes[1].bytes[uvIndex];
      final vp = image.planes[2].bytes[uvIndex];
      int r = (yp + vp * 1436 / 1024 - 179).round().clamp(0, 255);
      int g = (yp - up * 46549 / 131072 + 44 - vp * 93604 / 131072 + 91)
          .round()
          .clamp(0, 255);
      int b = (yp + up * 1814 / 1024 - 227).round().clamp(0, 255);
      // img.data[index].= hexFF | (b << 16) | (g << 8) | r;
    }
  }

  return img;
}
