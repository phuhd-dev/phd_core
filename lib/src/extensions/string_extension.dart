import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/utilities.dart';
import '../constants.dart';

extension StringExtension on String? {
  static RegExp _replaceArgRegex = RegExp(r'{}');

  bool get isNullOrEmpty => this?.isEmpty ?? true;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNullOrWhiteSpace => this.isNullOrEmpty || (this?.trim() ?? '').isEmpty;

  String? get titleCase => this == null ? null : StringUtils(this).titleCase;

  String? get markFormat => this == null ? null : '${Constants.mark}$this'.trim();

  String? get markStarFormat => this == null ? null : '${Constants.markStar} $this'.trim();

  String? get plusFormat => this == null ? null : '${Constants.plus} $this'.trim();

  String? get mulFormat => this == null ? null : '${Constants.mul}$this'.trim();

  String? get colonFormat => this == null ? null : '${this}${Constants.colon}'.trim();

  Color? get toColorFromHex {
    if (this == null) return null;

    final _length = this?.length ?? 0;
    final buffer = StringBuffer();
    if (_length == 6 || _length == 7) buffer.write('ff');
    buffer.write(this?.replaceFirst('#', ''));

    final colorInt = int.tryParse(buffer.toString(), radix: 16);
    if (colorInt == null) return null;

    return Color(colorInt);
  }

  String? get unSign {
    if (this == null) return null;

    var result = this ?? '';
    if (result is String) {
      for (int i = 0; i < _vietnamese.length; i++) {
        result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
      }
    }
    return result;
  }

  String? get unSignLower => this.unSign?.toUpperCase();

  String? hyphenFormat(String str) => this == null ? null : '$this ${Constants.hyphen} $str'.trim();

  String? closureFormat(String str) => this == null ? null : '$this ($str)'.trim();

  String? underlineFormat(String str) => this == null ? null : '${this}${Constants.underline}$str'.trim();

  int? toInt({int defaultValue = 0}) => this == null ? null : (int.tryParse('$this') ?? defaultValue);

  double? toDouble({double defaultValue = 0.0}) => this == null ? null : (double.tryParse('$this') ?? defaultValue);

  bool? toBool() => this == null ? null : (this?.trim().toLowerCase() == 'true' || this?.trim().toLowerCase() == '1');

  String? arguments(List<dynamic> args) {
    if (args.isEmpty || this == null) return this;

    var res = this ?? '';
    args.forEach((value) => res = res.replaceFirst(_replaceArgRegex, '$value'));
    return res;
  }
}

const String _vietnamese = 'aAeEoOuUiIdDyY';
final List<RegExp> _vietnameseRegex = <RegExp>[
  RegExp(r'à|á|ạ|ả|ã|â|ầ|ấ|ậ|ẩ|ẫ|ă|ằ|ắ|ặ|ẳ|ẵ'),
  RegExp(r'À|Á|Ạ|Ả|Ã|Â|Ầ|Ấ|Ậ|Ẩ|Ẫ|Ă|Ằ|Ắ|Ặ|Ẳ|Ẵ'),
  RegExp(r'è|é|ẹ|ẻ|ẽ|ê|ề|ế|ệ|ể|ễ'),
  RegExp(r'È|É|Ẹ|Ẻ|Ẽ|Ê|Ề|Ế|Ệ|Ể|Ễ'),
  RegExp(r'ò|ó|ọ|ỏ|õ|ô|ồ|ố|ộ|ổ|ỗ|ơ|ờ|ớ|ợ|ở|ỡ'),
  RegExp(r'Ò|Ó|Ọ|Ỏ|Õ|Ô|Ồ|Ố|Ộ|Ổ|Ỗ|Ơ|Ờ|Ớ|Ợ|Ở|Ỡ'),
  RegExp(r'ù|ú|ụ|ủ|ũ|ư|ừ|ứ|ự|ử|ữ'),
  RegExp(r'Ù|Ú|Ụ|Ủ|Ũ|Ư|Ừ|Ứ|Ự|Ử|Ữ'),
  RegExp(r'ì|í|ị|ỉ|ĩ'),
  RegExp(r'Ì|Í|Ị|Ỉ|Ĩ'),
  RegExp(r'đ'),
  RegExp(r'Đ'),
  RegExp(r'ỳ|ý|ỵ|ỷ|ỹ'),
  RegExp(r'Ỳ|Ý|Ỵ|Ỷ|Ỹ')
];

class StringUtils {
  static const TAG = 'StringExtension';
  final _words = <String>[];

  StringUtils([String? text]) {
    _words.addAll(_groupIntoWords(text));
  }

  List<String> _groupIntoWords([String? text]) {
    if (text.isNullOrWhiteSpace) return [];
    return text?.split(' ') ?? [];
  }

  String get titleCase => _getTitleCase(separator: ' ');

  String _getTitleCase({String separator: ''}) {
    if (this._words.isEmpty) return '';
    final words = this._words.map(_upperCaseFirstLetter).toList();
    return words.join(separator);
  }

  String _upperCaseFirstLetter(String word) {
    if (word.isNullOrEmpty) return word;
    var result = word;
    try {
      result = '${word.substring(0, 1).toUpperCase()}${word.substring(1).toLowerCase()}';
    } catch (e) {
      Log.e(word, tag: TAG);
      Log.e('${e.toString()}', tag: TAG);
    }
    return result;
  }
}
