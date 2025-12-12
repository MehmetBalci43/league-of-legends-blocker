# League of Legends Blocker 🚫

A simple tool to block League of Legends servers by modifying your Windows hosts file. Perfect for those who want to break free from gaming addiction and reclaim their time.

![Platform](https://img.shields.io/badge/platform-Windows-blue)
![License](https://img.shields.io/badge/license-MIT-green)
![Language](https://img.shields.io/badge/language-Batch%20%7C%20PowerShell-yellow)

## 🎯 Features

- ✅ **Easy to Use** - Just right-click and run as administrator
- ✅ **Comprehensive Blocking** - Blocks all LoL game servers, login, chat, patch, and store servers
- ✅ **All Regions** - Covers EUW, EUNE, NA, TR, KR, BR, LAN, LAS, OCE, RU, JP
- ✅ **Bonus** - Also blocks Valorant and other Riot Games services
- ✅ **Automatic Backup** - Creates backup of hosts file before modification
- ✅ **DNS Cache Flush** - Automatically clears DNS cache for immediate effect
- ✅ **Reversible** - Easy unblock script included (but stay strong!)

## 📋 Contents

- **`block_lol.bat`** - Block LoL servers (EASY METHOD) ⭐
- **`unblock_lol.bat`** - Remove the block (UPDATED v1.1) ⭐
- **`check_status.ps1`** - Check if LoL is currently blocked (NEW!) 🔍
- `block_lol.ps1` - PowerShell version (alternative)
- `unblock_lol.ps1` - PowerShell unblock (alternative, UPDATED v1.1)
- `README.md` - This file
- `CHANGELOG.md` - Version history
- `BUG_REPORT.md` - Detailed bug fix documentation

## 🚀 Quick Start (Recommended)

### To Block League of Legends:

1. **Right-click** on `block_lol.bat`
2. Select **"Run as administrator"**
3. **Done!** 🎉

You can no longer connect to League of Legends!

### To Unblock (Not Recommended):

If you really want to play again (but don't! 💪):

1. **Right-click** on `unblock_lol.bat`
2. Select **"Run as administrator"**
3. Block removed (but you'll regret it!)

### To Check Block Status:

Want to verify if LoL is blocked? (No admin rights needed!)

1. **Double-click** on `check_status.ps1`
2. Or run: `powershell -ExecutionPolicy Bypass -File .\check_status.ps1`
3. See current block status instantly! 🔍

---

## 🔧 Alternative Method (PowerShell)

If batch files don't work for some reason, use PowerShell:

### To Block League of Legends:

1. **Open PowerShell as Administrator**
   - Press Windows key
   - Type "PowerShell"
   - Right-click "Windows PowerShell"
   - Select "Run as administrator"

2. **Set Execution Policy** (first time only)
   ```powershell
   Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
   ```

3. **Run the Script**
   ```powershell
   cd "C:\path\to\lolban"
   .\block_lol.ps1
   ```

### To Unblock:

```powershell
cd "C:\path\to\lolban"
.\unblock_lol.ps1
```

---

## 🔍 How It Works

This tool modifies the Windows `hosts` file to redirect all League of Legends servers to `127.0.0.1` (localhost). This means:

- ✅ Game launcher cannot connect
- ✅ In-game connection fails
- ✅ Update servers are unreachable
- ✅ All Riot Games services are blocked

### Blocked Servers Include:

- 🌍 All regional game servers (TR, EUW, EUNE, NA, KR, etc.)
- 🎮 Game servers
- 💬 Chat servers
- 📦 Patch/update servers
- 🔐 Login servers
- 🛒 Store servers
- 👁️ Spectator servers
- **BONUS:** Valorant and other Riot games!

## ⚠️ Important Notes

1. **Administrator Rights Required**: Scripts modify system files and must be run as administrator.

2. **Automatic Backup**: Your hosts file is automatically backed up before any changes.

3. **DNS Cache**: The script automatically flushes DNS cache, but restarting your computer is recommended.

4. **Persistent**: The block persists even after computer restart.

5. **Other Riot Games**: Valorant, TFT, and other Riot games will also be blocked.

## 🆘 Troubleshooting

### "Cannot run script" error:

Change PowerShell execution policy:

```powershell
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
```

### Still able to connect after blocking:

1. Restart your computer
2. Manually flush DNS cache:
   ```powershell
   ipconfig /flushdns
   ```
3. Disable VPN if you're using one

### Unblock not working (Can't connect even after unblock):

**UPDATED FIX (v1.1):** The unblock script has been improved to handle legacy blocks!

If you still can't connect after running `unblock_lol.bat`:

1. **Verify the unblock worked:**
   ```powershell
   notepad C:\Windows\System32\drivers\etc\hosts
   ```
   - Look for any lines containing `riot`, `lol`, `valorant`, or `riotgames`
   - All LoL-related entries should be removed

2. **Flush DNS cache:**
   ```powershell
   ipconfig /flushdns
   ```

3. **Restart Riot Client completely:**
   - Close Riot Client from system tray
   - Open Task Manager (Ctrl+Shift+Esc)
   - End all Riot-related processes
   - Restart the client

4. **Restart your computer** (most reliable solution)

**Note:** The improved unblock script now removes:
- ✅ Blocks with markers (`# === LoL Block Start ===`)
- ✅ Legacy blocks without markers
- ✅ Turkish comments (`# League of Legends Engellendi`)
- ✅ Orphan entries from previous versions

### Manual hosts file check:

```powershell
notepad C:\Windows\System32\drivers\etc\hosts
```

## 💪 Motivation

> "Stop playing games. Start living your dreams!"

Gaming addiction is real. This tool is one step to help you regain control. Remember:

- ⏰ Value your time
- 🎯 Focus on your goals
- 🌟 Succeed in real life
- 💼 Develop your career
- 👨‍👩‍👧‍👦 Spend time with loved ones

## 📊 What Gets Blocked

Over **50+ servers** including:

- Main Riot domains (`riot.com`, `riotgames.com`, `leagueoflegends.com`)
- Regional game servers (`prod.*.lol.riotgames.com`)
- API endpoints (`*.api.riotgames.com`)
- CDN servers (`l3cdn.riotgames.com`, `lol.dyn.riotcdn.net`)
- Authentication (`auth.riotgames.com`)
- Chat services (`chat.*.lol.riotgames.com`)
- Spectator services
- Store and static content
- Valorant domains

## 🤝 Contributing

Contributions are welcome! If you find additional servers that should be blocked or have improvements, please:

1. Fork the repository
2. Create a feature branch
3. Submit a pull request

## 📄 License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

## ⚖️ Disclaimer

This tool is for educational and personal use only. It helps users who voluntarily want to limit their access to League of Legends. The authors are not responsible for any misuse of this tool.

**Note:** This tool does not hack, modify, or interfere with the League of Legends game itself. It simply uses the standard Windows hosts file mechanism to block network connections.

## 📞 Support

If you're struggling with gaming addiction, please consider seeking professional help:
- Gaming Addiction Counseling Hotlines
- Psychological Support Centers
- Online Support Communities

---

**Stay strong! You can do this! 💪**

Made with ❤️ for those who want to reclaim their time.
