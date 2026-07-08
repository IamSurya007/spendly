import '../repositories/i_expense_repository.dart';
import '../repositories/i_investment_repository.dart';
import '../repositories/i_loan_repository.dart';
import '../repositories/i_user_repository.dart';
import '../../features/expenses/models/expense_model.dart';
import '../../features/investments/models/investment_model.dart';
import '../../features/loans/models/loan_model.dart';

/// Seeds realistic data from the founder's sheet on first launch.
///
/// Depends on repository interfaces — completely backend-agnostic.
/// Works identically whether the backing store is Firestore, Isar, or a mock.
class SeedService {
  final IUserRepository _userRepo;
  final IExpenseRepository _expenseRepo;
  final ILoanRepository _loanRepo;
  final IInvestmentRepository _investmentRepo;

  const SeedService({
    required IUserRepository userRepo,
    required IExpenseRepository expenseRepo,
    required ILoanRepository loanRepo,
    required IInvestmentRepository investmentRepo,
  })  : _userRepo = userRepo,
        _expenseRepo = expenseRepo,
        _loanRepo = loanRepo,
        _investmentRepo = investmentRepo;

  Future<void> seedIfNeeded() async {
    final alreadySeeded = await _userRepo.isSeeded();
    if (alreadySeeded) return;

    await Future.wait([
      _seedExpenses(),
      _seedLoans(),
      _seedInvestments(),
      _seedBudget(),
    ]);

    await _userRepo.markSeeded();
  }

  Future<void> _seedExpenses() async {
    final now = DateTime.now();
    final expenses = [
      Expense(
        id: 'seed_exp_1',
        amount: 8460,
        category: 'PG Rent',
        note: 'July rent',
        date: DateTime(now.year, now.month, 1),
        method: 'upi',
        merchant: 'PG Owner',
        createdAt: DateTime(now.year, now.month, 1),
      ),
      Expense(
        id: 'seed_exp_2',
        amount: 1599,
        category: 'Spends',
        note: 'Groceries',
        date: DateTime(now.year, now.month, 3),
        method: 'upi',
        merchant: 'BigBasket',
        createdAt: DateTime(now.year, now.month, 3),
      ),
      Expense(
        id: 'seed_exp_3',
        amount: 4200,
        category: 'CC 1 Bill',
        note: 'HDFC CC bill',
        date: DateTime(now.year, now.month, 5),
        method: 'upi',
        merchant: 'HDFC Bank',
        createdAt: DateTime(now.year, now.month, 5),
      ),
      Expense(
        id: 'seed_exp_4',
        amount: 500,
        category: 'Friends',
        note: 'Dinner split',
        date: DateTime(now.year, now.month, 6),
        method: 'upi',
        merchant: 'Swiggy',
        createdAt: DateTime(now.year, now.month, 6),
      ),
      Expense(
        id: 'seed_exp_5',
        amount: 2000,
        category: 'Dad',
        note: 'Monthly transfer',
        date: DateTime(now.year, now.month, 2),
        method: 'upi',
        merchant: 'Dad',
        createdAt: DateTime(now.year, now.month, 2),
      ),
      Expense(
        id: 'seed_exp_6',
        amount: 350,
        category: 'Spends',
        note: 'Auto + metro',
        date: DateTime(now.year, now.month, 4),
        method: 'upi',
        merchant: 'Namma Metro',
        createdAt: DateTime(now.year, now.month, 4),
      ),
      Expense(
        id: 'seed_exp_7',
        amount: 1200,
        category: 'Splitwise',
        note: 'Weekend trip',
        date: DateTime(now.year, now.month, 7),
        method: 'upi',
        merchant: 'Splitwise',
        createdAt: DateTime(now.year, now.month, 7),
      ),
    ];

    for (final e in expenses) {
      await _expenseRepo.addExpense(e);
    }
  }

  Future<void> _seedLoans() async {
    final now = DateTime.now();
    final loans = [
      // You owe (taken)
      Loan(
        id: 'seed_loan_taken_1',
        type: 'taken',
        name: 'Gold Loan 1',
        principal: 50000,
        total: 55000,
        repaymentDate: DateTime(now.year, now.month + 3, 15),
        status: 'active',
        notes: 'Manappuram',
        createdAt: DateTime(now.year, now.month - 6, 1),
      ),
      Loan(
        id: 'seed_loan_taken_2',
        type: 'taken',
        name: 'Gold Loan 2',
        principal: 30000,
        total: 33500,
        repaymentDate: DateTime(now.year, now.month + 1, 20),
        status: 'active',
        notes: 'Muthoot Finance',
        createdAt: DateTime(now.year, now.month - 4, 10),
      ),
      Loan(
        id: 'seed_loan_taken_3',
        type: 'taken',
        name: 'Society Loan',
        principal: 20000,
        total: 20000,
        repaymentDate: DateTime(now.year, now.month + 2, 1),
        status: 'active',
        notes: 'Housing society emergency fund',
        createdAt: DateTime(now.year, now.month - 2, 5),
      ),
      Loan(
        id: 'seed_loan_taken_4',
        type: 'taken',
        name: 'Srinidhi Loan',
        principal: 15000,
        total: 15000,
        repaymentDate: DateTime(now.year, now.month - 1, 30),
        status: 'overdue',
        notes: '',
        createdAt: DateTime(now.year, now.month - 3, 15),
      ),
      Loan(
        id: 'seed_loan_taken_5',
        type: 'taken',
        name: 'Raghu',
        principal: 10000,
        total: 10000,
        repaymentDate: DateTime(now.year, now.month + 4, 1),
        status: 'active',
        notes: 'Personal loan from colleague',
        createdAt: DateTime(now.year, now.month - 1, 20),
      ),
      // They owe you (given)
      Loan(
        id: 'seed_loan_given_1',
        type: 'given',
        name: 'Narasimha',
        principal: 83850,
        total: 83850,
        repaymentDate: DateTime(now.year, now.month + 2, 10),
        status: 'active',
        notes: 'Family loan',
        createdAt: DateTime(now.year - 1, now.month, 1),
      ),
      Loan(
        id: 'seed_loan_given_2',
        type: 'given',
        name: 'Shareef',
        principal: 25000,
        total: 25000,
        repaymentDate: DateTime(now.year, now.month + 1, 5),
        status: 'active',
        notes: '',
        createdAt: DateTime(now.year, now.month - 5, 10),
      ),
      Loan(
        id: 'seed_loan_given_3',
        type: 'given',
        name: 'Subba Rao',
        principal: 40000,
        total: 40000,
        repaymentDate: DateTime(now.year, now.month + 3, 20),
        status: 'active',
        notes: 'Business help',
        createdAt: DateTime(now.year, now.month - 8, 1),
      ),
      Loan(
        id: 'seed_loan_given_4',
        type: 'given',
        name: 'Lakshmi',
        principal: 12000,
        total: 12000,
        repaymentDate: DateTime(now.year, now.month - 2, 15),
        status: 'overdue',
        notes: '',
        createdAt: DateTime(now.year - 1, 10, 1),
      ),
      Loan(
        id: 'seed_loan_given_5',
        type: 'given',
        name: 'Brahmalu',
        principal: 8000,
        total: 8000,
        repaymentDate: DateTime(now.year, now.month + 1, 28),
        status: 'active',
        notes: '',
        createdAt: DateTime(now.year, now.month - 3, 5),
      ),
      Loan(
        id: 'seed_loan_given_6',
        type: 'given',
        name: 'Neelima',
        principal: 5000,
        total: 5000,
        repaymentDate: DateTime(now.year, now.month - 1, 1),
        status: 'paid',
        notes: 'Returned on time',
        createdAt: DateTime(now.year, now.month - 4, 1),
      ),
    ];

    for (final l in loans) {
      await _loanRepo.addLoan(l);
    }
  }

  Future<void> _seedInvestments() async {
    final now = DateTime.now();
    final investments = [
      Investment(
        id: 'seed_inv_1',
        type: 'RD',
        name: 'SBI RD - Emergency Fund',
        monthlyAmount: 5000,
        principal: 30000,
        maturityAmount: 33750,
        durationMonths: 12,
        startDate: DateTime(now.year - 1, now.month, 1),
        maturityDate:
            DateTime(now.year, now.month, 1).add(const Duration(days: 30)),
        institution: 'State Bank of India',
      ),
      Investment(
        id: 'seed_inv_2',
        type: 'RD',
        name: 'Post Office RD',
        monthlyAmount: 3000,
        principal: 9000,
        maturityAmount: 22860,
        durationMonths: 60,
        startDate: DateTime(now.year, now.month - 3, 10),
        maturityDate: DateTime(now.year + 4, now.month + 9, 10),
        institution: 'India Post',
      ),
    ];

    for (final inv in investments) {
      await _investmentRepo.addInvestment(inv);
    }
  }

  Future<void> _seedBudget() async {
    final now = DateTime.now();
    final month = '${now.year}-${now.month.toString().padLeft(2, '0')}';

    await _expenseRepo.setBudgetForMonth(month, {
      'PG Rent': {'limit': 8500.0, 'spent': 8460.0},
      'Spends': {'limit': 5000.0, 'spent': 1949.0},
      'Dad': {'limit': 3000.0, 'spent': 2000.0},
      'Friends': {'limit': 2000.0, 'spent': 500.0},
      'CC 1 Bill': {'limit': 5000.0, 'spent': 4200.0},
      'CC 2 Bill': {'limit': 3000.0, 'spent': 0.0},
      'Splitwise': {'limit': 2000.0, 'spent': 1200.0},
      'Loan': {'limit': 5000.0, 'spent': 0.0},
      'Office Chitti': {'limit': 1000.0, 'spent': 0.0},
      'RD': {'limit': 8000.0, 'spent': 0.0},
      'Other': {'limit': 2000.0, 'spent': 0.0},
    });
  }
}
