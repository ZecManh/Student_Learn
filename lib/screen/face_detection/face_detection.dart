import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_ml_vision/firebase_ml_vision.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: FaceDetectionScreen(),
    );
  }
}

class FaceDetectionScreen extends StatefulWidget {
  @override
  _FaceDetectionScreenState createState() => _FaceDetectionScreenState();
}

class _FaceDetectionScreenState extends State<FaceDetectionScreen> {
  FirebaseVisionImage _image;
  FaceDetector _faceDetector;

  @override
  void initState() {
    super.initState();
    _faceDetector = FirebaseVision.instance.faceDetector(
      FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
        enableContours: true,
      ),
    );
  }

  @override
  void dispose() {
    _faceDetector.close();
    super.dispose();
  }

  Future<void> _detectFaces() async {
    // Replace 'path/to/your/image.jpg' with the path to your image file
    final imageFile = FirebaseVisionImage.fromFilePath('assets/path/to/your/image.jpg');
    final faces = await _faceDetector.processImage(imageFile);

    for (Face face in faces) {
      print('Bounding box: ${face.boundingBox}');
      // You can access other face information here, such as landmarks, head rotation, etc.
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Face Detection'),
      ),
      body: Center(
        child: ElevatedButton(
          onPressed: _detectFaces,
          child: Text('Detect Faces'),
        ),
      ),
    );
  }
}