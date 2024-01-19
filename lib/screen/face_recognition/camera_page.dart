import 'dart:io';

import 'package:camera/camera.dart';
import 'package:datn/database/emotion-recognition/ai_face.service.dart';
import 'package:datn/database/firestore/firestore_service.dart';
import 'package:datn/screen/authenticate/choose_type.dart';
import 'package:datn/screen/face_recognition/emotion_response.dart';
import 'package:datn/screen/learner/dash_board_learner.dart';
import 'package:datn/screen/tutor/dash_board_tutor.dart';
import 'package:flutter/material.dart';
import 'package:google_ml_kit/google_ml_kit.dart';
import 'package:lottie/lottie.dart';

import '../../database/auth/firebase_auth_service.dart';
import '../../model/face_recognition/user.dart';
import '../widget/common_widgets.dart';
import 'ml_service.dart';

List<CameraDescription>? cameras;

class FaceScanScreen extends StatefulWidget {
  final User? user;
  final String? username;
  final UserType? userType;
  final bool? checkEmotion;

  const FaceScanScreen(
      {super.key, this.user, this.username, this.userType, this.checkEmotion});

  @override
  FaceScanScreenState createState() => FaceScanScreenState();
}

class FaceScanScreenState extends State<FaceScanScreen> {
  FirebaseAuthService firebaseAuthService = FirebaseAuthService();
  TextEditingController controller = TextEditingController();
  late CameraController _cameraController;
  bool flash = false;
  bool isControllerInitialized = false;
  late FaceDetector _faceDetector;
  final MLService _mlService = MLService();
  List<Face> facesDetected = [];

  Future initializeCamera() async {
    await _cameraController.initialize();
    isControllerInitialized = true;
    _cameraController.setFlashMode(FlashMode.off);
    setState(() {});
  }

  InputImageRotation rotationIntToImageRotation(int rotation) {
    switch (rotation) {
      case 90:
        return InputImageRotation.Rotation_90deg;
      case 180:
        return InputImageRotation.Rotation_180deg;
      case 270:
        return InputImageRotation.Rotation_270deg;
      default:
        return InputImageRotation.Rotation_0deg;
    }
  }

  Future<void> detectFacesFromImage(CameraImage image) async {
    InputImageData firebaseImageMetadata = InputImageData(
      imageRotation: rotationIntToImageRotation(
          _cameraController.description.sensorOrientation),
      inputImageFormat: InputImageFormat.BGRA8888,
      size: Size(image.width.toDouble(), image.height.toDouble()),
      planeData: image.planes.map(
        (Plane plane) {
          return InputImagePlaneMetadata(
            bytesPerRow: plane.bytesPerRow,
            height: plane.height,
            width: plane.width,
          );
        },
      ).toList(),
    );

    InputImage firebaseVisionImage = InputImage.fromBytes(
      bytes: image.planes[0].bytes,
      inputImageData: firebaseImageMetadata,
    );
    var result = await _faceDetector.processImage(firebaseVisionImage);
    if (result.isNotEmpty) {
      facesDetected = result;
    }
  }

  Future<void> _predictFacesFromImage({required CameraImage image}) async {
    await detectFacesFromImage(image);
    if (facesDetected.isNotEmpty) {
      User? user = await _mlService.predict(
          image,
          facesDetected[0],
          widget.user != null,
          widget.user != null ? widget.user!.name! : controller.text);
      if (widget.user == null) {
        // register case
        Navigator.pop(context);
        print("User registered successfully");
      } else {
        // login case
        if (user == null) {
          Navigator.pop(context);
          print("Unknown User");
        } else {
          await loginFace(user.name, widget.userType);
        }
      }
    }
    if (mounted) setState(() {});
    await takePicture();
  }

  Future loginFace(email, userType) async {
    final userLogin = await FirestoreService().getUserByEmail(email);

    // user =
    bool isLoginOK = await firebaseAuthService.signInWithEmailAndPassword(
        email, userLogin.password ?? '');
    if (isLoginOK == true) {
      SnackBar snackBar = const SnackBar(content: Text('Đăng nhập thành công'));
      FirestoreService().updateLastLogin();
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      if (userType == UserType.learner) {
        Navigator.of(context).pushAndRemoveUntil(
          MaterialPageRoute(builder: (context) {
            return const DashBoardLearner();
          }),
          (route) => false,
        );
      } else {
        Navigator.of(context).pushAndRemoveUntil(
            MaterialPageRoute(builder: (context) {
          return const DashBoardTutor();
        }), (route) => false);
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Đăng nhập không thành công'),
        ),
      );
    }
  }

  Future<void> takePicture() async {
    if (facesDetected.isNotEmpty) {
      await _cameraController.stopImageStream();
      XFile xFile = await _cameraController.takePicture();
      xFile = XFile(xFile.path);

      if (widget.checkEmotion ?? false) {
        EmotionResponse? emotionResponse =
            await AiFaceService.emotion(file: File(xFile.path));
        showPopupEmotion(context, emotionResponse ?? EmotionResponse());
        _cameraController.setFlashMode(FlashMode.off);
      }
    } else {
      showDialog(
          context: context,
          builder: (context) =>
              const AlertDialog(content: Text('No face detected!')));
    }
  }

  void showPopupEmotion(
      BuildContext context, EmotionResponse emotionResponse) async {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Trạng thái của cảm xúc của bạn'),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                  'Bình thường: ${getNumberEmotion(emotionResponse, 'neutral')}'),
              Text('Vui vẻ: ${getNumberEmotion(emotionResponse, 'happy')}'),
              Text('Sợ hãi: ${getNumberEmotion(emotionResponse, 'fear')}'),
              Text('Buồn: ${getNumberEmotion(emotionResponse, 'sad')}'),
              Text('Bất ngờ: ${getNumberEmotion(emotionResponse, 'happy')}'),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text('Ok'),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
        ],
      ), // user must tap button!
      barrierDismissible: false,
    );
  }

  String getNumberEmotion(EmotionResponse emotionResponse, String type) {
    return emotionResponse.data
            ?.firstWhere((e) => e.label == type)
            .score
            .toString() ??
        "";
  }

  @override
  void initState() {
    controller = TextEditingController(text: widget.username ?? '');
    _cameraController = CameraController(cameras![1], ResolutionPreset.high);
    initializeCamera();
    _faceDetector = GoogleMlKit.vision.faceDetector(
      const FaceDetectorOptions(
        mode: FaceDetectorMode.accurate,
      ),
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScopeNode currentFocus = FocusScope.of(context);

        if (!currentFocus.hasPrimaryFocus) {
          currentFocus.unfocus();
        }
      },
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            SizedBox(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height,
                child: isControllerInitialized
                    ? CameraPreview(_cameraController)
                    : null),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 100),
                      child: Lottie.asset("assets/loading.json",
                          width: MediaQuery.of(context).size.width * 0.7),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 2.0),
                        child: CWidgets.customExtendedButton(
                            text: "Capture",
                            context: context,
                            isClickable: true,
                            onTap: () {
                              bool canProcess = false;
                              _cameraController
                                  .startImageStream((CameraImage image) async {
                                if (canProcess) return;
                                canProcess = true;
                                _predictFacesFromImage(image: image)
                                    .then((value) {
                                  canProcess = false;
                                });
                                return null;
                              });
                            }),
                      ),
                      IconButton(
                          icon: Icon(
                            flash ? Icons.flash_on : Icons.flash_off,
                            color: Colors.white,
                            size: 28,
                          ),
                          onPressed: () {
                            setState(() {
                              flash = !flash;
                            });
                            flash
                                ? _cameraController
                                    .setFlashMode(FlashMode.torch)
                                : _cameraController.setFlashMode(FlashMode.off);
                          }),
                    ],
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
