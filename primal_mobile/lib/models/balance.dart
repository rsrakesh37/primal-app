import 'package:json_annotation/json_annotation.dart';

part 'balance.g.dart';

@JsonSerializable()
class Balance {
  final double total;
  final double income;
  final double expenses;
  @JsonKey(name: 'transactions_count')
  final int transactionsCount;

  Balance({
    required this.total,
    required this.income,
    required this.expenses,
    required this.transactionsCount,
  });

  factory Balance.fromJson(Map<String, dynamic> json) => _$BalanceFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceToJson(this);
}

@JsonSerializable()
class Transaction {
  final int id;
  @JsonKey(name: 'user_id')
  final int userId;
  final double amount;
  final String type;
  final String description;
  @JsonKey(name: 'created_at')
  final String createdAt;

  Transaction({
    required this.id,
    required this.userId,
    required this.amount,
    required this.type,
    required this.description,
    required this.createdAt,
  });

  factory Transaction.fromJson(Map<String, dynamic> json) => _$TransactionFromJson(json);
  Map<String, dynamic> toJson() => _$TransactionToJson(this);
}

@JsonSerializable()
class BalanceResponse {
  final Balance balance;
  @JsonKey(name: 'recent_transactions')
  final List<Transaction> recentTransactions;

  BalanceResponse({
    required this.balance,
    required this.recentTransactions,
  });

  factory BalanceResponse.fromJson(Map<String, dynamic> json) => _$BalanceResponseFromJson(json);
  Map<String, dynamic> toJson() => _$BalanceResponseToJson(this);
}