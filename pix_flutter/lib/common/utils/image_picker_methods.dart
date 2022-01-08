import 'package:image_picker/image_picker.dart';

class ImagePickerMethods {
  final ImagePicker _picker = ImagePicker();

  // 相册选择，多选
  Future getImageFromStorage(Function setImageFileList) async {
    try {
      final imageFileList = await _picker.pickMultiImage();
      setImageFileList(imageFileList);
      print('hello2');
    } catch (e) {
      print(e);
    }
  }
}
