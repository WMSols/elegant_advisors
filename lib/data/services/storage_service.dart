import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:image_picker/image_picker.dart';
import 'package:elegant_advisors/data/services/image_compression_service.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  /// Detects the content type from file extension or mime type
  String _getContentType(XFile file) {
    // Try to get mime type first (available on web and some platforms)
    final mimeType = file.mimeType;
    if (mimeType != null && mimeType.startsWith('image/')) {
      return mimeType;
    }

    // Fallback to extension-based detection
    final path = file.path.toLowerCase();
    if (path.endsWith('.png')) {
      return 'image/png';
    } else if (path.endsWith('.jpg') || path.endsWith('.jpeg')) {
      return 'image/jpeg';
    } else if (path.endsWith('.gif')) {
      return 'image/gif';
    } else if (path.endsWith('.webp')) {
      return 'image/webp';
    }

    // Default to JPEG if unknown
    return 'image/jpeg';
  }

  /// Gets file extension from content type or file path
  String _getFileExtension(String contentType, XFile file) {
    if (contentType == 'image/png') return 'png';
    if (contentType == 'image/jpeg') return 'jpg';
    if (contentType == 'image/gif') return 'gif';
    if (contentType == 'image/webp') return 'webp';

    // Fallback to extension from path
    final path = file.path.toLowerCase();
    if (path.endsWith('.png')) return 'png';
    if (path.endsWith('.jpg') || path.endsWith('.jpeg')) return 'jpg';
    if (path.endsWith('.gif')) return 'gif';
    if (path.endsWith('.webp')) return 'webp';

    return 'jpg'; // Default
  }

  Future<String> uploadPropertyImage(XFile imageFile, String propertyId) async {
    final contentType = _getContentType(imageFile);
    final extension = _getFileExtension(contentType, imageFile);
    final fileName = '${_uuid.v4()}.$extension';
    final ref = _storage.ref().child('properties/$propertyId/$fileName');

    // Read image bytes and compress before uploading
    final originalBytes = await imageFile.readAsBytes();
    final compressedBytes =
        await ImageCompressionService.compressImageFromBytes(
          imageBytes: originalBytes,
          maxWidth: 1920,
          maxHeight: 1080,
          quality: 85,
          maxFileSize: 500 * 1024, // 500KB
        );

    final uploadTask = ref.putData(
      compressedBytes,
      SettableMetadata(contentType: contentType),
    );

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<List<String>> uploadPropertyImages(
    List<XFile> imageFiles,
    String propertyId,
  ) async {
    final List<String> urls = [];
    for (final file in imageFiles) {
      urls.add(await uploadPropertyImage(file, propertyId));
    }
    return urls;
  }

  Future<void> deletePropertyImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print('Error deleting image: $e');
    }
  }

  Future<void> deletePropertyImages(List<String> imageUrls) async {
    for (final url in imageUrls) {
      await deletePropertyImage(url);
    }
  }

  Future<void> deletePropertyFolder(String propertyId) async {
    try {
      final listResult = await _storage
          .ref()
          .child('properties/$propertyId')
          .listAll();
      for (final item in listResult.items) {
        await item.delete();
      }
    } catch (e) {
      print('Error deleting property folder: $e');
    }
  }

  Future<String> uploadTeamPhoto(XFile imageFile, String teamMemberId) async {
    final contentType = _getContentType(imageFile);
    final extension = _getFileExtension(contentType, imageFile);
    final fileName = '${_uuid.v4()}.$extension';
    final ref = _storage.ref().child('team/$teamMemberId/$fileName');

    final bytes = await imageFile.readAsBytes();
    final uploadTask = ref.putData(
      bytes,
      SettableMetadata(contentType: contentType),
    );

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteTeamPhoto(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print('Error deleting team photo: $e');
    }
  }

  Future<String> uploadCMSImage(
    XFile imageFile,
    String pageId,
    String sectionId,
  ) async {
    final contentType = _getContentType(imageFile);
    final extension = _getFileExtension(contentType, imageFile);
    final fileName = '${_uuid.v4()}.$extension';
    final ref = _storage.ref().child('cms/$pageId/$sectionId/$fileName');

    final bytes = await imageFile.readAsBytes();
    final uploadTask = ref.putData(
      bytes,
      SettableMetadata(contentType: contentType),
    );

    final snapshot = await uploadTask;
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteCMSImage(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print('Error deleting CMS image: $e');
    }
  }
}
