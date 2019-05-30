## Install personalizate config

1. Download the latest version of the symbol font and fontconfig file::

      wget https://github.com/powerline/powerline/raw/develop/font/PowerlineSymbols.otf
      wget https://github.com/powerline/powerline/raw/develop/font/10-powerline-symbols.conf
      ```
      powerline-gitstatus (1.3.1)
      powerline-shell (0.7.0)
      powerline-status (2.7)
      ```

2. Move the symbol font to a valid X font path. Valid font paths can be 
   listed with ``xset q``::

      mv PowerlineSymbols.otf ~/.local/share/fonts/

3. Update font cache for the path the font was moved to (root priveleges may be 
   needed to update cache for the system-wide paths)::

      fc-cache -vf ~/.local/share/fonts/

4. Install the fontconfig file. For newer versions of fontconfig the config 
   path is ``~/.config/fontconfig/conf.d/``, for older versions it’s  
   ``~/.fonts.conf.d/``::

      mv 10-powerline-symbols.conf ~/.config/fontconfig/conf.d/

If custom symbols still cannot be seen then try closing all instances of the 
terminal emulator. Restarting X may be needed for the changes to take effect.

5. Config Themes
https://medium.freecodecamp.org/jazz-up-your-bash-terminal-a-step-by-step-guide-with-pictures-80267554cb22

Open `/usr/local/lib/python2.7/dist-packages/powerline/` (module pip)
  - Add powerline-gitstatus color schemes to Powerline
  `code config_files/colorschemes/shell/default.json`

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

### References:
- https://powerline.readthedocs.io/en/master/installation/linux.html#fonts-installation
