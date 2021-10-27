class BaseResponse {
  bool status;
  String message;
  dynamic data;

  BaseResponse(this.status, this.message, this.data);
}
