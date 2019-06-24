import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class PickImgSheet {
  PickImgSheet({
    Key key,
    this.context,
  });

  final BuildContext context;

  void show(Function callback) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext ctx) {
        return Column(
          children: <Widget>[
            ListTile(
              leading: Icon(Icons.photo_camera),
              title: Text("拍照"),
              onTap: () async {
                File imageFile = await ImagePicker.pickImage(source: ImageSource.camera);
                Navigator.pop(ctx);
                callback(imageFile);
              },
            ),
            ListTile(
              leading: Icon(Icons.photo_library),
              title: Text("从相册中选择"),
              onTap: () async {
                File imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
                Navigator.pop(ctx);
                callback(imageFile);
              },
            ),
          ],
        ); 
      }
    );
  }
}