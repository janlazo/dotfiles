# GNU Emacs

## Packages

* Archives
    * [Melpa](http://melpa.org/packages/)
    * [Melpa Stable](http://stable.melpa.org/packages/)
* install-packages.el
    * [evil](https://github.com/emacs-evil/evil)
    * [editorconfig](https://github.com/editorconfig/editorconfig-emacs)

## Install

```sh
cd ~/.emacs.d
emacs -batch -l install-packages.el
```

### Windows

Use a batch file to set environment variables before running emacs

```dosbatch
set HOME=%USERPROFILE%
start /min emacs.exe %*
```
