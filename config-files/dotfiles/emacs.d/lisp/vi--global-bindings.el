(global-set-key (kbd "C-c q") 'auto-fill-mode)
(global-set-key (kbd "C-;") 'comment-line)
(global-set-key (kbd "C-x C-j") 'dired-jump)

;; Compilation: save current buffer, recompile, then switch to results.
(global-set-key
 (kbd "<f7>")
 (lambda () (interactive)
   "Recompile and switch to compilation buffer."
   (save-buffer)
   (recompile)
   (if (not (compilation-buffer-p (current-buffer)))
       (switch-to-buffer-other-window compilation-last-buffer))))

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


(provide 'vi--global-bindings)
