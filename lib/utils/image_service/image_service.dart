abstract class ImageService {
  Future<String> saveImage(
    String url,
    int characterId,
  );
  Future<void> deleteImage(String? path);
}
