(define-key global-map (kbd "C-c l") 'org-store-link)
(define-key global-map "\C-ca" 'org-agenda)


;; 设置代码高亮
(setf org-src-fontify-natively t)

;; 设置自动换行
(add-hook 'org-mode-hook
          (lambda()
            (setq truncate-lines nil)))


(setq org-log-done 'time)

;; 设置我的org文件夹
(load-library "find-lisp")
(setq org-agenda-files (find-lisp-find-files "~/Org" "\.org$"))

;; 取消tag继承
(setq org-use-tag-inheritance nil)

;; 添加scala语言

;; 添加加密
(require 'epa-file)
(custom-set-variables '(epg-gpg-program  "/usr/local/bin/gpg"))
(epa-file-enable)

;; set pic view width
(setq org-image-actual-width (/ (display-pixel-width) 3))









(provide 'init-org)
