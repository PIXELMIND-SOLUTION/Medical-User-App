// ignore_for_file: avoid_print

import 'dart:io';
import 'package:image/image.dart' as img;

class ImageCropHelper {
  static Future<File?> cropImage({
    required File imageFile,
    required int x,
    required int y,
    required int width,
    required int height,
  }) async {
    try {
      // Read the image
      final bytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);
      
      if (originalImage == null) return null;

      // Crop the image
      img.Image croppedImage = img.copyCrop(
        originalImage,
        x: x,
        y: y,
        width: width,
        height: height,
      );

      // Save the cropped image
      final tempDir = Directory.systemTemp;
      final croppedFile = File('${tempDir.path}/cropped_${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage, quality: 85));
      
      return croppedFile;
    } catch (e) {
      print('Error cropping image: $e');
      return null;
    }
  }

  static Future<File?> cropImageToSquare(File imageFile) async {
    try {
      final bytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);
      
      if (originalImage == null) return null;

      // Get the smaller dimension to make a square
      int size = originalImage.width < originalImage.height 
          ? originalImage.width 
          : originalImage.height;

      // Calculate center crop coordinates
      int x = (originalImage.width - size) ~/ 2;
      int y = (originalImage.height - size) ~/ 2;

      // Crop to square
      img.Image croppedImage = img.copyCrop(
        originalImage,
        x: x,
        y: y,
        width: size,
        height: size,
      );

      // Save the cropped image
      final tempDir = Directory.systemTemp;
      final croppedFile = File('${tempDir.path}/cropped_square_${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage, quality: 85));
      
      return croppedFile;
    } catch (e) {
      print('Error cropping image: $e');
      return null;
    }
  }

  static Future<File?> cropImageWithAspectRatio({
    required File imageFile,
    required double aspectRatio, // width/height ratio
  }) async {
    try {
      final bytes = await imageFile.readAsBytes();
      img.Image? originalImage = img.decodeImage(bytes);
      
      if (originalImage == null) return null;

      int cropWidth, cropHeight;
      
      // Calculate crop dimensions based on aspect ratio
      if (originalImage.width / originalImage.height > aspectRatio) {
        // Image is wider than desired ratio
        cropHeight = originalImage.height;
        cropWidth = (cropHeight * aspectRatio).round();
      } else {
        // Image is taller than desired ratio
        cropWidth = originalImage.width;
        cropHeight = (cropWidth / aspectRatio).round();
      }

      // Center the crop
      int x = (originalImage.width - cropWidth) ~/ 2;
      int y = (originalImage.height - cropHeight) ~/ 2;

      img.Image croppedImage = img.copyCrop(
        originalImage,
        x: x,
        y: y,
        width: cropWidth,
        height: cropHeight,
      );

      final tempDir = Directory.systemTemp;
      final croppedFile = File('${tempDir.path}/cropped_aspect_${DateTime.now().millisecondsSinceEpoch}.jpg');
      
      await croppedFile.writeAsBytes(img.encodeJpg(croppedImage, quality: 85));
      
      return croppedFile;
    } catch (e) {
      print('Error cropping image: $e');
      return null;
    }
  }
}