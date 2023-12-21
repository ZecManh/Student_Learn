import 'dart:io';

import 'package:datn/database/firestore/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:image_picker/image_picker.dart';

class FirebaseStorageService {
  final FirebaseStorage _storage=FirebaseStorage.instance;
  get storage=>_storage;
  FirestoreService firestoreService = FirestoreService();

  Future uploadImage() async {
    ImagePicker imagePicker = ImagePicker();
    XFile? returnImage;
    File? selectedImage;
    Reference folderReference =
    storage.ref('user_images/${FirebaseAuth.instance.currentUser!.uid}/avatar/');
    returnImage = await imagePicker.pickImage(source: ImageSource.gallery);
    if (returnImage != null) {
      selectedImage = File(returnImage.path);
      try {
        Reference imageRef = folderReference.child(returnImage.name);
        await imageRef.putFile(selectedImage);
        String imageUrl = await imageRef.getDownloadURL();
        firestoreService.updateImageUrl(imageUrl);
        //store imageUrl to firestore
      } catch (error) {
        print(error);
      }
    }
  }
}