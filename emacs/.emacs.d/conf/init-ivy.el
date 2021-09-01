;;; -*- lexical-binding: t -*-
(when (maybe-require-package 'ivy)
  (add-hook 'after-init-hook 'ivy-mode)
  (after-load 'ivy
    (setq-default ivy-use-virtual-buffers t
                  ivy-virtual-abbreviate 'fullpath
                  ivy-count-format "%d/%d"
                  projectile-completion-system 'ivy
                  ivy-magic-tilde nil
                  ivy-dynamic-exhibit-delay-ms 150
                  ivy-initial-inputs-alist
                  '((Man-completion-table  . "^")
                    (woman . "^")))


    (when (maybe-require-package 'diminish)
      (diminish 'ivy-mode))))

(when (maybe-require-package 'counsel)
  (setq-default counsel-mode-override-describe-bindings t)
  (when (maybe-require-package 'diminish)
    (after-load 'counsel
		(global-set-key (kbd "M-x") 'counsel-M-x)
		(global-set-key (kbd "C-x C-f") 'counsel-find-file)
		(global-set-key (kbd "C-h f") 'counsel-describe-function)
		(global-set-key (kbd "C-h v") 'counsel-describe-variable)
		(diminish 'counsel-mode)))
  (add-hook 'after-init-hook 'counsel-mode)

 )

(when (maybe-require-package 'swiper)
  (global-set-key (kbd "C-s") 'swiper))

(provide 'init-ivy)

