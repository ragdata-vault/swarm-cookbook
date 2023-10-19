# Docker Local Dev Stack

## Root Certificate Authority for Windows & WSL2

The TLS setup for WSL2 is not as straight-forward as some others may have you believe, but it doesn't need to be a nightmare for you either.  Follow these steps to get your certificates working in both Windows and WSL2 Linux:

### Create Your Own Root CA with `mkcert`

In a PowerShell terminal window:

```shell
Set-ExecutionPolicy Bypass -Scope Process -Force
[System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072
iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
```

Then, in a Powershell terminal with Administrative privileges:

```shell
choco install -y mkcert
mkcert -install
```

... and follow the prompts to install the certificate authority for Windows.

Then, still in your Administrative Powershell, enter this code snippet to set WSL2 to use the certificate authority installed on Windows.  You'll likely need to reboot your computer to see this work properly.

```shell
$env:CAROOT="$(mkcert -CAROOT)"
setx CAROOT $env:CAROOT
If ($Env:WSLENV -notlike "*CAROOT/up:*") { $env:WSLENV="CAROOT/up:$env:WSLENV"; setx WSLENV $Env:WSLENV }
```

To make sure it's working, open a WSL2 Linux terminal window and type the following:

```shell
echo $CAROOT
```

Which should return something like `/mnt/c/Users/<user>/AppData/Local/mkcert`.  

If so, in your WSL2 Linux terminal window, finish the process with:

```shell
mkcert -install
```

> Firefox Trusted CA on Windows
> 
> The above process doesn't go quite far enough for Firefox though.  You need to add the root CA to Firefox yourself:
> 
> * Run `mkcert -install` and then `mkcert -CAROOT` to return the folder used for the newly-created root CA
> * Open Firfox preferences (`about:preferences#privacy`)
> * Enter 'certificates' into the search box at the top of the page
> * Click _View Certificates_
> * Select the _Authorities_ tab
> * Click _Import_
> * Navigate to the folder containing your new root certificate authority
> * Select the `rootCA.pem` file
> * Click to _Open_
> 
> And you should now see your CA listed under `mkcert development CA`