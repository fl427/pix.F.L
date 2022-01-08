import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  // 选择的照片
  XFile? _image;

  // 相册选择
  Future _getImageFromStorage() async {
    print('执行到了这里???');
    print(_picker);
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      setState(() {
        _image = image;
        print('执行到了这里???????');
      });
      print('执行到了这里');
      print(_image);
    } catch (e) {
      print('sdfsdf');
      print(e);
    }

    print('执行到了这里???????');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('选择图片')),
      body: Container(
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                _getImageFromStorage();
              },
              child: Text('本地图片'),
            ),
            (_image != null && _image?.path != null)
                ? Image.file(
                    File(_image?.path ?? ''),
                    fit: BoxFit.cover,
                  )
                : Text("no image selected")
          ],
        ),
      ),
    );
  }
}
