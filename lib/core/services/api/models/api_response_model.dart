import '../services/api_services.dart';

/// Generic model for all API responses following the backend pattern:
/// ```json
/// {
///   "success": true,
///   "message": "...",
///   "data": { ... } // or [ ... ]
/// }
/// ```
class ApiResponseModel<T> {
  final bool isSuccess;
  final String? message;
  final T? data;
  final int? statusCode;

  const ApiResponseModel({
    this.isSuccess = true,
    this.message,
    this.data,
    this.statusCode,
  });

  /// Factory to parse from raw JSON map (e.g. decoded response body)
  factory ApiResponseModel.fromJson(
    Map<String, dynamic> json, {
    T Function(dynamic data)? fromJson,
    int? statusCode,
  }) {
    final bool success = json['success'] == true;
    final String? message = json['message']?.toString();
    final dynamic rawData = json['data'];

    T? parsedData;
    if (rawData != null) {
      if (fromJson != null) {
        try {
          parsedData = fromJson(rawData);
        } catch (e) {
          parsedData = null;
        }
      } else if (rawData is T) {
        parsedData = rawData;
      }
    }

    return ApiResponseModel<T>(
      isSuccess: success,
      message: message,
      data: parsedData,
      statusCode: statusCode,
    );
  }

  /// Factory to parse from [ApiResponse]
  factory ApiResponseModel.fromApiResponse(
    ApiResponse response, {
    T Function(dynamic data)? fromJson,
  }) {
    T? parsedData;
    if (response.data != null) {
      if (fromJson != null) {
        try {
          parsedData = fromJson(response.data);
        } catch (e) {
          parsedData = null;
        }
      } else if (response.data is T) {
        parsedData = response.data as T;
      }
    }

    return ApiResponseModel<T>(
      isSuccess: response.isSuccess,
      message: response.message,
      data: parsedData,
      statusCode: response.statusCode,
    );
  }

  /// Helper factory for parsing a list of items: `ApiResponseModel<List<R>>`
  static ApiResponseModel<List<R>> fromList<R>(
    Map<String, dynamic> json, {
    required R Function(Map<String, dynamic> item) itemFromJson,
    int? statusCode,
  }) {
    final bool success = json['success'] == true;
    final String? message = json['message']?.toString();
    final dynamic rawData = json['data'];

    List<R>? items;
    if (rawData is List) {
      try {
        items = rawData
            .whereType<Map<String, dynamic>>()
            .map(itemFromJson)
            .toList();
      } catch (_) {
        items = null;
      }
    }

    return ApiResponseModel<List<R>>(
      isSuccess: success,
      message: message,
      data: items,
      statusCode: statusCode,
    );
  }

  @override
  String toString() =>
      'ApiResponseModel(statusCode: $statusCode, isSuccess: $isSuccess, '
      'message: $message, data: $data)';
}