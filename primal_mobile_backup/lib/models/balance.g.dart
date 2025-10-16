// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'balance.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Balance _$BalanceFromJson(Map<String, dynamic> json) => Balance(
  total: (json['total'] as num).toDouble(),
  income: (json['income'] as num).toDouble(),
  expenses: (json['expenses'] as num).toDouble(),
  transactionsCount: (json['transactions_count'] as num).toInt(),
);

Map<String, dynamic> _$BalanceToJson(Balance instance) => <String, dynamic>{
  'total': instance.total,
  'income': instance.income,
  'expenses': instance.expenses,
  'transactions_count': instance.transactionsCount,
};

Transaction _$TransactionFromJson(Map<String, dynamic> json) => Transaction(
  id: (json['id'] as num).toInt(),
  userId: (json['user_id'] as num).toInt(),
  amount: (json['amount'] as num).toDouble(),
  type: json['type'] as String,
  description: json['description'] as String,
  createdAt: json['created_at'] as String,
);

Map<String, dynamic> _$TransactionToJson(Transaction instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'amount': instance.amount,
      'type': instance.type,
      'description': instance.description,
      'created_at': instance.createdAt,
    };

BalanceResponse _$BalanceResponseFromJson(Map<String, dynamic> json) =>
    BalanceResponse(
      balance: Balance.fromJson(json['balance'] as Map<String, dynamic>),
      recentTransactions: (json['recent_transactions'] as List<dynamic>)
          .map((e) => Transaction.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BalanceResponseToJson(BalanceResponse instance) =>
    <String, dynamic>{
      'balance': instance.balance,
      'recent_transactions': instance.recentTransactions,
    };
