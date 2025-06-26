Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))

choco install python                                --force --yes --ignore-checksums --no-progress
choco install ojdkbuild8                            --force --yes --ignore-checksums --no-progress
choco install jre8                                  --force --yes --ignore-checksums --no-progress
choco install jdk8                                  --force --yes --ignore-checksums
choco install maven                                 --force --yes --ignore-checksums
choco install 7zip.install                          --force --yes --ignore-checksums
choco install foxitreader                           --force --yes --ignore-checksums
choco install flashplayerplugin                     --force --yes --ignore-checksums
choco install curl                                  --force --yes --ignore-checksums
choco install intellijidea-community                --force --yes --ignore-checksums
choco install pycharm-community                     --force --yes --ignore-checksums
choco install vscode                                --force --yes --ignore-checksums --no-progress
choco install vscode-python                         --force --yes --ignore-checksums
choco install googlechrome                          --force --yes --ignore-checksums --no-progress
choco install chocolatey-windowsupdate.extension    --force --yes --ignore-checksums
choco install wsl-ubuntu-1804                       --force --yes --ignore-checksums
choco install git.install                           --force --yes --ignore-checksums
choco install git-lfs                               --force --yes --ignore-checksums
choco install vlc                                   --force --yes --ignore-checksums
choco install dotnetfx                              --force --yes --ignore-checksums
choco install ccleaner                              --force --yes --ignore-checksums
choco install microsoft-teams.install               --force --yes --ignore-checksums
choco install spotify                               --force --yes --ignore-checksums
choco install microsoft-windows-terminal            --force --yes --ignore-checksums
choco install jq                                    --force --yes --ignore-checksums
ori
