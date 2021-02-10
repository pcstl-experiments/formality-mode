(setq formality-keywords
      '("type"
	"do"
	"case"
	"let"
	"def"
	"as"
	"open"
	"if"
	"then"
	"else"
	"for"
	"in"
	"with"
	"upto"))

(setq formality-highlights
      `((("[A-Z][a-z0-9_]*" . font-lock-type-face)
	 (,(regexp-opt formality-keywords 'words) . font-lock-keyword-face)
	 ("'.'" . font-lock-constant-face)
	 ("[0-9]+[bsul]?" . font-lock-constant-face))))

(setq formality-mode-syntax-table
      (let ((table (make-syntax-table)))
	(modify-syntax-entry ?\/ ". 12b" table)
	(modify-syntax-entry ?\n "> b" table)
	(modify-syntax-entry ?_ "w" table)
	table))

(defun formality-completion-at-point ()
  (interactive)
  (let* ((bds (bounds-of-thing-at-point 'symbol))
	 (start (car bds))
	 (end (cdr bds)))
    (list start end formality-keywords . nil)))

(define-derived-mode formality-mode prog-mode "Formality"
  "Major mode for editing Formality code."
  (setq-local mode-name "Formality")
  (setq-local font-lock-defaults formality-highlights)
  (setq-local comment-start "//")
  (setq-local comment-end "")
  (add-hook 'completion-at-point-functions
	    'formality-completion-at-point
	    nil
	    'local))

(provide 'formality-mode)
