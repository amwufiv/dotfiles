(setq debug-on-error t)

(add-to-list 'load-path (expand-file-name "conf" user-emacs-directory))

(defconst *is-a-mac* (eq system-type 'darwin))



(setq custom-file (expand-file-name "conf/custom.el" user-emacs-directory))

(require 'init-utils)

(require 'init-packages)
(require 'init-themes)
(require 'init-ui)
(require 'init-recentf)
(require 'init-org)
(require 'init-ivy)
(require 'init-company)

(when (file-exists-p custom-file)
  (load custom-file))

(provide 'init)
