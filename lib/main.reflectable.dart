// This file has been generated by the reflectable package.
// https://github.com/dart-lang/reflectable.

import 'dart:core';
import 'package:dart_json_mapper/src/model/annotations.dart' as prefix0;
import 'package:datn/screen/face_recognition/emotion_response.dart' as prefix1;

// ignore_for_file: camel_case_types
// ignore_for_file: implementation_imports
// ignore_for_file: prefer_adjacent_string_concatenation
// ignore_for_file: prefer_collection_literals
// ignore_for_file: unnecessary_const

// ignore:unused_import
import 'package:reflectable/mirrors.dart' as m;
// ignore:unused_import
import 'package:reflectable/src/reflectable_builder_based.dart' as r;
// ignore:unused_import
import 'package:reflectable/reflectable.dart' as r show Reflectable;

final _data = <r.Reflectable, r.ReflectorData>{
  const prefix0.JsonSerializable(): r.ReflectorData(
      <m.TypeMirror>[
        r.NonGenericClassMirrorImpl(
            r'EmotionResponse',
            r'.EmotionResponse',
            134217735,
            0,
            const prefix0.JsonSerializable(),
            const <int>[0, 5],
            const <int>[6, 7, 8, 9, 10, 3, 4],
            const <int>[],
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix1.EmotionResponse() : null},
            -1,
            0,
            const <int>[],
            const <Object>[
              prefix0.jsonSerializable,
              const prefix0.Json(
                  valueDecorators: prefix1.EmotionResponse.valueDecorators,
                  ignoreNullMembers: true)
            ],
            null),
        r.NonGenericClassMirrorImpl(
            r'Data',
            r'.Data',
            134217735,
            1,
            const prefix0.JsonSerializable(),
            const <int>[1, 2, 15],
            const <int>[6, 7, 8, 9, 10, 11, 12, 13, 14],
            const <int>[],
            -1,
            {},
            {},
            {r'': (bool b) => () => b ? prefix1.Data() : null},
            -1,
            1,
            const <int>[],
            const <Object>[prefix0.jsonSerializable],
            null)
      ],
      <m.DeclarationMirror>[
        r.VariableMirrorImpl(
            r'data',
            84017157,
            0,
            const prefix0.JsonSerializable(),
            -1,
            2,
            3,
            const <int>[1],
            const []),
        r.VariableMirrorImpl(
            r'score',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4, const <int>[], const []),
        r.VariableMirrorImpl(
            r'label',
            67239941,
            1,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5, const <int>[], const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 0, 3),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 0, 4),
        r.MethodMirrorImpl(r'', 64, 0, -1, 0, 0, const <int>[], const <int>[],
            const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'==', 2097154, -1, -1, 6, 6, const <int>[],
            const <int>[1], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'toString', 2097154, -1, -1, 7, 7, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(
            r'noSuchMethod',
            524290,
            -1,
            -1,
            -1,
            -1,
            const <int>[],
            const <int>[2],
            const prefix0.JsonSerializable(),
            const []),
        r.MethodMirrorImpl(r'hashCode', 2097155, -1, -1, 8, 8, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.MethodMirrorImpl(r'runtimeType', 2097155, -1, -1, 9, 9, const <int>[],
            const <int>[], const prefix0.JsonSerializable(), const []),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 1, 11),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 1, 12),
        r.ImplicitGetterMirrorImpl(const prefix0.JsonSerializable(), 2, 13),
        r.ImplicitSetterMirrorImpl(const prefix0.JsonSerializable(), 2, 14),
        r.MethodMirrorImpl(r'', 64, 1, -1, 1, 1, const <int>[], const <int>[],
            const prefix0.JsonSerializable(), const [])
      ],
      <m.ParameterMirror>[
        r.ParameterMirrorImpl(
            r'_data',
            84017254,
            4,
            const prefix0.JsonSerializable(),
            -1,
            2,
            3,
            const <int>[1],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'other',
            134348806,
            6,
            const prefix0.JsonSerializable(),
            -1,
            10,
            10,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'invocation',
            134348806,
            8,
            const prefix0.JsonSerializable(),
            -1,
            11,
            11,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_score',
            67240038,
            12,
            const prefix0.JsonSerializable(),
            -1,
            4,
            4,
            const <int>[],
            const [],
            null,
            null),
        r.ParameterMirrorImpl(
            r'_label',
            67240038,
            14,
            const prefix0.JsonSerializable(),
            -1,
            5,
            5,
            const <int>[],
            const [],
            null,
            null)
      ],
      <Type>[
        prefix1.EmotionResponse,
        prefix1.Data,
        const m.TypeValue<List<prefix1.Data>>().type,
        List,
        double,
        String,
        bool,
        String,
        int,
        Type,
        Object,
        Invocation
      ],
      2,
      {
        r'==': (dynamic instance) => (x) => instance == x,
        r'toString': (dynamic instance) => instance.toString,
        r'noSuchMethod': (dynamic instance) => instance.noSuchMethod,
        r'hashCode': (dynamic instance) => instance.hashCode,
        r'runtimeType': (dynamic instance) => instance.runtimeType,
        r'data': (dynamic instance) => instance.data,
        r'score': (dynamic instance) => instance.score,
        r'label': (dynamic instance) => instance.label
      },
      {
        r'data=': (dynamic instance, value) => instance.data = value,
        r'score=': (dynamic instance, value) => instance.score = value,
        r'label=': (dynamic instance, value) => instance.label = value
      },
      null,
      [])
};

final _memberSymbolMap = null;

void initializeReflectable() {
  r.data = _data;
  r.memberSymbolMap = _memberSymbolMap;
}