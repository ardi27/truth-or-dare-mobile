import 'dart:io';

import 'package:flutter_exif_rotation/flutter_exif_rotation.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:permission_handler/permission_handler.dart';

class ImagePickerHelper{
  static Future getImage({ImageSource source})async{
    await Permission.storage.request();
    final picker=ImagePicker();
    final pickedImage=await picker.getImage(source: source,imageQuality: 100);
    File rotatedImage =
    await FlutterExifRotation.rotateImage(path: pickedImage.path);
    File croppedImage = await ImageCropper.cropImage(
      sourcePath: rotatedImage.path,
      aspectRatioPresets: [
        CropAspectRatioPreset.square,
      ],
    );
    if(croppedImage!=null){
      return croppedImage.path;
    }else{
      return null;
    }
  }
}