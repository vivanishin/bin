;; TODO: Help mode, Magit log mode, MagitPopup mode. 
(defun vi--config-evil ()
  "Configure evil mode."

  ; Use evil-motion as the initial state rather than evil-emacs state.
  (setq evil-motion-state-modes
        (append evil-emacs-state-modes evil-motion-state-modes))
  (setq evil-emacs-state-modes nil)

  (delete 'term-mode evil-insert-state-modes)

  ;; Use Emacs state in these modes.
  (dolist (mode '(dired-mode
                  term-mode))
    (add-to-list 'evil-emacs-state-modes mode))


  (evil-add-hjkl-bindings occur-mode-map 'emacs
    (kbd "/")       'evil-search-forward
    (kbd "n")       'evil-search-next
    (kbd "N")       'evil-search-previous
    (kbd "C-f")     'evil-scroll-down
    (kbd "C-u")     'evil-scroll-up
    (kbd "C-w C-w") 'other-window)

  ;; Global bindings.
  (evil-define-key 'normal global-map (kbd "z z")  'evil-write))


(defun vi--config-evil-leader ()
  "Configure evil leader mode."
  (evil-leader/set-leader "<SPC>")
  (evil-leader/set-key
    "w" 'evil-write
    "gs" 'magit-status
    "gl" 'magit-log-all
    "gd" 'magit-diff))


(provide 'init-evil)
