;; TODO: consider enabling lexical-binding for the file.
(require 'cl)

(defun balanced (command)
  "Retain window balance after operation."
  (lexical-let ((x command))
    (lambda ()
      (interactive)
      (funcall x)
      (balance-windows))))

(defun safe-delete-frame () (interactive)
  (if (yes-or-no-p "Delete this frame? ")
      (delete-frame)))

(use-package key-chord
  :ensure t
  :config
  (key-chord-mode 1)

  (key-chord-define-global "x1" 'delete-other-windows)
  (key-chord-define-global "x2" (balanced 'split-window-below))
  (key-chord-define-global "x3" (balanced 'split-window-right))
  (key-chord-define-global "x0" (balanced 'delete-window))
  (key-chord-define-global "xo" 'other-window)
  (key-chord-define-global "5o" 'other-frame)
  (key-chord-define-global "52" 'make-frame-command)
  (key-chord-define-global "50" 'safe-delete-frame)
  (key-chord-define-global "xb" 'ido-switch-buffer)
  (key-chord-define-global "xk" 'ido-kill-buffer)
  (key-chord-define-global "xs" 'save-buffer)
  (key-chord-define-global "xf" 'ido-find-file)
  (key-chord-define-global "xv" 'ido-find-alternate-file))

(provide 'vi--windows)
