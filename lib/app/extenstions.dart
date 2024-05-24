import 'dart:io';

import 'package:image_picker/image_picker.dart';

extension FileExt on File {
  bool get isImage =>
      path.endsWith('.jpg') || path.endsWith('.jpeg') || path.endsWith('.png');

  bool get isVideo {
    List<String> videoExtensions = ['mp4', 'mov', 'avi', 'wmv', 'mkv', 'webm'];

    return videoExtensions.contains(path.split('.').last);
  }
}

extension XFileExt on XFile {
  File get toFile => File(path);

  bool get isVideo => toFile.isVideo;
  bool get isImage => toFile.isImage;
}
