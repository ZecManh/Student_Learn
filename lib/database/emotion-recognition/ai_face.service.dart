import 'dart:convert';
import 'dart:ffi';
import 'dart:io';

import 'package:datn/screen/face_recognition/emotion_response.dart';
import 'package:dio/dio.dart';

import '../../utils/pretty_json_mixin.dart';


class AiFaceService {
  static Future<EmotionResponse?> emotion({ required File file}) async {
    var headers = {
      'Content-Type': 'image/jpeg',
      'Authorization': 'Bearer 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'
    };
    var data = await file.readAsBytes();

    var dio = Dio();
    var response = await dio.request(
      'https://api-inference.huggingface.co/models/dima806/facial_emotions_image_detection',
      options: Options(
        method: 'POST',
        headers: headers,
      ),
      data: data,
    );
    if (response.statusCode == 200) {
      print(json.encode(response.data));
      final value = EmotionResponse.fromJson(response.data);
      return value;
    }
    else {
      print(response.statusMessage);
    }
  }
}
