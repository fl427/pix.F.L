import 'dart:io';
import 'package:dio/dio.dart';
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
    try {
      XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      _uploadImage(image);
      setState(() {
        _image = image;
      });
      print(_image);
    } catch (e) {
      print(e);
    }
  }

  Future _uploadImage(XFile? image) async {
    String path = image?.path ?? 'undefined_path';
    String name = path.substring(path.lastIndexOf("/") + 1, path.length);

    FormData formData = FormData.fromMap({
      'name': 'img',
      'file': await MultipartFile.fromFile(path, filename: name),
    });

    Dio dio = new Dio();
    try {
      Response<String> response =
          await dio.post<String>('/upload', data: formData);

      if (response.statusCode == 200) {
        print('上传成功');
      }
    } catch (e) {
      print('上传失败');
    }
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
