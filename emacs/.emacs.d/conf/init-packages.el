(require 'package)

;;将依赖包安装到不同emacs版本的文件夹中，避免字节码在不同的版本中出现不兼容的情况
(let ((versioned-package-dir
       (expand-file-name (format "elpa-%s.%s" emacs-major-version emacs-minor-version)
			 user-emacs-directory)))
  (setq package-user-dir versioned-package-dir))

;; 配置自己的代理，可以不使用cntlm直接发使用大陆的代理节点（其它地域访问镜像地址有问题）
;;(setq url-using-proxy -1)
;;(setq url-proxy-services '(("http" . "127.0.0.1:3182")
;;			   ("https" . "127.0.0.1:3182")
;;			   ("ftp" . "127.0.0.1:3182")))

;;配置镜像源，忽略http、https协议的配置
(when (>= emacs-major-version 26)
  (setq package-archives '(("gnu"   . "http://elpa.emacs-china.org/gnu/")
                           ("melpa" . "http://elpa.emacs-china.org/melpa/"))))

(require 'cl-lib)

;;定义安装包的参数，包含给定最低版本号的功能。
(defun require-package (package &optional min-version no-refresh)
  "安装指定的饭锅，可选参数安装包的最低版本号。
   如果NO-REFRESH变量不为空，那么在查找包时包列表将不会重复下载。"
  (or (package-installed-p package min-version)
      (let* ((known (cdr (assoc package package-archive-contents)))
             (versions (mapcar #'package-desc-version known)))
        (if (cl-find-if (lambda (v) (version-list-<= min-version v)) versions)
            (package-install package)
          (if no-refresh
              (error "No version of %s >= %S is available" package min-version)
            (package-refresh-contents)
            (require-package package min-version t))))))

(defun maybe-require-package (package &optional min-version no-refresh)
  "Try to install PACKAGE, and return non-nil if successful.
In the event of failure, return nil and print a warning message.
Optionally require MIN-VERSION.  If NO-REFRESH is non-nil, the
available package lists will not be re-downloaded in order to
locate PACKAGE."
  (condition-case err
      (require-package package min-version no-refresh)
    (error
     (message "Couldn't install optional package `%s': %S" package err)
     nil)))

(setq package-enable-at-startup nil)
(package-initialize)

;;ToDO:执行后发现没什么优化效果
(require-package 'fullframe)
(fullframe list-packages quit-window)



(provide 'init-packages)



