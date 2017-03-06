(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'load-path "~/.emacs.d")
(package-initialize)


(server-start)

;;; ------------------------------------------------------------
;;; Packages.
(unless (package-installed-p 'use-package)
  (package-refresh-contents)
  (package-install 'use-package))

(use-package recentf
  :ensure t
  :config
  (recentf-mode 1)
  :bind (("C-x f" . recentf-open-files)))
; TODO: add magit-diff-mode and recentf-mode to evil-motion-state-modes

(require 'init-evil)
(use-package evil
  :ensure t

  :config

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (vi--config-evil-leader))

  (add-hook 'evil-mode-hook 'vi--config-evil)
  (evil-mode 1))

(use-package ido
  :ensure t
  :config
  (ido-mode 1))

(use-package dired-x)

(use-package magit
  :ensure t)

(use-package evil-magit
  :ensure t)

(use-package pdf-tools
  :ensure t)

;;; ------------------------------------------------------------
;;; Giule Scheme debugging.
(load "~/.emacs.d/guile-interaction-mode.el")
;(require 'gds)

;(add-to-list 'load-path "~/.emacs.d/static_packages/")
;
;;____________________________________________________________
;; Make the keys work with russian layout
;(require 'my-misc) ;; 'requires' are idempotent, you know
;(reverse-input-method "russian-computer")

(menu-bar-mode -1)
(tool-bar-mode -1)
(scroll-bar-mode nil)
(setq tramp-default-method "ssh")
(setq column-number-mode t)
(setq initial-scratch-message nil)
(setq-default indent-tabs-mode nil)
(setq-default tab-width 5)
(setq-default c-basic-offset 2)
(setq-default c-default-style "gnu")
(setq-default comment-multi-line t)
(setq-default comment-style 'extra-line)
(c-set-offset 'case-label '+)
(c-set-offset 'access-label -1)
(c-set-offset 'innamespace 0)
(c-set-offset 'inline-open 0)

;;; ------------------------------------------------------------
;;; Esc quits (http://stackoverflow.com/a/10166400/2104472)
(defun minibuffer-keyboard-quit ()
  "Abort recursive edit.
In Delete Selection mode, if the mark is active, just deactivate it;
then it takes a second \\[keyboard-quit] to abort the minibuffer."
  (interactive)
  (if (and delete-selection-mode transient-mark-mode mark-active)
      (setq deactivate-mark  t)
    (when (get-buffer "*Completions*") (delete-windows-on "*Completions*"))
    (abort-recursive-edit)))
(define-key evil-normal-state-map [escape] 'keyboard-quit)
(define-key evil-visual-state-map [escape] 'keyboard-quit)
(define-key minibuffer-local-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-ns-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-completion-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-must-match-map [escape] 'minibuffer-keyboard-quit)
(define-key minibuffer-local-isearch-map [escape] 'minibuffer-keyboard-quit)

;;; ------------------------------------------------------------
;;; Theme
(when window-system
 (require 'solarized)
 (load-theme 'solarized-dark t) ;wombat; misterioso; wheatgrass
 (add-to-list 'default-frame-alist '(font . "Monoid 10"))
 (setq x-pointer-shape x-pointer-arrow))

;;; ------------------------------------------------------------
;;; Keep all backup files in one place.
(setq backup-directory-alist '(("." . "~/.emacs.d/backup"))
  backup-by-copying t    ; Don't delink hardlinks
  version-control t      ; Use version numbers on backups
  delete-old-versions t  ; Automatically delete excess backups
  kept-new-versions 20   ; how many of the newest versions to keep
  kept-old-versions 5    ; and how many of the old
  )



;;; ------------------------------------------------------------
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("d677ef584c6dfc0697901a44b885cc18e206f05114c8a3b7fde674fce6180879" "a8245b7cc985a0610d71f9852e9f2767ad1b852c2bdea6f4aadc12cce9c4d6d0" "8aebf25556399b58091e533e455dd50a6a9cba958cc4ebb0aab175863c25b9a4" default)))
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("org" . "http://orgmode.org/elpa/"))))
 '(package-selected-packages
   (quote
    (evil-leader pdf-tools evil-magit magit use-package solarized-theme evil)))
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
