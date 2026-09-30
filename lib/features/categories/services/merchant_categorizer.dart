import '../data/category_taxonomy.g.dart';
import '../models/category.dart';
import 'category_resolver.dart';

/// Guesses a category from a merchant name using the keyword table in the
/// shared taxonomy. Keywords match whole words only, so "hp" in "shopping"
/// or "hpcl" no longer lands in Gas.
class MerchantCategorizer {
  MerchantCategorizer._();

  static final List<(RegExp, String)> _rules = [
    for (final (keywords, id) in merchantKeywordRules)
      (
        RegExp(
          r'(^|[^a-z0-9])(' +
              keywords.split('|').map(RegExp.escape).join('|') +
              r')($|[^a-z0-9])',
        ),
        id,
      ),
  ];

  /// Returns null when nothing matches.
  static CategorySelection? categorize(String merchant) {
    final m = merchant.toLowerCase().trim();
    if (m.isEmpty || m == 'unknown merchant') return null;
    for (final (pattern, id) in _rules) {
      if (pattern.hasMatch(m)) return CategoryResolver.selectionForSystemId(id);
    }
    return null;
  }
}
