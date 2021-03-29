class KeyValue<T> {
  final String key;
  final T value;

  const KeyValue(this.key, this.value);

  factory KeyValue.fromMapEntry(MapEntry<String, T> mapEntry) => KeyValue(mapEntry.key, mapEntry.value);

  @override
  String toString() => "{ '$key': $value }";

  @override
  bool operator ==(Object other) {
    return other is KeyValue && other.key == key;
  }

  @override
  int get hashCode => key.hashCode;
}
