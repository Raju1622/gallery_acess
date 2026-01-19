import 'dart:io';
import 'package:photo_manager/photo_manager.dart';
import 'package:permission_handler/permission_handler.dart';

class PhotoService {
  /// Get all camera photos from device
  Future<List<File>> getCameraPhotos() async {
    try {
      // Check permission
      PermissionStatus permission;
      try {
        permission = await Permission.photos.status;
      } catch (e) {
        permission = await Permission.storage.status;
      }

      if (!permission.isGranted && !permission.isLimited) {
        throw Exception('Storage permission not granted');
      }

      // Request permission if needed
      if (!permission.isGranted && !permission.isLimited) {
        try {
          permission = await Permission.photos.request();
        } catch (e) {
          permission = await Permission.storage.request();
        }

        if (!permission.isGranted && !permission.isLimited) {
          throw Exception('Storage permission denied');
        }
      }

      // Request permission for photo_manager
      final photoPermission = await PhotoManager.requestPermissionExtend();
      if (!photoPermission.isAuth) {
        throw Exception('Photo manager permission denied');
      }

      // Get all albums
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      if (albums.isEmpty) {
        return [];
      }

      // Get camera album (usually named "Camera" or "DCIM/Camera")
      AssetPathEntity? cameraAlbum;
      for (var album in albums) {
        if (album.name.toLowerCase().contains('camera') ||
            album.name.toLowerCase().contains('dcim')) {
          cameraAlbum = album;
          break;
        }
      }

      // If no camera album found, use the first album (usually all photos)
      cameraAlbum ??= albums.first;

      // Get all assets from camera album
      final assetCount = await cameraAlbum.assetCountAsync;
      final assets = await cameraAlbum.getAssetListRange(
        start: 0,
        end: assetCount,
      );

      // Convert assets to files (only camera photos)
      final files = <File>[];
      for (var asset in assets) {
        try {
          // Check if photo is from camera (usually has location or taken date)
          // Get file
          final file = await asset.file;
          if (file != null) {
            files.add(file);
          }
        } catch (e) {
          print('Error getting file for asset: $e');
        }
      }

      return files;
    } catch (e) {
      throw Exception('Error getting camera photos: $e');
    }
  }

  /// Get all photos from device (not just camera)
  Future<List<File>> getAllPhotos({int? limit}) async {
    try {
      // Check permission
      PermissionStatus permission;
      try {
        permission = await Permission.photos.status;
      } catch (e) {
        permission = await Permission.storage.status;
      }

      if (!permission.isGranted && !permission.isLimited) {
        throw Exception('Storage permission not granted');
      }

      // Request permission for photo_manager
      final photoPermission = await PhotoManager.requestPermissionExtend();
      if (!photoPermission.isAuth) {
        throw Exception('Photo manager permission denied');
      }

      // Get all albums
      final albums = await PhotoManager.getAssetPathList(
        type: RequestType.image,
        onlyAll: true,
      );

      if (albums.isEmpty) {
        return [];
      }

      // Use the first album (all photos)
      final allPhotosAlbum = albums.first;

      // Get assets
      final assetCount = await allPhotosAlbum.assetCountAsync;
      final endIndex = limit != null
          ? (limit < assetCount ? limit : assetCount)
          : assetCount;

      final assets = await allPhotosAlbum.getAssetListRange(
        start: 0,
        end: endIndex,
      );

      // Convert assets to files
      final files = <File>[];
      for (var asset in assets) {
        try {
          final file = await asset.file;
          if (file != null) {
            files.add(file);
          }
        } catch (e) {
          print('Error getting file for asset: $e');
        }
      }

      return files;
    } catch (e) {
      throw Exception('Error getting photos: $e');
    }
  }
}
