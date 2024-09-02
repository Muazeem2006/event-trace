// ignore_for_file: depend_on_referenced_packages, avoid_print, unnecessary_nullable_for_final_variable_declarations

import 'dart:io';
import 'dart:developer'; 

import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart' as path;
import 'package:path_provider/path_provider.dart';

Future<void> takePicture(Function(File) setImage) async {
  final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);

  if (imageFile == null) {
    return;
  }

  final appDir = await getApplicationDocumentsDirectory();
  final fileName = path.basename(imageFile.path);
  final savedImage = File('${appDir.path}/$fileName');

  await savedImage.writeAsBytes(await imageFile.readAsBytes());

  setImage(savedImage);
}

Future<void> selectPicture(Function(File) setImage) async {
  final imageFile = await ImagePicker().pickImage(source: ImageSource.gallery);
  if (imageFile == null) {
    return;
  }
  final appDir = await getApplicationDocumentsDirectory();
  final fileName = path.basename(imageFile.path);
  final savedImage = File('${appDir.path}/$fileName');
  await savedImage.writeAsBytes(await imageFile.readAsBytes());

  setImage(savedImage);
}

Future<void> selectImages(Function(List<File>?) setImages) async {
  List<XFile>? imageFiles;
  final List<XFile>? selectedImages = await ImagePicker().pickMultiImage();

  if (selectedImages != null) {
    final appDir = await getApplicationDocumentsDirectory();
    for (final selectedImage in selectedImages) {
      try {
        final fileName = path.basename(selectedImage.path);
        final savedImage = File('${appDir.path}/$fileName');
        await savedImage.writeAsBytes(await selectedImage.readAsBytes());
        imageFiles ??= [];
        imageFiles.add(selectedImage);
      } catch (e) {
        log('Error saving image: $e');
      }
    }
    if (imageFiles != null) {
      setImages(imageFiles.map((e) => File(e.path)).toList());
    } else {
      setImages(null);
    }
  } else {
    setImages(null);
  }
}

Future<void> takeImages(Function(List<File>?) setImages) async {
  List<XFile>? imageFiles;
  final imageFile = await ImagePicker().pickImage(source: ImageSource.camera);
  if (imageFile == null) {
    setImages(null);
    return;
  }
  final appDir = await getApplicationDocumentsDirectory();
  final fileName = path.basename(imageFile.path);
  final savedImage = File('${appDir.path}/$fileName');
  await savedImage.writeAsBytes(await imageFile.readAsBytes());
  imageFiles ??= [];
  imageFiles.add(imageFile);
  setImages(imageFiles.map((e) => savedImage).toList());
}
