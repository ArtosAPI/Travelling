import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'package:travelling/firebase_cruds.dart';

class ProfileSettings extends ChangeNotifier {
  bool obscuredText = true;
  String _path = '';
  Uint8List? image;

  void setAvatarImage() async {
    // try {
    //   final emailName = FirebaseUser.ins.email.split('@');
    //   final ref = FirebaseStorage.instance
    //       .ref()
    //       .child('gs://travelling-25896.appspot.com/${emailName[0]}');

    //   ref.getData();
    // } catch (e) {
    //   print(e);
    // }
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

  void initialAvatarImage() async {
    try {
      final emailName = FirebaseUser.ins.email.split('@');
      print(emailName);
      final ref = FirebaseStorage.instance.ref().child('${emailName[0]}');
      print(ref.fullPath);

      image = await ref.getData();
    } catch (e) {
      print(e);
    }
    image = null;
  }

  void obscureText() {
    obscuredText = !obscuredText;
    notifyListeners();
  }
}
