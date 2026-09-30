# Fiscora

Personal Finance Tracker — track expenses, loans, and investments. Android app (Flutter) with offline-first storage (Isar) that syncs to the `spendly-service` backend.

See [RELEASE_NOTES.md](RELEASE_NOTES.md) for what changed in each version.

## Development

```bash
flutter pub get
# Isar schemas (lib/core/sync/**.g.dart). JIT mode is required on Windows:
# isar_plus build hooks cannot be AOT-compiled by build_runner.
dart run build_runner build --force-jit
flutter analyze
flutter test
```

**Pinned dependency:** `isar_plus` / `isar_plus_flutter_libs` are pinned to exactly `1.2.6`. Newer releases ship only a Swift Package (no CocoaPods podspec) for iOS, which makes every `flutter pub get` fail on Windows with *"Plugin isar_plus_flutter_libs is only Swift Package Manager compatible"*. `pubspec.lock` is git-ignored, so an unpinned constraint silently upgrades.

## How key features work

### SMS import and duplicate detection
- Every SMS transaction has one stable id: `SmsDedup.key` (`lib/core/services/sms_dedup.dart`), a UUID v5 of sender + sent time (seconds) + full body. The inbox scan (`date_sent`) and live capture (`SmsReceiver.kt`, PDU `timestampMillis`, multipart SMS joined) produce the same id. It is used as the expense id, so the server deduplicates re-imports.
- `SmsImportService` is shared by the scan sheet and auto-capture. It checks the stable id, the id older builds used, and (for legacy rows only) a same-amount row within 3 minutes. Soft-deleted rows count, so a transaction you deleted is never offered again.
- Before scanning, `SyncEngine.syncNow()` pushes pending changes and pulls every entity completely (accounts first). After a reinstall the scan therefore sees everything already saved on the server.
- Android Auto Backup is disabled (`res/xml/*_rules.xml`): restoring a stale local database broke sync cursors. The server is the backup.

### Categories
- Two-level taxonomy (parent → subcategory) generated from `spendly-service/shared/categories.json` into `lib/features/categories/data/category_taxonomy.g.dart`. Do not edit the generated file; run `node shared/generate-categories.mjs` in `spendly-service`.
- Expenses store `categoryId` / `subcategoryId`. `category` / `subcategory` hold display names for older clients and the web.
- `CategoryRegistry` merges the system list with the user's custom categories and overrides (rename, recolour, hide, reorder). Those are stored in `CategoryCollection` and synced as the `category` entity.
- `MerchantCategorizer` guesses a category from the merchant (whole-word keywords). A merchant rule is only saved when the user picks a category.
- Budgets are keyed by parent category id, under month `all`.
- On startup, `migrateLegacyCategories()` assigns ids to records that only have an old category name.
- UI: `CategoryPickerSheet`, `CategoryIcon`, Profile › Categories (`ManageCategoriesScreen`).

### AI assistant chat
- Conversations are stored on the server. The chat screen keeps the current `conversationId`, so follow-up questions have context. The history sheet (clock icon) opens, renames and deletes past chats.
- Answers render as Markdown; tables scroll horizontally.
