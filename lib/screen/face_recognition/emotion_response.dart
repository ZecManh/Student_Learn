class EmotionResponse {
  List<Emotion>? data;

  EmotionResponse({this.data});

  EmotionResponse.fromJson(List<dynamic> json) {
    data = <Emotion>[];
    for (var v in json) {
      data!.add(Emotion.fromJson(v));
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (this.data != null) {
      data['data'] = this.data!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Emotion {
  double? score;
  String? label;

  Emotion({this.score, this.label});

  Emotion.fromJson(Map<String, dynamic> json) {
    score = json['score'];
    label = json['label'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['score'] = score;
    data['label'] = label;
    return data;
  }
}
