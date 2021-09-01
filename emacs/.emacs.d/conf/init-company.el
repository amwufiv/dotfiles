;; 配置自动补全的company包
;(setq tab-always-indent 'complete)
;(add-to-list 'completion-styles 'initials t)

(when (maybe-require-package 'company)
  (add-hook 'after-init-hook 'global-company-mode)
  (when (maybe-require-package 'diminish)
    (diminish 'company-mode)))





(provide 'init-company)
