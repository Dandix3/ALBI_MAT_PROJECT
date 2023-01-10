class HttpResponse {
  final bool status;
  final data;
  final List<String>? errors;
  final String? message;
  final int? statusCode;

  HttpResponse(this.status, this.data, this.errors, this.message, this.statusCode);

  factory HttpResponse.fromJson(Map<String, dynamic> json, int? statusCode) {
    return HttpResponse(
      json['status'],
      json['data'] ?? null,
      json['errors'] != null ? List.from(json['errors']) : null, // todo: chyba z backendu při skenování kodu s více hrami
      json['message'],
      statusCode,
    );
  }

  Map<String, dynamic> toJson() => {
    'status': status,
    'data': data,
    'errors': errors,
    'message': message,
    'statusCode': statusCode,
  };
}