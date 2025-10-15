import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import '../models/user.dart';
import '../models/balance.dart';

class ApiService {
  static const String baseUrl = 'https://primal-balance.co.uk/app/api';
  static const FlutterSecureStorage _storage = FlutterSecureStorage();
  
  // Storage keys
  static const String _tokenKey = 'auth_token';
  static const String _userKey = 'user_data';

  // Headers
  Map<String, String> get _headers => {
    'Content-Type': 'application/json',
    'Accept': 'application/json',
  };

  Map<String, String> get _authHeaders => {
    ..._headers,
    'Authorization': 'Bearer $_cachedToken',
  };

  String? _cachedToken;

  // Initialize service and load cached token
  Future<void> initialize() async {
    _cachedToken = await _storage.read(key: _tokenKey);
  }

  // Authentication methods
  Future<AuthResponse> register(String email, String password) async {
    final request = RegisterRequest(email: email, password: password);
    
    final response = await http.post(
      Uri.parse('$baseUrl/register'),
      headers: _headers,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 201) {
      final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
      await _saveAuthData(authResponse);
      return authResponse;
    } else {
      final error = jsonDecode(response.body);
      throw ApiException(error['message'] ?? 'Registration failed', response.statusCode);
    }
  }

  Future<AuthResponse> login(String email, String password) async {
    final request = LoginRequest(email: email, password: password);
    
    final response = await http.post(
      Uri.parse('$baseUrl/login'),
      headers: _headers,
      body: jsonEncode(request.toJson()),
    );

    if (response.statusCode == 200) {
      final authResponse = AuthResponse.fromJson(jsonDecode(response.body));
      await _saveAuthData(authResponse);
      return authResponse;
    } else {
      final error = jsonDecode(response.body);
      throw ApiException(error['message'] ?? 'Login failed', response.statusCode);
    }
  }

  Future<void> logout() async {
    await _storage.delete(key: _tokenKey);
    await _storage.delete(key: _userKey);
    _cachedToken = null;
  }

  // Balance methods
  Future<BalanceResponse> getBalance() async {
    if (_cachedToken == null) {
      throw ApiException('Not authenticated', 401);
    }

    final response = await http.get(
      Uri.parse('$baseUrl/balance'),
      headers: _authHeaders,
    );

    if (response.statusCode == 200) {
      return BalanceResponse.fromJson(jsonDecode(response.body));
    } else if (response.statusCode == 401) {
      await logout();
      throw ApiException('Session expired', 401);
    } else {
      final error = jsonDecode(response.body);
      throw ApiException(error['message'] ?? 'Failed to get balance', response.statusCode);
    }
  }

  // Health check
  Future<bool> healthCheck() async {
    try {
      final response = await http.get(
        Uri.parse('$baseUrl/health'),
        headers: _headers,
      );
      return response.statusCode == 200;
    } catch (e) {
      return false;
    }
  }

  // Authentication state
  Future<bool> isAuthenticated() async {
    _cachedToken ??= await _storage.read(key: _tokenKey);
    return _cachedToken != null;
  }

  Future<User?> getCurrentUser() async {
    final userData = await _storage.read(key: _userKey);
    if (userData != null) {
      return User.fromJson(jsonDecode(userData));
    }
    return null;
  }

  // Private methods
  Future<void> _saveAuthData(AuthResponse authResponse) async {
    _cachedToken = authResponse.token;
    await _storage.write(key: _tokenKey, value: authResponse.token);
    await _storage.write(key: _userKey, value: jsonEncode(authResponse.user.toJson()));
  }
}

class ApiException implements Exception {
  final String message;
  final int statusCode;

  ApiException(this.message, this.statusCode);

  @override
  String toString() => 'ApiException: $message (Status: $statusCode)';
}