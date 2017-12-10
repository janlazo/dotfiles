;; Setup
(defvar *emacs-d* (file-name-directory load-file-name))


;; Imports
;; (add-to-list 'custom-theme-load-path (concat *emacs-d* "/themes"))
(require 'package)
(package-initialize)
;; Vim Emulation
(require 'evil)
(require 'evil-commentary)
(require 'evil-matchit)
(require 'evil-numbers)
(require 'evil-surround)
;; Project
(require 'editorconfig)
;; UI
(require 'nlinum-relative)
(require 'powerline)
;; Themes
;; (require 'moe-theme)


;; General Settings
(setq custom-file (concat *emacs-d* "/custom.el"))
(setq inhibit-startup-screen t)
(setq package-enable-at-startup nil)
;; (add-to-list 'default-frame-alist '(font . "Fira Mono Medium-11"))
(add-to-list 'default-frame-alist '(height . 24))
(add-to-list 'default-frame-alist '(width . 120))


;; Packages Settings
(evil-mode 1)
(evil-commentary-mode)
(global-evil-matchit-mode 1)
(global-evil-surround-mode 1)

;; Increment (Alt + a) / Decrement (Alt + s) numbers in EVIL's normal mode
(define-key evil-normal-state-map (kbd "M-a") 'evil-numbers/inc-at-pt)
(define-key evil-normal-state-map (kbd "M-s") 'evil-numbers/dec-at-pt)

(editorconfig-mode 1)

(nlinum-relative-setup-evil)
(add-hook 'prog-mode-hook 'nlinum-relative-mode)
(setq nlinum-relative-current-symbol "->")
(setq nlinum-relative-offset 0)


;; Begin
(when (or (display-graphic-p) (not (eq system-type 'windows-nt)))
  (powerline-center-evil-theme)
  ;; (moe-light)
  ;; (enable-theme 'moe-light)
  (load-theme 'spacemacs-dark t)
  (enable-theme 'spacemacs-dark))
