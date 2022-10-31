class HttpResponse {
  final bool status;
  final String? body;
  final Map<String, List>? errors;
  final String? message;
  final int? statusCode;
  final String? token;
  final user;

  HttpResponse(this.status, this.body, this.errors, this.message, this.statusCode, this.token, this.user);

  factory HttpResponse.fromJson(Map<String, dynamic> json) {
    return HttpResponse(
      json['status'],
      json['body'],
      json['errors'] != null ? Map<String, List>.from(json['errors']) : null,
      json['message'],
      json['statusCode'],
      json['token'],
      json['user'],
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'body': body,
    'errors': errors,
    'message': message,
    'statusCode': statusCode,
    'token': token,
  };
}