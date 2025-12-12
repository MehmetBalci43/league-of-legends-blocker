# Changelog

All notable changes to this project will be documented in this file.

## [1.1.0] - 2025-12-13

### 🐛 Fixed
- **CRITICAL FIX:** Unblock scripts now properly remove ALL LoL-related entries from hosts file
- Fixed issue where legacy blocks without markers were not being removed
- Fixed issue where Turkish comments ("League of Legends Engellendi") were not being removed
- Fixed orphan entries from previous versions that prevented unblocking

### ✨ Improved
- Enhanced `unblock_lol.ps1` with comprehensive domain pattern matching
- Enhanced `unblock_lol.bat` with additional search patterns
- Added verbose logging to show what entries are being removed
- Improved detection of LoL-related domains (riot, riotgames, lol, valorant, riotcdn, etc.)

### 📝 Documentation
- Added troubleshooting section for unblock issues in README.md
- Added detailed explanation of what the improved unblock script removes
- Added verification steps for users to confirm unblock worked

### 🔍 Technical Details
**Previous Issue:**
- Block script used markers: `# === LoL Block Start ===` and `# === LoL Block End ===`
- Unblock script only removed entries between these markers
- Legacy blocks or manually added entries without markers were not removed
- This caused LoL to remain blocked even after running unblock script

**Solution:**
- Unblock script now scans entire hosts file for LoL-related patterns
- Removes entries based on domain matching, not just markers
- Handles Turkish and English comments
- Removes orphan entries from any source

## [1.0.0] - 2025-11-23

### 🎉 Initial Release
- Block League of Legends servers via hosts file modification
- Support for all regions (EUW, EUNE, TR, NA, KR, BR, LAN, LAS, OCE, RU, JP)
- Automatic hosts file backup
- Automatic DNS cache flushing
- Both Batch (.bat) and PowerShell (.ps1) versions
- Comprehensive server list (50+ servers)
- Bonus: Valorant blocking included
