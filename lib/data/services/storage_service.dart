import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';

class StorageService {
  final FirebaseStorage _storage = FirebaseStorage.instance;
  final Uuid _uuid = const Uuid();

  Future<String> uploadPropertyImage(File imageFile, String propertyId) async {
    final fileName = '${_uuid.v4()}.jpg';
    final ref = _storage.ref().child('properties/$propertyId/$fileName');
    final snapshot = await ref.putFile(imageFile);
    return await snapshot.ref.getDownloadURL();
  }

  Future<List<String>> uploadPropertyImages(List<File> imageFiles, String propertyId) async {
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
    for (final url in imageUrls) await deletePropertyImage(url);
  }

  Future<void> deletePropertyFolder(String propertyId) async {
    try {
      final listResult = await _storage.ref().child('properties/$propertyId').listAll();
      for (final item in listResult.items) await item.delete();
    } catch (e) {
      print('Error deleting property folder: $e');
    }
  }

  Future<String> uploadTeamPhoto(File imageFile, String teamMemberId) async {
    final fileName = '${_uuid.v4()}.jpg';
    final ref = _storage.ref().child('team/$teamMemberId/$fileName');
    final snapshot = await ref.putFile(imageFile);
    return await snapshot.ref.getDownloadURL();
  }

  Future<void> deleteTeamPhoto(String imageUrl) async {
    try {
      await _storage.refFromURL(imageUrl).delete();
    } catch (e) {
      print('Error deleting team photo: $e');
    }
  }

  Future<String> uploadCMSImage(File imageFile, String pageId, String sectionId) async {
    final fileName = '${_uuid.v4()}.jpg';
    final ref = _storage.ref().child('cms/$pageId/$sectionId/$fileName');
    final snapshot = await ref.putFile(imageFile);
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
