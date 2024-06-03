import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension FileExt on File {
  bool get isImage =>
      path.endsWith('.jpg') ||
      path.endsWith('.jpeg') ||
      path.endsWith('.png') ||
      path.endsWith('.webp') ||
      path.endsWith('.avif') ||
      path.endsWith('.svg') ||
      path.endsWith('.gif') ||
      path.endsWith('.jfif') ||
      path.endsWith('.bmp') ||
      path.endsWith('.heic') ||
      path.endsWith('.heif');

  bool get isVideo {
    List<String> videoExtensions = [
      'mp4',
      'mov',
      'avi',
      'wmv',
      'mkv',
      'webm',
      'flv',
      'm4v',
      '3gp',
      '3g2',
      'mpg',
      'mpeg',
      'ts',
      'mts',
      'm2ts'
    ];

    return videoExtensions.contains(path.split('.').last);
  }
}

extension XFileExt on XFile {
  File get toFile => File(path);

  bool get isVideo => toFile.isVideo;
  bool get isImage => toFile.isImage;
}

extension StringExt on String {
  bool get isFirebaseVideoUrl {
    final videoExtensions = [
      'mp4',
      'mov',
      'avi',
      'wmv',
      'mkv',
      'webm',
      'flv',
      'm4v',
      '3gp',
      '3g2',
      'mpg',
      'mpeg',
      'ts',
      'mts',
      'm2ts'
    ];

    for (final ext in videoExtensions) {
      if (contains(ext)) {
        return true;
      }
    }
    return false;
  }

  bool get isFirebaseImageUrl {
    final imageExtensions = [
      'jpg',
      'jpeg',
      'png',
      'webp',
      'avif',
      'svg',
      'gif',
      'jfif',
      'bmp',
      'heic',
      'heif'
    ];
    for (final ext in imageExtensions) {
      if (contains(ext)) {
        return true;
      }
    }
    return false;
  }
}
