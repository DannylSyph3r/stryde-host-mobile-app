enum TransactionType { withdrawal, deposit }

class Transaction {
  final TransactionType transactionType;
  final String attachedAccountNumber;
  final double transactionAmount;
  final DateTime transactionDate;

  Transaction({
    required this.transactionType,
    required this.attachedAccountNumber,
    required this.transactionAmount,
    required this.transactionDate,
  });
}

List<Transaction> transactions = [
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***12345",
    transactionAmount: 85.00,
    transactionDate: DateTime.now().subtract(const Duration(minutes: 20)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***12345",
    transactionAmount: 190.00,
    transactionDate: DateTime.now().subtract(const Duration(minutes: 10)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***67890",
    transactionAmount: 60.00,
    transactionDate: DateTime.now().subtract(const Duration(minutes: 59)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***67890",
    transactionAmount: 120.00,
    transactionDate: DateTime.now().subtract(const Duration(minutes: 25)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***12345",
    transactionAmount: 75.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 1, minutes: 18)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***12345",
    transactionAmount: 150.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 1, minutes: 2)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***67890",
    transactionAmount: 30.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 1, minutes: 27)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***67890",
    transactionAmount: 100.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 1, minutes: 20)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***12345",
    transactionAmount: 100.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 1, minutes: 45)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***12345",
    transactionAmount: 50.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 1, minutes: 35)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***67890",
    transactionAmount: 50.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 2, minutes: 5)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***67890",
    transactionAmount: 400.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 2, minutes: 3)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***12345",
    transactionAmount: 25.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 2, minutes: 1)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***12345",
    transactionAmount: 300.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 2, minutes: 10)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***67890",
    transactionAmount: 75.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 3, minutes: 30)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***67890",
    transactionAmount: 500.00,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 3, minutes: 28)),
  ),
  Transaction(
    transactionType: TransactionType.withdrawal,
    attachedAccountNumber: "***12345",
    transactionAmount: 150.75,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 3, minutes: 45)),
  ),
  Transaction(
    transactionType: TransactionType.deposit,
    attachedAccountNumber: "***12345",
    transactionAmount: 200.50,
    transactionDate:
        DateTime.now().subtract(const Duration(days: 3, minutes: 42)),
  ),
];
