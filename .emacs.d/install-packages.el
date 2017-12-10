;; Imports
(require 'package)


;; Setup
(defconst my-packages
          '(
            ;; Vim Emulation
            evil
            evil-commentary
            evil-matchit
            evil-numbers    ;; not maintained
            evil-surround
            ;; Project
            editorconfig
            ;; UI
            nlinum-relative
            powerline
            ;; Themes
            moe-theme
            spacemacs-theme
            ))
(add-to-list 'package-archives
             '("melpa-stable" . "http://stable.melpa.org/packages/")
             t)
(add-to-list 'package-archives
             '("melpa" . "http://melpa.org/packages/")
             t)
(setq package-pinned-packages
      '(
        ;; Vim Emulation
        (evil . "melpa-stable")
        (evil-commentary . "melpa")
        (evil-matchit . "melpa-stable")
        (evil-numbers . "melpa")
        (evil-surround . "melpa-stable")
        ;; Project
        (editorconfig . "melpa-stable")
        ;; UI
        (nlinum-relative . "melpa")
        (powerline . "melpa")
        ;; Themes
        (moe-theme . "melpa")
        (spacemacs . "melpa")
        ))

;; Fix HTTP1/1.1 problems
(setq url-http-attempt-keepalives nil)


;; Begin Installation
(package-initialize)
(package-refresh-contents)

(dolist (package my-packages)
  (unless (package-installed-p package)
    (package-install package)))
