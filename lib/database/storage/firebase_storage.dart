import 'dart:io';

import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  get storage=>_storage;

  Future uploadImage(String userId) async{
    ImagePicker imagePicker = ImagePicker();
    XFile? returnImage;
    File? selectedImage;

    Reference imageReference =
    storage.ref('user_images/$userId/avatar');

    returnImage = await imagePicker.pickImage(source: ImageSource.gallery);
    // if (returnImage != null) {
    //   setState(() {
    //     selectedImage = File(returnImage!.path);
    //     print('return image path $returnImage');
    //     print('selectedImage $selectedImage');
    //   });
    //   print('put image $selectedImage');
    //   imageReference.child(returnImage!.name).putFile(selectedImage!);
    // }
  }
}