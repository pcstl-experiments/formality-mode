(setq formality-built-in-types
      '("IO"
	"Unit"
	"U8"
	"U16"
	"U32"
	"U64"
	"U256"
	"App"
	"Array"
	"Bit"
	"Bits"
	"Bool"
	"Buffer32"
	"Char"
	"Cmp"
	"Col32"
	"Either"
	"Empty"
	"Equal"
	"F64"
	"Function"
	"Functor"
	"GMap"
	"GSet"
	"Image3D"
	"Int"
	"JSON"
	"Term"
	"List"
	"Map"
	"Maybe"
	"Monad"
	"Nat"
	"Pair"
	"Pos32"
	"Queue"
	"Set"
	"Sigma"
	"String"
	"The"
	"Vector"
	"Word"))

(setq formality-keywords
      '("type" "do"))

(setq formality-highlights
      `((
	 ("\"\\.\\*\\?" . font-lock-string-face)
	 (,(regexp-opt formality-built-in-types 'words) . font-lock-type-face)
	 (,(regexp-opt formality-keywords 'words) . font-lock-keyword-face)
	 )))

(define-derived-mode formality-mode prog-mode "Formality"
  "major mode for editing Formality code"
  (setq mode-name "Formality")
  (setq font-lock-defaults formality-highlights))

(provide 'formality-mode)
