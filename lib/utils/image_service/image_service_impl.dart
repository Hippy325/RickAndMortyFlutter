import 'dart:io';

import 'package:http/http.dart' as http;
import 'package:flutter_application_1/utils/image_service/image_service.dart';
import 'package:path_provider/path_provider.dart';

class ImageServiceImpl extends ImageService {
  @override
  Future<String> saveImage(
    String url,
    int characterId,
  ) async {
    final response = await http.get(Uri.parse(url));

    if (response.statusCode != 200) {
      throw Exception("Failed to download image");
    }
    final directory = await getApplicationCacheDirectory();
    final fileName = 'character_$characterId.png';
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    await file.writeAsBytes(response.bodyBytes);

    return fileName;
  }

  @override
  Future<void> deleteImage(String? fileName) async {
    final directory = await getApplicationCacheDirectory();
    final filePath = '${directory.path}/$fileName';
    final file = File(filePath);
    if (await file.exists()) {
      await file.delete();
    }
  }
}
