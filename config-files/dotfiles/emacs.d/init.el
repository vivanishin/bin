(require 'package)
(add-to-list 'package-archives '("melpa" . "http://melpa.org/packages/"))
(add-to-list 'load-path (expand-file-name "lisp" user-emacs-directory))
(package-initialize)

;;; ------------------------------------------------------------
;;; Theme
(when window-system
 (require 'solarized)
 (load-theme 'solarized-dark t) ;wombat; misterioso; wheatgrass
 (add-to-list 'default-frame-alist '(font . "Inconsolata 10"))
 (setq x-pointer-shape x-pointer-arrow))

(set-face-bold-p 'bold nil)
(blink-cursor-mode -1)

(setq-default fill-column 80)
(global-set-key (kbd "C-c q") 'auto-fill-mode)

(server-start)

;;; ------------------------------------------------------------
;;; Window management.
(require 'vi--windows)

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

(require 'init-evil)

(use-package highlight
  :ensure t)

(use-package evil
  :ensure t

  :config

  (use-package evil-leader
    :ensure t
    :config
    (global-evil-leader-mode)
    (vi--config-evil-leader))

  (add-hook 'evil-mode-hook 'vi--config-evil)

  (use-package evil-search-highlight-persist
    :ensure t
    :config
    (global-evil-search-highlight-persist)
    (evil-define-key 'normal global-map (kbd "C-l") 'evil-search-highlight-persist-remove-all))

  (evil-mode 1))

(use-package ido
  :ensure t
  :config
  (ido-mode 1))

(use-package dired-x)

(use-package magit
  :config (progn
            (setq evil-magit-want-horizontal-movement t)
            (setq git-commit-summary-max-length 50)
            (use-package evil-magit
              :ensure t
              :config
              (setq evil-magit-state 'normal)))
  :ensure t)

(use-package pdf-tools
  :ensure t)

(use-package xcscope
  :ensure t)


;;; ------------------------------------------------------------
;;; Build with make. https://emacswiki.org/emacs/CompileCommand#toc5
(require 'cl)

(defun* get-closest-pathname (&optional (file "Makefile"))
  "Determine the pathname of the first instance of FILE starting from
the current directory towards root.  This may not do the correct thing
in presence of links. If it does not find FILE, then it shall return
the name of FILE in the current directory, suitable for creation"
  (let ((root (expand-file-name "/")))
    (expand-file-name file
                      (loop
                       for d = default-directory then (expand-file-name ".." d)
                       if (file-exists-p (expand-file-name file d))
                       return d
                       if (equal d root)
                       return nil))))

(require 'compile)
(add-hook 'c++-mode-hook
          (lambda ()
            (set (make-local-variable 'compile-command)
                 (format "make -f %s" (get-closest-pathname)))))

;;; ------------------------------------------------------------
;;; Giule Scheme debugging.
(require 'guile-interaction-mode)
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
(setq tramp-default-method "scp")
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

;; Treat underscore as a part of a word in C and C++ modes.
(require 'cc-mode)
(modify-syntax-entry ?_ "w" c-mode-syntax-table)
(modify-syntax-entry ?_ "w" c++-mode-syntax-table)

;; Treat the dash symbol as a part of a word in emacs lisp.
(modify-syntax-entry ?- "w" emacs-lisp-mode-syntax-table)

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
 '(org-startup-truncated nil)
 '(package-archives
   (quote
    (("melpa" . "http://melpa.org/packages/")
     ("gnu" . "http://elpa.gnu.org/packages/")
     ("marmalade" . "http://marmalade-repo.org/packages/")
     ("org" . "http://orgmode.org/elpa/"))))
 '(package-selected-packages
   (quote
    (key-chord xcscope evil-search-highlight-persist highlight evil-leader pdf-tools evil-magit magit use-package solarized-theme evil)))
 '(scheme-program-name "guile")
 '(scroll-bar-mode nil)
 '(show-paren-mode t))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
