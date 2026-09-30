import 'package:flutter_test/flutter_test.dart';
import 'package:fiscora/features/categories/data/category_taxonomy.g.dart';
import 'package:fiscora/features/categories/models/category.dart';
import 'package:fiscora/features/categories/services/category_registry.dart';
import 'package:fiscora/features/categories/services/category_resolver.dart';
import 'package:fiscora/features/categories/services/merchant_categorizer.dart';

void main() {
  // The 49 names the app offered before the revamp, plus values that were
  // written without being in the list.
  const oldNames = [
    'Rent', 'Electricity', 'Water Bill', 'Gas', 'Internet', 'Maintenance',
    'Groceries', 'Restaurants', 'Food Delivery', 'Coffee & Snacks',
    'Fuel', 'Auto / Cab', 'Public Transport', 'Vehicle EMI', 'Parking', 'Flight',
    'CC Bill', 'Loan EMI', 'Insurance', 'Investment', 'RD / SIP', 'Tax',
    'Doctor', 'Medicines', 'Gym / Fitness', 'Lab Tests',
    'Clothing', 'Electronics', 'Home Decor', 'Personal Care',
    'OTT / Subscriptions', 'Movies', 'Gaming', 'Events / Concerts',
    'Family', 'Friends', 'Gifts', 'Donations', 'Marriage / Events',
    'Courses', 'Books', 'Tuition',
    'Office Expenses', 'Chitti / Savings Group', 'Splitwise', 'Cash Withdrawal', 'Travel', 'Pets', 'Other',
    'Spends', '', 'Uncategorized', 'PG Rent', 'CC 1 Bill', 'Dad',
  ];

  group('legacy category mapping', () {
    test('every old name maps to an existing category', () {
      for (final name in oldNames) {
        expect(legacyCategoryMap.containsKey(name.toLowerCase()), isTrue, reason: name);
        final sel = CategoryResolver.fromLegacyName(name);
        final parent = CategoryResolver.systemById[sel.categoryId];
        expect(parent, isNotNull, reason: name);
        expect(parent!.parentId, isNull, reason: '$name parent must be top-level');
        if (sel.hasSub) {
          expect(CategoryResolver.systemById[sel.subcategoryId]?.parentId, sel.categoryId, reason: name);
        }
      }
    });

    test('is case-insensitive', () {
      expect(CategoryResolver.fromLegacyName('restaurants'), const CategorySelection('food', 'food.restaurants'));
    });

    test('credits in the catch-all go to Income', () {
      expect(CategoryResolver.fromLegacyName('Other', isCredit: true).categoryId, defaultCreditCategoryId);
      expect(CategoryResolver.fromLegacyName('', isCredit: true).categoryId, defaultCreditCategoryId);
      expect(CategoryResolver.fromLegacyName('Other').categoryId, defaultDebitCategoryId);
    });

    test('unknown names fall back to the default', () {
      expect(CategoryResolver.fromLegacyName('Something new').categoryId, defaultDebitCategoryId);
    });

    test('new ids and names resolve to themselves', () {
      expect(CategoryResolver.fromLegacyName('food.delivery'), const CategorySelection('food', 'food.delivery'));
      expect(CategoryResolver.fromLegacyName('Food & Drinks'), const CategorySelection('food'));
    });
  });

  group('MerchantCategorizer', () {
    CategorySelection? cat(String m) => MerchantCategorizer.categorize(m);

    test('known merchants', () {
      expect(cat('Swiggy')?.subcategoryId, 'food.delivery');
      expect(cat('Blinkit')?.subcategoryId, 'groceries.quick');
      expect(cat('Uber India')?.subcategoryId, 'transport.cab');
      expect(cat('Netflix')?.subcategoryId, 'entertainment.subscriptions');
    });

    test('HPCL is fuel, not gas; "hp" inside a word matches nothing', () {
      expect(cat('HPCL Petrol Pump')?.subcategoryId, 'transport.fuel');
      expect(cat('HP Gas Agency')?.subcategoryId, 'bills.gas');
      expect(cat('Shopping Mall'), isNull);
    });

    test('unknown merchant returns null', () {
      expect(cat('Unknown Merchant'), isNull);
      expect(cat('Ramesh Kumar'), isNull);
    });
  });

  group('CategoryRegistry', () {
    test('overrides rename a system category but keep its place', () {
      final registry = CategoryRegistry([
        CategoryResolver.systemById['food']!.copyWith(name: 'Eating Out', isHidden: false),
      ]);
      expect(registry.byId('food')!.name, 'Eating Out');
      expect(registry.byId('food')!.parentId, isNull);
      expect(registry.label('food', 'food.cafe'), 'Eating Out › Coffee & Snacks');
    });

    test('custom subcategory appears under its parent', () {
      const custom = Category(
        id: 'u1', name: 'Tiffin', iconKey: 'bowl', color: 0xFFF97316,
        kind: CategoryKind.expense, parentId: 'food', sortOrder: 50,
      );
      final registry = CategoryRegistry([custom]);
      expect(registry.childrenOf('food').map((c) => c.id), contains('u1'));
      expect(registry.label('food', 'u1'), 'Food & Drinks › Tiffin');
    });

    test('hidden categories are not offered but still resolve', () {
      final registry = CategoryRegistry([
        CategoryResolver.systemById['work']!.copyWith(isHidden: true),
      ]);
      expect(registry.parents().map((c) => c.id), isNot(contains('work')));
      expect(registry.byId('work'), isNotNull);
    });

    test('a sub that does not belong to the parent is ignored', () {
      expect(CategoryRegistry.systemOnly.label('food', 'transport.fuel'), 'Food & Drinks');
    });

    test('unknown ids fall back to the default', () {
      expect(CategoryRegistry.systemOnly.resolve('gone', '').parent.id, defaultDebitCategoryId);
      expect(CategoryRegistry.systemOnly.resolve('gone', '', isCredit: true).parent.id, defaultCreditCategoryId);
    });
  });
}
