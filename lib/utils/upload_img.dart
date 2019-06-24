import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:zefyr/zefyr.dart';
import 'dart:io';

class MyAppImageDelegate implements ZefyrImageDelegate<ImageSource> {

  @override
  Future<String> pickImage(ImageSource source) async {
    final file = await ImagePicker.pickImage(source: source);
    if (file == null) return null;
    // We simply return the absolute path to selected file.
    return file.uri.toString();
  }

  @override
  Widget buildImage(BuildContext context, String imageSource) {
    final file = new File.fromUri(Uri.parse(imageSource));
    /// Create standard [FileImage] provider. If [imageSource] was an HTTP link
    /// we could use [NetworkImage] instead.
    final image = new FileImage(file);
    return new Image(image: image);
  }
}