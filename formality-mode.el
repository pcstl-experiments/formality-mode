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

(setq formality-mode-highlights
      `((("'.'" . font-lock-constant-face)
	 ("[A-Z][a-z0-9_]*" . font-lock-type-face)
	 ("[0-9]+[bsul]?" . font-lock-constant-face)
	 (,(regexp-opt formality-keywords 'words) . font-lock-keyword-face))))

(setq formality-mode-syntax-table
      (let ((table (make-syntax-table)))
	(modify-syntax-entry ?\/ ". 12b" table)
	(modify-syntax-entry ?\n "> b" table)
	(modify-syntax-entry ?_ "w" table)
	table))

;; Indentation rules
;; Top-level decls are type and typed decl
;; indent-line
;; If we are at line 1, indent to 0.
;; Otherwise, define "previous line" as being (line - 1)
;; If previous line starts with a top-level decl,
;;   then indent by 2 spaces wrt previous line.
;; If previous line starts with "let" or "def",
;;   If contents of previous line are well-formed,
;;     then indent at same level of previous line.
;;   Otherwise, indent 2 spaces wrt previous line.
;; If previous line starts with case and ends with {,
;;   then indent 2 spaces wrt previous line.
;; If previous line is a case,
;;   If return value of the case is well-formed,
;;     then indent at same level of previous line.
;;   Otherwise, indent 2 spaces wrt previous line.
;; If previous line is empty, indent wrt line above that.

(defun formality-completion-at-point ()
  (interactive)
  (let* ((bds (bounds-of-thing-at-point 'symbol))
	 (start (car bds))
	 (end (cdr bds)))
    (list start end formality-keywords . nil)))

(define-derived-mode formality-mode prog-mode "Formality"
  "Major mode for editing Formality code."
  (setq-local mode-name "Formality")
  (setq-local font-lock-defaults formality-mode-highlights)
  (setq-local comment-start "//")
  (setq-local comment-end "")
  (add-hook 'completion-at-point-functions
	    'formality-completion-at-point
	    nil
	    'local))

(provide 'formality-mode)
