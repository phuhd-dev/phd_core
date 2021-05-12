import 'package:json_annotation/json_annotation.dart';

class DateTimeConverter implements JsonConverter<DateTime, String> {
  const DateTimeConverter();

  @override
  DateTime fromJson(String json) {
    if (json == null || json.isEmpty) {
      return null;
    }
    if (json.contains(".") && json[json.length - 2] == '.') {
      json = json.substring(0, json.length - 1);
    }
    return DateTime.parse(json);
  }

  @override
  String toJson(DateTime json) => json?.toIso8601String();
}

class BooleanConverter implements JsonConverter<bool, int> {
  const BooleanConverter();

  @override
  bool fromJson(dynamic json) {
    if (json is bool)
      return json;
    else if (json is int)
      return json == 0 || json == null ? false : true;
    else
      return false;
  }

  @override
  int toJson(bool object) {
    return object == true ? 1 : 0;
  }
}
