# How to install Hyper-V on Windows 11 Home (& Windows 11 Pro if not already installed)

## Step 1 - Enable Hardware Virtualization in BIOS

Check user manual for your motherboard / BIOS for details on how to enable hardware virtualizaion on your gear.

## Step 2 - Enable Hyper-V in Windows 11 Home

1. Open a new notepad file (Press WIN+R, type 'notepad', click OK)


2. In your notepad file, copy and paste the following script:

```powershell
pushd "%~dp0"
dir /b %SystemRoot%\servicing\Packages\*Hyper-V*.mum >hyper-v.txt
for /f %%i in ('findstr /i . hyper-v.txt 2^>nul') do dism /online /norestart /add-package:"%SystemRoot%\servicing\Packages\%%i"
del hyper-v.txt
Dism /online /enable-feature /featurename:Microsoft-Hyper-V -All /LimitAccess /ALL
pause
```

3. Save your notepad file as **hyperv.bat** (somewhere like your documents folder so you can find it easily)


4. Right-click on your **hyperv.bat** file and select **Run as Administrator**.  Click **Yes** if prompted.


5. Reboot your PC


### If Hyper-V is still not available:

1. Press the **WIN** key and type **cmd**


2. Right-click on **Command Prompt** and select **Run as Administrator**


3. In the command prompt, type the following command:

```powershell
DISM /Online /Enable-Feature /All /FeatureName:Microsoft-Hyper-V
```

### Press the _WIN_ key and type _Hyper-V Manager_