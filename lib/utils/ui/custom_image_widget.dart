import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/utils/ui/custom_circular_progress_indicator.dart';
import 'package:path_provider/path_provider.dart';

class CustomImageWidget extends StatelessWidget {
  final String? fileName;
  final String url;

  const CustomImageWidget({
    required this.fileName,
    required this.url,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<File?>(
      future: _getLocalImage(fileName),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final file = snapshot.data;

        if (file != null) {
          return Image.file(
            file,
            fit: BoxFit.cover,
          );
        }

        return Image.network(
          url,
          fit: BoxFit.cover,
          loadingBuilder: (context, child, loadingProgress) {
            if (loadingProgress == null) return child;
            return const Center(
              child: CustomCircularProgressIndicator(),
            );
          },
        );
      },
    );
  }

  Future<File?> _getLocalImage(String? fileName) async {
    if (fileName == null) return null;
    final dir = await getApplicationCacheDirectory();
    final file = File('${dir.path}/$fileName');
    return file.existsSync() ? file : null;
  }
}
