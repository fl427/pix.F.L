// 全局状态
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

// 保存选中图片列表
class ImageFileListNotifier with ChangeNotifier {
  List<XFile>? imageFileList;

  void setImageFileList(List<XFile>? _imageFileList) {
    imageFileList = _imageFileList;
    notifyListeners();
  }
}
