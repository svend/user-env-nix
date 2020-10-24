(deftheme svend
  "Created 2015-03-11.")

(custom-theme-set-faces
 'svend
 `(cursor ((t (:background ,(face-foreground 'default)))))
 `(default ((t (:height ,(if (eq window-system 'ns) 125 115)))))
 '(diff-added ((t (:inherit fixed-pitch))))
 '(diff-context ((t (:inherit (shadow fixed-pitch)))))
 '(diff-hunk-header ((t (:inherit fixed-pitch))))
 '(diff-removed ((t (:inherit fixed-pitch))))
 `(eglot-mode-line ((t (:inherit mode-line))))
 `(flyspell-incorrect ((t (:background ,(face-background 'default)))))
 '(font-lock-doc-face ((t (:inherit variable-pitch))))
 `(fringe ((t (:background ,(face-background 'default) :foreground ,(face-foreground 'shadow)))))
 `(line-number ((t (:background ,(face-background 'default) :foreground ,(face-foreground 'shadow) :weight light :inherit (fixed-pitch shadow default)))))
 '(markdown-pre-face ((t (:inherit fixed-pitch))))
 '(nobreak-space ((t (:underline nil))))
 ;; See Emacs 27 NEWS: ** New face attribute ':extend' to control face extension at EOL.
 '(org-block ((t (:inherit fixed-pitch :extend t))))
 '(org-block-begin-line ((t (:extend t))) )
 '(org-block-end-line ((t (:extend t))) )
 '(org-checkbox ((t (:inherit fixed-pitch))))
 '(org-code ((t (:inherit fixed-pitch))))
 '(org-date ((t (:inherit fixed-pitch))))
 '(org-ellipsis ((t (:underline nil))))
 '(org-link ((t (:inherit fixed-pitch link))))
 '(org-table ((t (:inherit fixed-pitch))))
 '(org-verbatim ((t (:inherit fixed-pitch))))

 '(sh-heredoc ((t (:inherit font-lock-string-face)))))

(provide-theme 'svend)
