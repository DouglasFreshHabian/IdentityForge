<p align="center">
  <img src="https://img.shields.io/badge/language-Bash-blue?logo=gnu-bash" alt="Language: Bash">
  <img src="https://img.shields.io/badge/license-MIT-green" alt="MIT License">
  <img src="https://img.shields.io/badge/status-Active-brightgreen" alt="Project Status">
</p>
<p align="center">
  <img src="https://github.com/DouglasFreshHabian/IdentityForge/blob/main/Graphics/Tux-Identity-Forge.png?raw=true" alt="My Image" width="400">
</p>

<h1 align="center">
👤 IdentityForge
	</h1>

## 🔧 What's Included

### 🎂 `birthdayGen.sh` — Random Birthday Generator

Generates 9 random birthdays with colorful output and vibrant ASCII art.

- 🌈 **Colorful output**: Uses ANSI escape codes for styled terminal output.
- 🖼 **ASCII banner**: Birthday-themed banner in random color.
- 📅 **Date logic**: Validates leap years and formats dates with suffixes (e.g., `23rd`, `4th`).
- 🎉 **Fun intro**: Blinking, colorful title line before output.

---

### 🆔 `identityGen.sh` — Fake Identity Generator

Creates fake user IDs using the `rig` tool and formats realistic U.S. phone numbers.

- 🧠 **Based on `rig`**: Pulls names and locations from the `rig` database.
- 📞 **Phone formatting**: Keeps area codes while randomizing valid 7-digit numbers.
- 📁 **Output options**:
  - Choose the number of identities via CLI or prompt.
  - Specify a custom output file.
- 🛡 **Safety features**:
  - Confirms before overwriting files.
  - Validates inputs.
  - Cleans up temporary files.

---

### 👤 `profileGen.sh` — Full Profile Generator

Combines IDs and birthdays into complete user profiles.

- 🧩 **Comprehensive profiles**: Combines names, addresses, phone numbers, and birthdays.
- 🎨 **Colorful terminal UI**: Uses bold text and multiple colors.
- 🖼 **ASCII banner**: Random color every run.
- 📁 **File handling**:
  - Saves profiles to a file.
  - Confirms before overwrite.
  - Uses and cleans up temporary files.

---

## ✅ Legitimate Use Cases

IdentityForge is designed for ethical and educational use. Examples include:

- 🧪 **Software Testing** – Populate databases and simulate user flows.
- 🛡 **Cybersecurity Training** – Test systems with realistic but safe data.
- 📊 **Marketing & UX** – Generate personas for research and simulations.
- 🧑‍🏫 **Education** – Use in teaching data science, privacy, or design.
- 🎮 **Gaming/Roleplay** – Create character backstories quickly.
- 🔍 **Pen Testing** – Use in social engineering test scenarios.

---

## ❌ What *Not* to Use This For

This project does **not** support or condone:

- Fraud or impersonation
- Online scams or phishing
- Evading bans or creating fake accounts for deceptive purposes

Always use responsibly and within the law.

---

## 🛠 Requirements

- Bash (tested on GNU Bash 5.x)
- `rig` (available via `apt install rig`)

---

## 📦 Installation

```bash
git clone https://github.com/DouglasFreshHabian/IdentityForge.git
cd IdentityForge
chmod +x *.sh
```
To Run Scripts:
```bash
./identityGen.sh
./birthdayGen.sh
./profileGen.sh
```

## 📄 License
This project is licensed under the [MIT License](https://github.com/DouglasFreshHabian/IdentityForge/blob/main/LICENSE)

## 🎯 Final Thoughts

Use this tool to responsibly test, simulate, and explore — and as always:

<h2 align="center"> 
  <a href="https://www.buymeacoffee.com/dfreshZ" target="_blank"><img src="https://cdn.buymeacoffee.com/buttons/v2/default-yellow.png" alt="Buy Me A Coffee" style="height: 60px !important;width: 217px !important;" ></a>

<p align="center">
  <a href="https://www.youtube.com/@DouglasHabian-tq5ck">Stay Fresh</a>, 
  <a href="https://github.com/DouglasFreshHabian/FreshPdfLibrary">Keep Learning!</a>
</p>

<!--
Add Example Spreadsheet containing 3 sample profiles...
https://docs.google.com/spreadsheets/d/1jvR93FUJ14Sa1jQx16wWeJUynOn8ZmuI-nxZLw3ESgE/edit?usp=sharing
-->
