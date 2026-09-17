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
