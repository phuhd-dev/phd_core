abstract class BaseData {
  external T fromJson<T extends BaseData>(Map<String, dynamic> json);

  toEntity() {}

  toModel() {}
}
