import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:http/http.dart' as http;

class AuthApi {
  AuthApi({required String baseUrl}) : baseUrl = _normalizeBaseUrl(baseUrl);

  final String baseUrl;

  static String _normalizeBaseUrl(String value) {
    var url = value.trim();
    if (!url.startsWith('http://') && !url.startsWith('https://')) {
      url = 'http://$url';
    }
    if (url.endsWith('/')) {
      url = url.substring(0, url.length - 1);
    }
    return url;
  }

  Future<Map<String, dynamic>> login({
    required String email,
    required String password,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/login');

    http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 12));
    } on TimeoutException {
      throw AuthApiException('Request timed out. Check backend connection.');
    } on SocketException {
      throw AuthApiException('Cannot reach server. Check API base URL.');
    } on http.ClientException catch (e) {
      throw AuthApiException('Network error: ${e.message}');
    }

    final Map<String, dynamic> body = _tryDecodeJson(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = body['error']?.toString() ??
      body['message']?.toString() ??
      'Login failed (status ${response.statusCode}).';
    final rawBody = response.body;
    throw AuthApiException(
      message,
      statusCode: response.statusCode,
      body: body,
      rawBody: rawBody.isEmpty ? null : rawBody,
    );
  }
  Future<Map<String, dynamic>> register({name, email, password}) async {
    //the base url changes depeding on the platform so it is a good practice to implement it this way
    final url = Uri.parse('$baseUrl/api/auth/register');

    http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'name': name,
              'email': email,
              'password': password,
            }),
          )
          .timeout(const Duration(seconds: 12));
          //usefull cases to debug the connection errors
    } on TimeoutException {
      throw AuthApiException('Request timed out. Check backend connection.');
    } on SocketException {
      throw AuthApiException('Cannot reach server. Check API base URL.');
    } on http.ClientException catch (e) {
      throw AuthApiException('Network error: ${e.message}');
    }

    final Map<String, dynamic> body = _tryDecodeJson(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = body['error']?.toString() ??
      body['message']?.toString() ??
      'Register failed (status ${response.statusCode}).';
    final rawBody = response.body;
    throw AuthApiException(
      message,
      statusCode: response.statusCode,
      body: body,
      rawBody: rawBody.isEmpty ? null : rawBody,
    );
  }

  Future<Map<String, dynamic>> sendResetOtp({required String email}) async {
    final url = Uri.parse('$baseUrl/api/auth/send-reset-otp');

    http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
            }),
          )
          .timeout(const Duration(seconds: 12));
    } on TimeoutException {
      throw AuthApiException('Request timed out. Check backend connection.');
    } on SocketException {
      throw AuthApiException('Cannot reach server. Check API base URL.');
    } on http.ClientException catch (e) {
      throw AuthApiException('Network error: ${e.message}');
    }

    final Map<String, dynamic> body = _tryDecodeJson(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = body['error']?.toString() ??
        body['message']?.toString() ??
        'Failed to send OTP (status ${response.statusCode}).';
    final rawBody = response.body;
    throw AuthApiException(
      message,
      statusCode: response.statusCode,
      body: body,
      rawBody: rawBody.isEmpty ? null : rawBody,
    );
  }

  Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String otp,
    required String password,
    required String passwordConfirmation,
  }) async {
    final url = Uri.parse('$baseUrl/api/auth/reset-password');

    http.Response response;
    try {
      response = await http
          .post(
            url,
            headers: const {
              'Content-Type': 'application/json',
              'Accept': 'application/json',
            },
            body: jsonEncode({
              'email': email,
              'otp': otp,
              'password': password,
              'password_confirmation': passwordConfirmation,
            }),
          )
          .timeout(const Duration(seconds: 12));
    } on TimeoutException {
      throw AuthApiException('Request timed out. Check backend connection.');
    } on SocketException {
      throw AuthApiException('Cannot reach server. Check API base URL.');
    } on http.ClientException catch (e) {
      throw AuthApiException('Network error: ${e.message}');
    }

    final Map<String, dynamic> body = _tryDecodeJson(response.body);

    if (response.statusCode >= 200 && response.statusCode < 300) {
      return body;
    }

    final message = body['error']?.toString() ??
        body['message']?.toString() ??
        'Password reset failed (status ${response.statusCode}).';
    final rawBody = response.body;
    throw AuthApiException(
      message,
      statusCode: response.statusCode,
      body: body,
      rawBody: rawBody.isEmpty ? null : rawBody,
    );
  }

  Map<String, dynamic> _tryDecodeJson(String payload) {
    try {
      final decoded = jsonDecode(payload);
      if (decoded is Map<String, dynamic>) {
        return decoded;
      }
    } catch (_) {}
    return <String, dynamic>{};
  }
}

class AuthApiException implements Exception {
  AuthApiException(this.message, {this.statusCode, this.body, this.rawBody});

  final String message;
  final int? statusCode;
  final Map<String, dynamic>? body;
  final String? rawBody;

  @override
  String toString() {
    if (rawBody != null && rawBody!.isNotEmpty) {
      return '$message\n$rawBody';
    }
    return message;
  }
}
