# PowerPlatform-DLP-Reporter

![PowerShell](https://img.shields.io/badge/Built%20With-PowerShell-5391FE?logo=powershell&logoColor=white)
![Power Platform](https://img.shields.io/badge/Platform-Microsoft%20Power%20Platform-purple?logo=microsoftpowerapps&logoColor=white)
![License: MIT](https://img.shields.io/badge/License-MIT-green.svg)
![Admin Tool](https://img.shields.io/badge/Tool-Type%3A%20Admin-lightgrey)

🔍 **PowerPlatform-DLP-Reporter** is a PowerShell-based reporting tool designed for Microsoft Power Platform admins. It retrieves all Data Loss Prevention (DLP) policies in your tenant, including:  

✅ Business, Non-Business, and Blocked connectors  
✅ Blocked custom connectors (with API URLs)  
✅ Environments (IDs & Display Names)  
✅ Policy metadata (Created By, Modified Time, etc.)  

The results are exported to a clean, structured CSV file – making it easy to analyze and share.

---

## 🚀 Features
- 📋 Export all DLP policies in a tenant
- 🔒 Identify blocked custom connectors
- 🌐 Map environments with user-friendly names
- 📄 Save results in a CSV for easy reporting and governance audits

---

## ⚙️ Prerequisites
- Install Power Apps admin modules:  
```powershell
Install-Module -Name Microsoft.PowerApps.Administration.PowerShell
Install-Module -Name Microsoft.PowerApps.PowerShell
```
▶️ Usage
1. Connect to Power Platform:

```powershell
Add-PowerAppsAccount
```

2. Run the script:

```powershell
.\DlpPolicyReporter.ps1
```
3. Find the exported CSV at:

```makefile
C:\Users\<yourusername>\Downloads\Dlp_With_Custom.csv
```
📥 Output
The exported CSV includes:

| Policy Name | Business Connectors | Blocked Custom Connectors | Environments | Created By | Modified Time |
| ----------- | ------------------- | ------------------------- | ------------ | ---------- | ------------- |


💡 Why use this?
- ✅ Quickly audit DLP policies
- ✅ Track sensitive custom connectors
- ✅ Share reports with your governance team

👩‍💻 Author
✍️Developed with ❤️ by Vasavi Suggala

🌟 Like this Script?
If you found this script useful, please ⭐ star this repository to support future updates and help others discover it.
