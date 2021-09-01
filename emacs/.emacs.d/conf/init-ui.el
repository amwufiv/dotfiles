(defun ufiv/maybe-suspend-frame ()
  (interactive)
  (unless (and *is-a-mac* window-system)
    (suspend-frame)))


(global-set-key (kbd "C-z") 'ufiv/maybe-suspend-frame)

;;取消gui的一些无用功能
(setq use-file-dialog nil)
(setq use-dialog-box nil)
(setq inhibit-startup-screen t)

;;取消工具栏
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1)) 

;;取消滚动条
(when (fboundp 'set-scroll-bar-mode)
  (set-scroll-bar-mode nil))

;;显示行号
(global-linum-mode t)

;;设置鼠标类型
(setq-default cursor-type 'bar)

;;全屏显示
(setq initial-frame-alist (quote ((fullscreen . maximized))))

;;设置当前行高亮
(global-hl-line-mode t)

;;设置字体及大小
;;(set-default-font "Monaco-14")
(set-face-attribute 'default nil :height 180)

(let ((no-border '(internal-border-width . 0)))
  (add-to-list 'default-frame-alist no-border)
  (add-to-list 'initial-frame-alist no-border))

(defun ufiv/adjust-opacity (frame incr)
  "调整背景调明度"
  (unless (display-graphic-p frame)
    (error "Cannot adjust opacity of this frame"))
  (let* ((oldalpha (or (frame-parameter frame 'alpha) 100))
         ;; The 'alpha frame param became a pair at some point in
         ;; emacs 24.x, e.g. (100 100)
         (oldalpha (if (listp oldalpha) (car oldalpha) oldalpha))
         (newalpha (+ incr oldalpha)))
    (when (and (<= frame-alpha-lower-limit newalpha) (>= 100 newalpha))
      (modify-frame-parameters frame (list (cons 'alpha newalpha))))))

(when (and *is-a-mac* (fboundp 'toggle-frame-fullscreen))
  ;; Command-Option-f to toggle fullscreen mode
  ;; Hint: Customize `ns-use-native-fullscreen'
  (global-set-key (kbd "M-ƒ") 'toggle-frame-fullscreen))

;; TODO: use seethru package instead?
(global-set-key (kbd "M-C-8") (lambda () (interactive) (ufiv/adjust-opacity nil -2)))
(global-set-key (kbd "M-C-9") (lambda () (interactive) (ufiv/adjust-opacity nil 2)))
(global-set-key (kbd "M-C-7") (lambda () (interactive) (modify-frame-parameters nil `((alpha . 100)))))

;;取消鼠标操作
(require-package 'disable-mouse)
;;(global-disable-mouse-mode)

;;将剪切和复制的快捷键交换
(global-set-key (kbd "C-w") 'kill-ring-save)
(global-set-key (kbd "M-w") 'kill-region)

;;设置文件默认编码
(prefer-coding-system 'utf-8)

;;取消响铃
(setq ring-bell-function 'ignore)

;;设置选中再替换能够替换掉
(delete-selection-mode 1)

;;取消备份
(setq make-backup-files nil)

;;取消自动保存
(setq auto-save-default nil)

;;简化选项
(fset 'yes-or-no-p 'y-or-n-p)

;;显示匹配括号
(when (maybe-require-package 'rainbow-delimiters)
  (add-hook 'prog-mode-hook 'rainbow-delimiters-mode))
(show-paren-mode t)

;;增强弹出窗口
;;(require-package 'popwin)
;;(popwin-mode 1)


;;设置初始化模式
(setq-default initial-major-mode 'org-mode)


;; disable mouse
(require 'disable-mouse)
(require 'diminish)
(global-disable-mouse-mode)
(diminish 'disable-mouse-global-mode)


(provide 'init-ui)






