# Environment Setup

This guide walks through installing R, restoring the project's package environment, and configuring VS Code for this course.

---

## 1. Install R

We use **rig** (R Installation Manager) to install and manage R versions — the R equivalent of `pyenv` or `uv python install`.

### Windows (no admin rights required)

```powershell
# Install rig into your user profile
irm https://r-lib.github.io/rig/install.ps1 | iex
```

Open a **new terminal** after the install, then:

```powershell
rig system user-mode   # keep R in your user profile (no admin needed)
rig add release        # install latest R (currently 4.6.x)
rig add rtools         # install Rtools — needed for some packages
rig list               # confirm
R --version
```

> **Alternative via scoop:** add the r-bucket first:
> ```powershell
> scoop bucket add r-bucket https://github.com/cderv/r-bucket.git
> scoop install rig
> ```

### macOS

```bash
brew install --cask rig
rig add release
```

### Linux

See https://github.com/r-lib/rig for distro-specific instructions.

---

## 2. Clone the repo and restore packages

This project uses **renv** for reproducible package management — the R equivalent of a `venv` + lockfile. The `renv.lock` file pins every package version.

```powershell
git clone https://github.com/ex-man/GeneralInsurance_Class.git
cd GeneralInsurance_Class

# Check with your user which branch to use (e.g. Class2026)
git checkout <branch>

# Open R inside the project directory
R
```

Inside R, renv activates automatically (via `.Rprofile`). Restore all packages:

```r
renv::restore()
```

This installs all course packages into a project-local library (`renv/library/`) linked from renv's global cache — no packages are installed system-wide.

**Packages installed** (sourced from all 6 lessons):
`tidyverse`, `ChainLadder`, `xgboost`, `tidymodels`, `caret`, `statmod`, `tweedie`, `plotly`, `patchwork`, `broom`, `Ckmeans.1d.dp`, `reshape2`, `htmltools`

---

## 3. VS Code setup

Install the R extensions — VS Code will also prompt automatically via the `.vscode/extensions.json` in this repo:

- **R** by REditorSupport (`REditorSupport.r`)
- **R Debugger** by RDebugger (`RDebugger.r-debugger`)

Add these to your VS Code **User Settings** (`Ctrl+Shift+P` → "Open User Settings JSON"):

```json
{
  "r.plot.useHttpgd": true,
  "r.sessionWatcher": true,
  "r.bracketedPaste": true
}
```

**Optional — radian (better R terminal with syntax highlighting):**

```powershell
# If you use uv:
uv tool install radian
Get-Command radian        # note the path

# Or via pip:
pip install radian
```

Then add to VS Code settings:
```json
{
  "r.rterm.windows": "C:\\path\\to\\radian.exe",
  "r.bracketedPaste": true
}
```

With radian configured, use `Ctrl+Enter` to send lines to the R terminal — the same as RStudio's behaviour.

---

## 4. Corporate network workaround (Zurich / behind SSL inspection proxy)

R's bundled OpenSSL does not trust corporate CA certificates, so `install.packages()` and `renv::restore()` will fail with SSL errors on managed corporate machines.

**Fix:** add these two lines to your user-level `.Rprofile` (`~/.Rprofile`, create it if it doesn't exist):

```r
options(download.file.method = "wininet")
options(repos = c(CRAN = "https://packagemanager.posit.co/cran/latest"))
```

`wininet` tells R to use the Windows HTTP stack, which already trusts the corporate CA. Posit Public Package Manager is used as the CRAN mirror because it is typically reachable when the direct CRAN URL is not.

After saving `~/.Rprofile`, restart R and run `renv::restore()` again.

> **VS Code:** also add `"http.systemCertificates": true` to your VS Code user settings to fix extension marketplace installs on the same network.

---

## Quick-start summary

```powershell
# 1. Install rig + R (once per machine)
irm https://r-lib.github.io/rig/install.ps1 | iex   # new terminal after this
rig system user-mode && rig add release && rig add rtools

# 2. Clone and restore
git clone https://github.com/ex-man/GeneralInsurance_Class.git
cd GeneralInsurance_Class && git checkout <branch>   # ask your user
R -e "renv::restore()"
```
