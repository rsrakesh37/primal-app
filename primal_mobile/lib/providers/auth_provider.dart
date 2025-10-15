import 'package:flutter/foundation.dart';
import '../models/user.dart';
import '../services/api_service.dart';

class AuthProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  User? _user;
  bool _isLoading = false;
  bool _isAuthenticated = false;
  String? _errorMessage;

  // Getters
  User? get user => _user;
  bool get isLoading => _isLoading;
  bool get isAuthenticated => _isAuthenticated;
  String? get errorMessage => _errorMessage;

  // Initialize the provider
  Future<void> initialize() async {
    _setLoading(true);
    await _apiService.initialize();
    _isAuthenticated = await _apiService.isAuthenticated();
    if (_isAuthenticated) {
      _user = await _apiService.getCurrentUser();
    }
    _setLoading(false);
  }

  // Register new user
  Future<bool> register(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final authResponse = await _apiService.register(email, password);
      _user = authResponse.user;
      _isAuthenticated = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Login user
  Future<bool> login(String email, String password) async {
    _setLoading(true);
    _clearError();
    
    try {
      final authResponse = await _apiService.login(email, password);
      _user = authResponse.user;
      _isAuthenticated = true;
      _setLoading(false);
      return true;
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
      return false;
    }
  }

  // Logout user
  Future<void> logout() async {
    _setLoading(true);
    await _apiService.logout();
    _user = null;
    _isAuthenticated = false;
    _clearError();
    _setLoading(false);
  }

  // Private methods
  void _setLoading(bool loading) {
    _isLoading = loading;
    notifyListeners();
  }

  void _setError(String error) {
    _errorMessage = error.replaceAll('ApiException: ', '');
    notifyListeners();
  }

  void _clearError() {
    _errorMessage = null;
    notifyListeners();
  }

  void clearError() {
    _clearError();
  }
}