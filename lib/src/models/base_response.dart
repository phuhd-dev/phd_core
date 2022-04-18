abstract class BaseResponse<TData, TError> {
  int? statusCode;
  Map<String, List<String>>? headers;
  TData? data;
  TError? error;

  BaseResponse({this.statusCode, this.headers, this.data, this.error});

  bool get success => statusCode != null && (statusCode == 200 || statusCode == 201 || statusCode == 204);
}
