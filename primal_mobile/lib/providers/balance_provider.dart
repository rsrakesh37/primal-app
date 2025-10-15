import 'package:flutter/foundation.dart';
import '../models/balance.dart';
import '../services/api_service.dart';

class BalanceProvider with ChangeNotifier {
  final ApiService _apiService = ApiService();
  
  BalanceResponse? _balanceData;
  bool _isLoading = false;
  String? _errorMessage;

  // Getters
  BalanceResponse? get balanceData => _balanceData;
  Balance? get balance => _balanceData?.balance;
  List<Transaction> get recentTransactions => _balanceData?.recentTransactions ?? [];
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  // Load balance data
  Future<void> loadBalance() async {
    _setLoading(true);
    _clearError();
    
    try {
      await _apiService.initialize();
      _balanceData = await _apiService.getBalance();
      _setLoading(false);
    } catch (e) {
      _setError(e.toString());
      _setLoading(false);
    }
  }

  // Refresh balance data
  Future<void> refreshBalance() async {
    await loadBalance();
  }

  // Clear data (for logout)
  void clearData() {
    _balanceData = null;
    _clearError();
    notifyListeners();
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