import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelling/firebase/firebase_cruds.dart';
import 'package:http/http.dart' as http;

class AvatarImage extends ChangeNotifier {
  static String _path = '';
  static Uint8List? image;

  void setAvatarImage() async {
    try {
      final picker = ImagePicker();
      final chosenImage = await picker.pickImage(source: ImageSource.gallery);
      image = await chosenImage!.readAsBytes();
      _path = chosenImage.path;
      notifyListeners();

      final emailName = FirebaseUser.ins.email.split('@');
      final ref = FirebaseStorage.instance.ref().child(emailName[0]);
      ref.putFile(File(_path));
    } catch (e) {
      print(e);
    }
  }

  static Future initialAvatarImage() async {
    try {
      final emailName = FirebaseUser.ins.email.split('@');
      final ref = FirebaseStorage.instance.ref().child(emailName[0]);

      final url = await ref.getDownloadURL();
      final responce = await http.get(Uri.parse(url));
      image = responce.bodyBytes;
    } catch (e) {
      print(e);
    }
  }
}

class ProfilePassword extends ChangeNotifier {
  bool obscurePassword = true;

  void obscureText() {
    obscurePassword = !obscurePassword;
    notifyListeners();
  }
}
