# Changelog - Pickle XP Modernization

## Version 1.1.0 - Modernization Update (December 2025)

### 🎯 Major Features Added
- ✅ **QBox Framework Support** - Full integration with qbx_core
- ✅ **ox_lib Integration** - Modern notifications and optional context menu
- ✅ **oxmysql** - Replaced mysql-async with modern oxmysql
- ✅ **Auto SQL Injection** - Database tables now auto-create on resource start
- ✅ **ox_lib Context Menu** - Optional modern menu system (configurable)

### 🔧 Framework Support
- **QBox (qbx_core)** - NEW! Full support added
- **ESX (es_extended)** - Updated with ox_lib notifications
- **QB-Core (qb-core)** - Updated with ox_lib notifications  
- **Standalone** - Updated with ox_lib notifications

### 📦 Dependencies Updated
- Added: `oxmysql` (required)
- Added: `ox_lib` (required)
- Removed: `mysql-async` (deprecated)

### ⚙️ Configuration Changes
- Added `Config.Framework` - Manual framework selection or 'auto' detection
- Added `Config.UseOxLib` - Toggle between ox_lib context menu and original NUI

### 🔄 Code Improvements
- Migrated all MySQL queries from mysql-async to oxmysql
- Updated all notifications to support ox_lib
- Added automatic database table creation
- Added player disconnect cleanup to prevent memory leaks
- Fixed RegisterCommand missing third parameter
- Fixed DrawNotification parameter types
- Improved error handling

### 🆕 New Bridge Files
- `bridge/qbx/client.lua` - QBox client bridge
- `bridge/qbx/server.lua` - QBox server bridge

### 📝 Documentation
- Completely rewrote README.md with modern features
- Added EXAMPLES.md with comprehensive usage examples
- Added CHANGELOG.md to track changes

### 🐛 Bug Fixes
- Fixed SQL queries to use prepared statements
- Fixed potential race conditions in XP initialization
- Improved character encoding (utf8mb4)

### 🎨 UI Improvements
- ox_lib context menu option for modern look
- Progress indicators with color coding (green/yellow/red)
- Maintained backward compatibility with original NUI

### ⚡ Performance
- Async/await pattern for all database operations
- Memory cleanup on player disconnect
- Optimized SQL queries with proper indexing

### 🔐 Security
- Prepared statements for all SQL queries
- Proper parameter validation
- Framework-specific identifier handling

---

## Version 1.0.4 - Original Release (Pickle Mods)
- Initial ESX & QB-Core support
- Basic XP system with categories
- NUI display interface
- mysql-async implementation

---

### Migration Guide (1.0.4 → 1.1.0)

#### Server.cfg Changes
```diff
- ensure mysql-async
+ ensure oxmysql
+ ensure ox_lib
  ensure pickle_xp
```

#### No Database Changes Required
The database structure remains the same. The script will automatically verify/create tables on startup.

#### Config.lua Updates
```lua
-- NEW: Add these to your config
Config.Framework = 'auto'  -- or 'esx', 'qb', 'qbx', 'standalone'
Config.UseOxLib = true     -- false to use original NUI
```

#### Existing Data
All existing player XP data will be preserved. No data migration needed.

---

### Credits
- **Original Author**: Pickle Mods
- **Modernization**: Community update for QBox and modern FiveM standards
- **Testing**: Tested on QBox, ESX Legacy, and QB-Core frameworks
