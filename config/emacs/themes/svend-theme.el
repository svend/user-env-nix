(deftheme svend
  "Created 2015-03-11.")

(custom-theme-set-faces
 'svend
 `(default ((t (:height ,(if (eq window-system 'ns) 150 110)))))
 '(nobreak-space ((t (:underline nil))))
 '(sh-heredoc ((t (:inherit font-lock-string-face)))))

(provide-theme 'svend)
