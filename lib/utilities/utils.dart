import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

double getheightofDevice(context) {
  double h = MediaQuery.of(context).size.height;
  return h;
}

chooseImage(ImageSource imageSource) async {
  final ImagePicker _imagePicker = ImagePicker();
  XFile? image = await _imagePicker.pickImage(source: imageSource);
  print(image);
  if (image != null) {
    return image.readAsBytes();
  } else {
    print('No Image Is Selected');
    return null;
  }
}

void displaySnackBar(BuildContext context, String content) {
  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(content),
    ),
  );
}
