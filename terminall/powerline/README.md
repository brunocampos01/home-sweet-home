# Install personalizate config

1. Download the latest version of the symbol font and fontconfig file::

```bash
wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf

wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
```

```bash
pip3 install powerline-gitstatus \
             powerline-shell \
             powerline-status
```

or

```bash
sudo apt-get install fonts-powerline \
                     fonts-powerline
```

2. Move the symbol font to a valid X font path. Valid font paths can be listed with ``xset q``:

```
mv PowerlineSymbols.otf ~/.local/share/fonts/
```

3. Update font cache for the path the font was moved to (root priveleges may be needed to update cache for the system-wide paths):

```bash
fc-cache -vf ~/.local/share/fonts/
```

4. Install the fontconfig file. For newer versions of fontconfig the config 
   path is ``~/.config/fontconfig/conf.d/``, for older versions it’s  
   ``~/.fonts.conf.d/``::

```bash
mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/
```

If custom symbols still cannot be seen then try closing all instances of the 
terminal emulator. Restarting X may be needed for the changes to take effect.

5. Config Themes: https://medium.freecodecamp.org/jazz-up-your-bash-terminal-a-step-by-step-guide-with-pictures-80267554cb22

   - Open `/usr/local/lib/python2.7/dist-packages/powerline/` (module pip)
   - Add powerline-gitstatus color schemes to Powerline
   
```bash
code config_files/colorschemes/shell/default.json`
```

## Optional Config 
```
{
  "segments": [
    "virtual_env",
    "battery",
    "username",
    "hostname",
    "aws_profile",
    "ssh",
    "cwd",
    "git",
    "git_stash",
    "jobs",
    "set_term_title",
    "svn",
    "newline",
    "root"
  ],
  "mode": "compatible",
  "cwd": {
    "max_depth": 10
  }
}
```

## Author
- Bruno Aurélio Rôzza de Moura Campos (brunocampos01@gmail.com)

## References
### References:
- https://powerline.readthedocs.io/en/master/installation/linux.html#fonts-installation


## Copyright
<a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/"><img alt="Creative Commons License" style="border-width:0" src="https://i.creativecommons.org/l/by-sa/4.0/88x31.png" /></a><br />This work by <span xmlns:cc="http://creativecommons.org/ns#" property="cc:attributionName">Bruno A. R. M. Campos</span> is licensed under a <a rel="license" href="http://creativecommons.org/licenses/by-sa/4.0/">Creative Commons Attribution-ShareAlike 4.0 International License</a>.