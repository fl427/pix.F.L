import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_flutter/main.dart';
import 'package:provider/provider.dart';

GlobalKey<_ImagePickerPageState> imagePickerKey = GlobalKey();

class ImagePickerPage extends StatefulWidget {
  const ImagePickerPage({Key? key}) : super(key: key);

  @override
  _ImagePickerPageState createState() => _ImagePickerPageState();
}

class _ImagePickerPageState extends State<ImagePickerPage> {
  final ImagePicker _picker = ImagePicker();
  // final counter = Provider.of<CountNotifier>(context);
  // 选择的照片
  // XFile? _image;
  List<XFile>? _imageFileList;

  // 相册选择，多选
  Future getImageFromStorage() async {
    try {
      // XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      final imageFileList = await _picker.pickMultiImage();
      context.read<ImageFileListNotifier>().setImageFileList(imageFileList);
      // _uploadImage(image);
      setState(() {
        // _image = image;
        _imageFileList = imageFileList;
      });
      print(_imageFileList);
      // print(_image);
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
  void initState() {
    super.initState();
    getImageFromStorage();
  }

  @override
  Widget build(BuildContext context) {
    List<Widget>? imageFileListRendered = _imageFileList?.map((_image) {
      return Container(
        child: Image.file(
          File(_image.path),
          fit: BoxFit.cover,
        ),
      );
    }).toList();
    return Scaffold(
      appBar: AppBar(title: Text('选择图片')),
      body: Container(
        child: ListView(
          children: <Widget>[
            ElevatedButton(
              onPressed: () {
                getImageFromStorage();
              },
              child: Text('本地图片'),
            ),
            ...?imageFileListRendered,
          ],
        ),
      ),
    );
  }
}
