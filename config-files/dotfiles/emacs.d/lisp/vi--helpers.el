;;; I chose to refer to myself as vi in elisp code since these two
;;; letters happen to be an abbreviation of my name.

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(defun rm-eol-whitespace ()
  "Kill whitespace before ends of lines in current buffer."
  (interactive)
  (while (re-search-forward "[ \t]+$" nil t)
    (replace-match ""))
  (while (re-search-backward "[ \t]+$" nil t)
    (replace-match "")))

(provide 'vi--helpers)
