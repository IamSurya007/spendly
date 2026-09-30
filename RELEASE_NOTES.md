# Fiscora Release Notes - Unreleased

> Requires the matching `spendly-service` release: deploy the backend first.

## 🚀 Features & Enhancements

### 🏷️ Categories Revamp (Fold-style)
- **New category list**: 18 parent categories (Food & Drinks, Groceries, Housing, Bills & Utilities, Transport, Shopping, Health, …, Income, Transfers) with subcategories, replacing the flat list of 49.
- **Icons and colours**: every category has a Phosphor icon on a tile tinted with its colour, shown on transactions, budgets and filters.
- **New category picker**: search, Expense / Income / Transfer tabs, a Recent row, parent grid that opens subcategory chips, and "+ New" to create one on the spot.
- **Custom categories**: Profile › Categories lets you add categories and subcategories, rename, recolour, hide and reorder them, and delete custom ones (their transactions move to a category you choose). Synced across devices and the web.
- **Budgets per category**: budget cards show the category icon and the top subcategories you spent on.
- **Filters**: pick a category, then narrow to a subcategory.
- **Smarter auto-categorisation** of SMS merchants (e.g. HPCL is now Fuel, not Gas). A merchant is only remembered when you pick its category yourself.
- Existing transactions, budgets and merchant rules are moved to the new categories automatically.

### 🤖 AI Assistant
- **Chat history**: conversations are saved. Use the clock icon to reopen, rename or delete past chats, and the new-chat icon to start fresh.
- **Follow-up questions** work ("and the second one?"): the assistant sees earlier messages in the chat.
- **Knows each loan and investment**: ask about a specific loan (due date, interest, days overdue) or investment (amount put in so far, maturity value, time left).
- **Cleaner chat layout**: answers use the full screen width, less padding, and tables scroll sideways instead of being squeezed.

## 🐛 Bug Fixes

### 📩 SMS Scan After Reinstall
- Scanning SMS after reinstalling no longer offers transactions that were already imported. The app now fully syncs from the server (including accounts) before scanning, with a "Syncing your saved transactions…" step.
- The same SMS captured live and later found by the inbox scan is now recognised as one transaction (previously saved twice).
- Transactions you deleted are no longer offered again by the scan.
- Re-imports no longer create sync conflicts.
- Long (multi-part) SMS are captured as one message.
- SMS transactions are matched to the right card or account by the last 4 digits first.
- Scanning needs only SMS permission; notification permission is optional.
- Read errors are shown instead of "No Transactions Detected", and the import message counts only new transactions.

### 🔄 Sync & Data
- Sync now fetches all pages of history, not only the first 200 records.
- Account balance changes are synced to the server.
- Android backup of app data is disabled, so a reinstall starts clean and restores from the server.
- Signing out uploads pending changes, warns if some could not be sent, then clears local data.
- Default budgets are no longer seeded on first launch (they were never shown and caused conflicts after reinstall).
- Auth tokens are no longer written to logs.

---

# Fiscora Release Notes - v1.0.3+4

## 🚀 Features & Enhancements

### 🌐 Server Migration
- Migrated sync server endpoint to `https://fiscora-api.duckdns.org`.
- Cleaned up REST sync entity mappings.

### 🔒 Auth & Profile
- **Sign Out Confirmation Dialog**: Tapping **Sign Out** on the Profile screen now displays a confirmation dialog with **Cancel** and **Sign Out** actions to prevent accidental logouts.
- **Session Guarding**: Optimized post-authentication setup to run strictly once per session.

### ⚡ Navigation & Visual Performance
- **Seamless Back Navigation (`PopScope`)**: Tapping back on sub-tabs smoothly returns to the Home tab. Tapping back on Home minimizes the app using `SystemNavigator.pop()`, eliminating root scaffold destruction and screen blinking.
- **Zero-Flicker Screen Transitions**: Updated Riverpod providers to use cached local values (`valueOrNull`) on Home, Accounts Carousel, and Budget screens, eliminating visual spinners, flashes, and layout jumps during navigation.
- **Smart Connectivity Throttling**: Updated `SyncEngine` connectivity listener to trigger sync cycles strictly on offline-to-online transitions.

### 📊 Budget Management
- **Category Budget Deletion**: Added budget deletion support inline on category budget cards and inside the category manager sheet.
- **"Set My First Budget" Action**: Fixed empty budget state action to directly open category selection bottom sheet.
