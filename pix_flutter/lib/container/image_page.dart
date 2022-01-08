// 子页面
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:pix_flutter/common/provider/image_list_provider.dart';
import 'package:provider/src/provider.dart';

// 图片瀑布流
class ImagePage extends StatefulWidget {
  const ImagePage({Key? key, required this.content}) : super(key: key);
  final String content;
  @override
  _ImagePageState createState() => _ImagePageState();
}

// 页面缓存，不做这一步的话每次滑动页面就会重新加载
class _ImagePageState extends State<ImagePage> {
  @override
  Widget build(BuildContext context) {
    List<XFile>? imageFileList =
        context.watch<ImageFileListNotifier>().imageFileList;
    print(context.watch<ImageFileListNotifier>().imageFileList);
    List<Widget>? imageFileListRendered = imageFileList?.map((_image) {
      return Container(
        child: Image.file(
          File(_image.path),
          fit: BoxFit.cover,
        ),
      );
    }).toList();

    return ListView(
      children: [...?imageFileListRendered],
    );
  }

  @override
  void dispose() {
    print('page dispose');
    super.dispose();
  }
}
