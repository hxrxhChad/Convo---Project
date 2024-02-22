import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

Future<String?> uploadPhoto() async {
  final XFile? pickedImage =
      await ImagePicker().pickImage(source: ImageSource.gallery);
  if (pickedImage == null) return null;
  final Reference storageReference = FirebaseStorage.instance.ref().child(
      "photo/${DateTime.now()}.jpg"); // Replace "images" with your desired folder name.
  final UploadTask uploadTask =
      storageReference.putFile(File(pickedImage.path));
  final TaskSnapshot downloadUrl = (await uploadTask.whenComplete(() {}));
  final String url = await downloadUrl.ref.getDownloadURL();
  return url;
}
