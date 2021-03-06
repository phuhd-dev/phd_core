import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../utilities/utilities.dart';
import '../constants.dart';

extension StringExtension on String {
  static RegExp _replaceArgRegex = RegExp(r'{}');

  bool get isNullOrEmpty => this == null || this.isEmpty;

  bool get isNotNullOrEmpty => !isNullOrEmpty;

  bool get isNullOrWhiteSpace => this.isNullOrEmpty || this.trim().isEmpty;

  String get titleCase => StringUtils(this).titleCase;

  String get markFormat => '${Constants.mark}$this'.trim();

  String get markStarFormat => '${Constants.markStar} $this'.trim();

  String get plusFormat => '${Constants.plus} $this'.trim();

  String get mulFormat => '${Constants.mul}$this'.trim();

  String get colonFormat => '${this}${Constants.colon}'.trim();

  Color get toColorFromHex {
    final buffer = StringBuffer();
    if (length == 6 || length == 7) buffer.write('ff');
    buffer.write(replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  String get unSign {
    String result = this ?? '';
    if (result is String) {
      for (int i = 0; i < _vietnamese.length; i++) {
        result = result.replaceAll(_vietnameseRegex[i], _vietnamese[i]);
      }
    }
    return result;
  }

  String get unSignLower => this.unSign.toUpperCase();

  String hyphenFormat(String str) => '$this ${Constants.hyphen} $str'.trim();

  String closureFormat(String str) => '$this ($str)'.trim();

  String underlineFormat(String str) => '${this}${Constants.underline}$str'.trim();

  int toInt({int defaultValue = 0}) => int.tryParse(this) ?? defaultValue;

  double toDouble({double defaultValue = 0.0}) => double.tryParse(this) ?? defaultValue;

  bool toBool() => this.trim().toLowerCase() == 'true' || this.trim().toLowerCase() == '1';

  String arguments(List<dynamic> args) {
    if (args == null || args.isEmpty || this == null) return this;

    String res = this;

    args.forEach((value) => res = res.replaceFirst(_replaceArgRegex, '$value'));

    return res;
  }
}

const String _vietnamese = 'aAeEoOuUiIdDyY';
final List<RegExp> _vietnameseRegex = <RegExp>[
  RegExp(r'??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|???|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|???|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|??|??|???|???|???|???|???|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|??|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|??|??|???|???|???|???|???'),
  RegExp(r'??|??|???|???|??'),
  RegExp(r'??|??|???|???|??'),
  RegExp(r'??'),
  RegExp(r'??'),
  RegExp(r'???|??|???|???|???'),
  RegExp(r'???|??|???|???|???')
];

class StringUtils {
  static const TAG = 'StringExtension';
  List<String> _words;

  StringUtils(String text) {
    _words = _groupIntoWords(text);
  }

  List<String> _groupIntoWords(String text) {
    if (text.isNullOrWhiteSpace) return null;
    return text.split(' ');
  }

  String get titleCase => _getTitleCase(separator: ' ');

  String _getTitleCase({String separator: ''}) {
    if (this._words == null) return '';
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
      Log.e(e, tag: TAG);
    }
    return result;
  }
}
