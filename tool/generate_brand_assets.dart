import 'dart:convert';
import 'dart:io';
import 'dart:math' as math;
import 'dart:typed_data';

const _brandRed = _Color(255, 49, 49, 255);
const _transparent = _Color(0, 0, 0, 0);
const _white = _Color(255, 255, 255, 255);

const _logoCoverage = 0.74;
const _markBounds = _Bounds(left: 44, top: 58, right: 282, bottom: 268);

const _markPolygons = [
  [
    _Point(44, 90),
    _Point(90, 90),
    _Point(150, 151),
    _Point(191, 109),
    _Point(145, 109),
    _Point(282, 58),
    _Point(224, 160),
    _Point(149, 217),
    _Point(90, 157),
    _Point(90, 236),
    _Point(44, 268),
  ],
  [
    _Point(252, 128),
    _Point(252, 268),
    _Point(207, 235),
    _Point(207, 176),
  ],
];

const _targets = [
  _IconTarget(
    'assets/brand/momentum_logo.png',
    size: 1024,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'android/app/src/main/res/mipmap-mdpi/ic_launcher.png',
    size: 48,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'android/app/src/main/res/mipmap-hdpi/ic_launcher.png',
    size: 72,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'android/app/src/main/res/mipmap-xhdpi/ic_launcher.png',
    size: 96,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'android/app/src/main/res/mipmap-xxhdpi/ic_launcher.png',
    size: 144,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'android/app/src/main/res/mipmap-xxxhdpi/ic_launcher.png',
    size: 192,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@1x.png',
    size: 20,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@2x.png',
    size: 40,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-20x20@3x.png',
    size: 60,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@1x.png',
    size: 29,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@2x.png',
    size: 58,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-29x29@3x.png',
    size: 87,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@1x.png',
    size: 40,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@2x.png',
    size: 80,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-40x40@3x.png',
    size: 120,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@2x.png',
    size: 120,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-60x60@3x.png',
    size: 180,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@1x.png',
    size: 76,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-76x76@2x.png',
    size: 152,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-83.5x83.5@2x.png',
    size: 167,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'ios/Runner/Assets.xcassets/AppIcon.appiconset/Icon-App-1024x1024@1x.png',
    size: 1024,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_16.png',
    size: 16,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_32.png',
    size: 32,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_64.png',
    size: 64,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_128.png',
    size: 128,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_256.png',
    size: 256,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_512.png',
    size: 512,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'macos/Runner/Assets.xcassets/AppIcon.appiconset/app_icon_1024.png',
    size: 1024,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'web/favicon.png',
    size: 32,
    transparentBackground: true,
    includeAlpha: true,
  ),
  _IconTarget(
    'web/icons/Icon-192.png',
    size: 192,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'web/icons/Icon-512.png',
    size: 512,
    transparentBackground: false,
    includeAlpha: false,
  ),
  _IconTarget(
    'web/icons/Icon-maskable-192.png',
    size: 192,
    transparentBackground: false,
    includeAlpha: false,
    logoCoverage: 0.56,
  ),
  _IconTarget(
    'web/icons/Icon-maskable-512.png',
    size: 512,
    transparentBackground: false,
    includeAlpha: false,
    logoCoverage: 0.56,
  ),
];

Future<void> main() async {
  for (final target in _targets) {
    await _writeRenderedIcon(target);
  }
  await _writeWindowsIcon('windows/runner/resources/app_icon.ico');

  stdout.writeln(
    'Generated ${_targets.length} Momentum PNG assets and the Windows icon.',
  );
}

Future<void> _writeRenderedIcon(_IconTarget target) async {
  final rgba = _renderLogo(
    size: target.size,
    transparentBackground: target.transparentBackground,
    logoCoverage: target.logoCoverage,
  );
  final png = _encodePng(
    rgba,
    width: target.size,
    height: target.size,
    includeAlpha: target.includeAlpha,
  );
  final file = File(target.path);

  await file.parent.create(recursive: true);
  await file.writeAsBytes(png, flush: true);
}

Future<void> _writeWindowsIcon(String path) async {
  const sizes = [16, 24, 32, 48, 64, 128, 256];
  final images = sizes
      .map((size) {
        final rgba = _renderLogo(
          size: size,
          transparentBackground: false,
        );
        return _IcoImage(
          size,
          _encodePng(
            rgba,
            width: size,
            height: size,
            includeAlpha: false,
          ),
        );
      })
      .toList(growable: false);

  final output = BytesBuilder(copy: false);
  _writeUint16Le(output, 0);
  _writeUint16Le(output, 1);
  _writeUint16Le(output, images.length);

  var imageOffset = 6 + images.length * 16;
  for (final image in images) {
    final dimension = image.size == 256 ? 0 : image.size;
    output.add([dimension, dimension, 0, 0]);
    _writeUint16Le(output, 1);
    _writeUint16Le(output, 32);
    _writeUint32Le(output, image.png.length);
    _writeUint32Le(output, imageOffset);
    imageOffset += image.png.length;
  }

  for (final image in images) {
    output.add(image.png);
  }

  final file = File(path);
  await file.parent.create(recursive: true);
  await file.writeAsBytes(output.takeBytes(), flush: true);
}

Uint8List _renderLogo({
  required int size,
  required bool transparentBackground,
  double logoCoverage = _logoCoverage,
}) {
  final sampleFactor = _sampleFactorFor(size);
  final highSize = size * sampleFactor;
  final highPixels = Uint8List(highSize * highSize * 4);
  final background = transparentBackground ? _transparent : _white;

  _fillCanvas(highPixels, background);

  final transformedPolygons = _markPolygons
      .map(
        (polygon) => _transformPolygon(
          polygon,
          highSize,
          logoCoverage,
        ),
      )
      .toList(growable: false);

  for (final polygon in transformedPolygons) {
    _fillPolygon(highPixels, highSize, highSize, polygon, _brandRed);
  }

  return _downsample(
    highPixels,
    highSize: highSize,
    outputSize: size,
    sampleFactor: sampleFactor,
    unpremultiplyAlpha: transparentBackground,
  );
}

List<_Point> _transformPolygon(
  List<_Point> polygon,
  int canvasSize,
  double logoCoverage,
) {
  final sourceSize = math.max(_markBounds.width, _markBounds.height);
  final desiredSize = canvasSize * logoCoverage;
  final scale = desiredSize / sourceSize;
  final offsetX =
      (canvasSize - _markBounds.width * scale) / 2 - _markBounds.left * scale;
  final offsetY =
      (canvasSize - _markBounds.height * scale) / 2 - _markBounds.top * scale;

  return polygon
      .map(
        (point) => _Point(point.x * scale + offsetX, point.y * scale + offsetY),
      )
      .toList(growable: false);
}

void _fillCanvas(Uint8List pixels, _Color color) {
  for (var index = 0; index < pixels.length; index += 4) {
    pixels[index] = color.red;
    pixels[index + 1] = color.green;
    pixels[index + 2] = color.blue;
    pixels[index + 3] = color.alpha;
  }
}

void _fillPolygon(
  Uint8List pixels,
  int width,
  int height,
  List<_Point> polygon,
  _Color color,
) {
  final nodes = <double>[];

  for (var y = 0; y < height; y++) {
    final scanY = y + 0.5;
    nodes.clear();

    for (var i = 0; i < polygon.length; i++) {
      final current = polygon[i];
      final previous = polygon[(i + polygon.length - 1) % polygon.length];
      final crossesScanline =
          current.y < scanY && previous.y >= scanY ||
          previous.y < scanY && current.y >= scanY;

      if (crossesScanline) {
        final x =
            current.x +
            (scanY - current.y) /
                (previous.y - current.y) *
                (previous.x - current.x);
        nodes.add(x);
      }
    }

    nodes.sort();

    for (var i = 0; i + 1 < nodes.length; i += 2) {
      final startX = math.max(0, nodes[i].ceil());
      final endX = math.min(width - 1, nodes[i + 1].floor());

      for (var x = startX; x <= endX; x++) {
        final index = (y * width + x) * 4;
        pixels[index] = color.red;
        pixels[index + 1] = color.green;
        pixels[index + 2] = color.blue;
        pixels[index + 3] = color.alpha;
      }
    }
  }
}

Uint8List _downsample(
  Uint8List highPixels, {
  required int highSize,
  required int outputSize,
  required int sampleFactor,
  required bool unpremultiplyAlpha,
}) {
  final output = Uint8List(outputSize * outputSize * 4);
  final sampleCount = sampleFactor * sampleFactor;

  for (var y = 0; y < outputSize; y++) {
    for (var x = 0; x < outputSize; x++) {
      var red = 0;
      var green = 0;
      var blue = 0;
      var alpha = 0;

      for (var dy = 0; dy < sampleFactor; dy++) {
        for (var dx = 0; dx < sampleFactor; dx++) {
          final highX = x * sampleFactor + dx;
          final highY = y * sampleFactor + dy;
          final highIndex = (highY * highSize + highX) * 4;

          red += highPixels[highIndex];
          green += highPixels[highIndex + 1];
          blue += highPixels[highIndex + 2];
          alpha += highPixels[highIndex + 3];
        }
      }

      final outputIndex = (y * outputSize + x) * 4;
      final averagedAlpha = (alpha / sampleCount).round();
      output[outputIndex + 3] = averagedAlpha;

      if (unpremultiplyAlpha && alpha > 0) {
        output[outputIndex] = (red * 255 / alpha).round().clamp(0, 255);
        output[outputIndex + 1] = (green * 255 / alpha).round().clamp(0, 255);
        output[outputIndex + 2] = (blue * 255 / alpha).round().clamp(0, 255);
      } else {
        output[outputIndex] = (red / sampleCount).round();
        output[outputIndex + 1] = (green / sampleCount).round();
        output[outputIndex + 2] = (blue / sampleCount).round();
      }
    }
  }

  return output;
}

int _sampleFactorFor(int size) {
  if (size < 96) return 4;
  if (size < 512) return 3;
  return 2;
}

Uint8List _encodePng(
  Uint8List rgba, {
  required int width,
  required int height,
  required bool includeAlpha,
}) {
  final colorType = includeAlpha ? 6 : 2;
  final bytesPerPixel = includeAlpha ? 4 : 3;
  final scanlineSize = width * bytesPerPixel + 1;
  final raw = Uint8List(scanlineSize * height);

  for (var y = 0; y < height; y++) {
    final rawRow = y * scanlineSize;
    raw[rawRow] = 0;

    for (var x = 0; x < width; x++) {
      final rgbaIndex = (y * width + x) * 4;
      final rawIndex = rawRow + 1 + x * bytesPerPixel;

      raw[rawIndex] = rgba[rgbaIndex];
      raw[rawIndex + 1] = rgba[rgbaIndex + 1];
      raw[rawIndex + 2] = rgba[rgbaIndex + 2];

      if (includeAlpha) {
        raw[rawIndex + 3] = rgba[rgbaIndex + 3];
      }
    }
  }

  final output = BytesBuilder(copy: false)
    ..add([137, 80, 78, 71, 13, 10, 26, 10]);
  final ihdr = BytesBuilder(copy: false);

  _writeUint32(ihdr, width);
  _writeUint32(ihdr, height);
  ihdr.add([8, colorType, 0, 0, 0]);

  _addChunk(output, 'IHDR', ihdr.takeBytes());
  _addChunk(output, 'IDAT', ZLibEncoder().convert(raw));
  _addChunk(output, 'IEND', const []);

  return output.takeBytes();
}

void _addChunk(BytesBuilder output, String type, List<int> data) {
  final typeBytes = ascii.encode(type);
  final crcInput = BytesBuilder(copy: false)
    ..add(typeBytes)
    ..add(data);

  _writeUint32(output, data.length);
  output
    ..add(typeBytes)
    ..add(data);
  _writeUint32(output, _crc32(crcInput.takeBytes()));
}

void _writeUint32(BytesBuilder output, int value) {
  output.add([
    (value >> 24) & 0xff,
    (value >> 16) & 0xff,
    (value >> 8) & 0xff,
    value & 0xff,
  ]);
}

void _writeUint16Le(BytesBuilder output, int value) {
  output.add([value & 0xff, (value >> 8) & 0xff]);
}

void _writeUint32Le(BytesBuilder output, int value) {
  output.add([
    value & 0xff,
    (value >> 8) & 0xff,
    (value >> 16) & 0xff,
    (value >> 24) & 0xff,
  ]);
}

int _crc32(List<int> bytes) {
  var crc = 0xffffffff;

  for (final byte in bytes) {
    crc = (_crcTable[(crc ^ byte) & 0xff] ^ (crc >> 8)) & 0xffffffff;
  }

  return (crc ^ 0xffffffff) & 0xffffffff;
}

List<int> _buildCrcTable() {
  return List<int>.generate(256, (index) {
    var crc = index;

    for (var bit = 0; bit < 8; bit++) {
      crc = crc.isOdd ? 0xedb88320 ^ (crc >> 1) : crc >> 1;
    }

    return crc;
  }, growable: false);
}

final List<int> _crcTable = _buildCrcTable();

class _IconTarget {
  const _IconTarget(
    this.path, {
    required this.size,
    required this.transparentBackground,
    required this.includeAlpha,
    this.logoCoverage = _logoCoverage,
  });

  final String path;
  final int size;
  final bool transparentBackground;
  final bool includeAlpha;
  final double logoCoverage;
}

class _IcoImage {
  const _IcoImage(this.size, this.png);

  final int size;
  final Uint8List png;
}

class _Color {
  const _Color(this.red, this.green, this.blue, this.alpha);

  final int red;
  final int green;
  final int blue;
  final int alpha;
}

class _Point {
  const _Point(this.x, this.y);

  final double x;
  final double y;
}

class _Bounds {
  const _Bounds({
    required this.left,
    required this.top,
    required this.right,
    required this.bottom,
  });

  final double left;
  final double top;
  final double right;
  final double bottom;

  double get width => right - left;
  double get height => bottom - top;
}
