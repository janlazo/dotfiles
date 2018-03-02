;; Copyright 2018 Jan Edmund Doroin Lazo
;;
;; Licensed under the Apache License, Version 2.0 (the "License");
;; you may not use this file except in compliance with the License.
;; You may obtain a copy of the License at
;;
;;     http://www.apache.org/licenses/LICENSE-2.0
;;
;; Unless required by applicable law or agreed to in writing, software
;; distributed under the License is distributed on an "AS IS" BASIS,
;; WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
;; See the License for the specific language governing permissions and
;; limitations under the License.

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
