# PowerPlatform-DLP-Reporter

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

