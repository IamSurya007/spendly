import 'package:isar_plus/isar_plus.dart';
import 'package:path_provider/path_provider.dart';

import 'collections/account_collection.dart';
import 'collections/conflict_record.dart';
import 'collections/expense_collection.dart';
import 'collections/loan_collection.dart';
import 'collections/investment_collection.dart';
import 'collections/budget_collection.dart';
import 'collections/category_rule_collection.dart';
import 'collections/category_collection.dart';
import 'collections/user_profile_collection.dart';
import 'outbox_operation.dart';
import 'sync_state.dart';

class IsarDatabase {
  static IsarDatabase? _instance;
  late final Isar isar;

  IsarDatabase._(this.isar);

  static IsarDatabase get instance {
    if (_instance == null) {
      throw StateError('IsarDatabase has not been initialized. Call init() first.');
    }
    return _instance!;
  }

  static Future<void> init({String? directory, String name = 'fiscora'}) async {
    if (_instance != null) return;

    final schemas = [
      AccountCollectionSchema,
      ExpenseCollectionSchema,
      LoanCollectionSchema,
      InvestmentCollectionSchema,
      BudgetCollectionSchema,
      CategoryRuleCollectionSchema,
      CategoryCollectionSchema,
      OutboxOperationSchema,
      SyncStateSchema,
      ConflictRecordSchema,
      UserProfileCollectionSchema,
    ];

    final String path;
    if (directory != null) {
      path = directory;
    } else {
      final dir = await getApplicationDocumentsDirectory();
      path = dir.path;
    }

    final isarInstance = await Isar.open(
      schemas: schemas,
      directory: path,
      name: name,
    );

    _instance = IsarDatabase._(isarInstance);
  }

  /// Wipes all local data (used on sign-out so the next account on this
  /// device starts from a clean state and a full pull).
  static Future<void> clearAll() async {
    if (_instance == null) return;
    await _instance!.isar.writeAsync((isar) => isar.clear());
  }

  // Closes and clears the singleton, useful for testing teardown.
  static Future<void> close() async {
    if (_instance != null) {
      await _instance!.isar.close();
      _instance = null;
    }
  }
}
