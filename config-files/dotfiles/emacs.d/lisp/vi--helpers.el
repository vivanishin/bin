;;; I chose to refer to myself as vi in elisp code since these two
;;; letters happen to be an abbreviation of my name.

(defun backward-kill-line (arg)
  "Kill ARG lines backward."
  (interactive "p")
  (kill-line (- 1 arg)))

(provide 'vi--helpers)
