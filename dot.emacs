;; -*- mode: Lisp; -*-

;;设置load-path
(add-to-list 'load-path "~/.emacs.d/lisp")

;;Emacs中shell启用ansi color
;; (autoload 'ansi-color-for-comint-mode-on "ansi-color" nil t) 
;; (add-hook 'shell-mode-hook 'ansi-color-for-comint-mode-on t)

;;回车自动缩进
;; (global-set-key (kbd "RET") 'newline-and-indent)
;; (add-hook 'html-mode-hook
		  ;; (lambda ()
			;; Default indentation is usually 2 spaces, changing to 4.
			;; (set (make-local-variable 'sgml-basic-offset) 4)))

;;====设置字体=======
(custom-set-faces		       
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Monaco" :foundry "unknown" :slant normal :weight normal :height 151 :width normal)))))
;;---------另一种格式--------
;;格式:字体名称-字号
;; (set-default-font "-*-Monaco-*-*-*-*-*-160-*-*-*-*-iso10646-1")

;;注释代码(dwim: Do What I Mean)(Alt-;)
(defun qiang-comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command. If no region is selected and current line is not blank and we are not at the end of the line, then comment current line. Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))
(global-set-key "\M-;" 'qiang-comment-dwim-line) 


;; 解决emacs shell 乱码
(setq ansi-color-for-comint-mode t)
(customize-group 'ansi-colors)
(kill-this-buffer);关闭customize窗口


;;自定义按键
;; (global-set-key [f1] 'shell);F1进入Shell
;; (global-set-key [f2] 'rename-buffer);F2修改缓冲区名字
;; (setq compile-command "make -f Makefile")
;; (global-set-key [f7] 'do-compile);F7编译文件
(global-set-key [f8] 'other-window);F8窗口间跳转
(global-set-key [C-return] 'kill-this-buffer);C-return关闭当前buffer
(global-set-key [f10] 'split-window-vertically);F10分割窗口
;;(global-set-key [f11] 'delete-other-windows);F11 关闭其它窗口
;;(global-set-key [f12] 'my-fullscreen);F12 全屏
;; (global-set-key [f11] 'my-fullscreen);F11 全屏
(global-set-key (kbd "M-,") 'backward-page);文件首
(global-set-key (kbd "M-.") 'forward-page);文件尾
(global-set-key (kbd "C-g") 'goto-line);跳转指定行

;;普通设置
(setq inhibit-startup-message t);关闭起动时闪屏
(setq visible-bell t);关闭出错时的提示声
(setq make-backup-files 0);不产生备份文件
(setq default-major-mode 'text-mode);一打开就起用 text 模式
(global-font-lock-mode t);语法高亮
(auto-image-file-mode t);打开图片显示功能
(fset 'yes-or-no-p 'y-or-n-p);以 y/n代表 yes/no
(column-number-mode t);显示列号
(show-paren-mode t);显示括号匹配
(display-time-mode 1);显示时间，格式如下
(setq display-time-24hr-format t)
(setq display-time-day-and-date t)
(tool-bar-mode 0);去掉那个大大的工具栏
(global-linum-mode t);设置行号
(menu-bar-mode 0);去掉菜单栏
(scroll-bar-mode 0);去掉滚动条
(mouse-avoidance-mode 'animate);光标靠近鼠标指针时，让鼠标指针自动让开
(setq mouse-yank-at-point t);支持中键粘贴
(transient-mark-mode t);允许临时设置标记
(setq x-select-enable-clipboard t);支持emacs和外部程序的粘贴
;; (setq frame-title-format '("" buffer-file-name "@emacs" ));在标题栏显示buffer名称
;; (setq frame-title-format '("" buffer-file-name "emacs@%b" ));在标题栏显示buffer名称
(setq frame-title-format "emacs@%b")
;;在标题栏显示buffer的名字，而不是 emacs@wangyin.com 这样没用的提示。
(setq default-fill-column 80);默认显示 80列就换行 


;鼠标滚轮，默认的滚动太快，这里改为3行
(defun up-slightly () (interactive) (scroll-up 3))
(defun down-slightly () (interactive) (scroll-down 3))
(global-set-key [mouse-4] 'down-slightly)
(global-set-key [mouse-5] 'up-slightly)

;;设置透明度
;; (global-set-key [(f9)] 'loop-alpha)
;;(setq alpha-list '((100 100) (95 65) (85 55) (75 45) (65 35)))
;; (setq alpha-list '((100 100) (85 55) (65 35)))
;; (defun loop-alpha ()
  ;; (interactive)
  ;; (let ((h (car alpha-list)))                ;; head value will set to
    ;; ((lambda (a ab)
       ;; (set-frame-parameter (selected-frame) 'alpha (list a ab))
       ;; (add-to-list 'default-frame-alist (cons 'alpha (list a ab)))
       ;; ) (car h) (car (cdr h)))
    ;; (setq alpha-list (cdr (append alpha-list (list h))))
    ;; )
  ;; )


;;全屏
;;(defun my-fullscreen ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;;(my-fullscreen)

;; 最大化
;;(defun my-maximized ()
;;  (interactive)
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(1 "_NET_WM_STATE_MAXIMIZED_HORZ" 0))
;;  (x-send-client-message
;;   nil 0 nil "_NET_WM_STATE" 32
;;   '(1 "_NET_WM_STATE_MAXIMIZED_VERT" 0))
;;  )
;; 启动emacs时窗口最大化
;;(my-maximized)

;;;;缩进策略
;;(defun my-indent-or-complete ()
;;  (interactive)
;;  (if (looking-at "\\>")
;;      (hippie-expand nil)
;;    (indent-for-tab-command)))

;;(set-fontset-font "fontset-default"
;;				  'gb18030 '("Microsoft YaHei" . "unicode-bmp"))

;;tab键
;;(global-set-key [C-tab] '(lambda () (interactive) (insert-char 9 1)))
;;(setq default-tab-width 4)

;;关闭生成临时文件
(setq auto-save-default nil)

;;关闭生成备份文件
(setq make-backup-files nil)

;;重新加载文件
(defun refresh-file ()
  (interactive)
  (revert-buffer t (not (buffer-modified-p)) t))
(global-set-key [(control f5)] 'refresh-file)

;; 当光标在行尾上下移动的时候，始终保持在行尾。   
(setq track-eol t)

;;粘贴于光标处，而不是鼠标指针处  
(setq mouse-yank-at-point t)

;;光标显示为一竖线  
(set-cursor-color "red")
(setq-default cursor-type 'bar)

;;========高亮显示当前行========
(global-hl-line-mode 1)

;;自动刷新文件（磁盘上文件被修改）
(global-auto-revert-mode 1)

;;默认工作目录
(setq default-directory "~/")

;;Markdown Mode
(autoload 'markdown-mode "markdown-mode"
   "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.markdown\\'" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md\\'" . markdown-mode))

;;修改启动两个窗口时的默认布局方式为横向布局
(setq split-height-threshold nil)
(setq split-width-threshold 0)

;;多窗口切换
;;set windows numbering  
;;(require 'window-numbering)
;;(window-numbering-mode 1)

;;将光标移动到当前行的中间位置
(defun middle-of-line ()
  "Put cursor at the middle point of the line."
  (interactive)
  (goto-char (/ (+ (point-at-bol) (point-at-eol)) 2)))
(global-set-key (kbd "C-z") 'middle-of-line)

;;=========mode-line颜色设置======= 
;; (set-face-attribute  'mode-line
;; 					 nil
;; 					 :foreground "gray80"
;; 					 :background "goldenrod"
;; 					 :box '(:line-width 1 :style released-button))
;; (set-face-attribute  'mode-line-inactive
;; 					 nil
;; 					 :foreground "gray30"
;; 					 :background "gray10"
;; 					 :box '(:line-width 1 :style released-button))


(global-set-key (kbd "C-c e") 'erase-buffer)
(put 'erase-buffer 'disabled nil)

;;========ido(在下面的buffer中显示目录下的选项)========
(ido-mode t)
(setq ido-save-directory-list-file nil)

;;=======设置窗口大小=======
;;---------全屏----------
;; (add-to-list 'default-frame-alist '(fullscreen . maximized))
;; 设置窗口位置为屏库左上角(0,0)
(set-frame-position (selected-frame) 0 0)
;;设置宽和高,我的十寸小本是110,33,大家可以调整这个参数来适应自己屏幕大小
(set-frame-width (selected-frame) 80) 
(set-frame-height (selected-frame) 40)
