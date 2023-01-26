(require 'package)
   (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
   ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
   ;; and `package-pinned-packages`. Most users will not need or want to do this.
   ;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
;;   (package-initialize)

    (add-to-list 'package-archives
    '("nongnu" . "https://elpa.nongnu.org/nongnu/"))
   ;; Set up package.el to work with MELPA
   (require 'package)
   (add-to-list 'package-archives
		             '("melpa" . "https://melpa.org/packages/") t)
  ;; (package-initialize)
   (package-refresh-contents)

   ;; Download Evil
   (unless (package-installed-p 'evil)
       (package-install 'evil))

   (unless (package-installed-p 'use-package)
       (package-install 'use-package))
   ;; helpful
   ;; Enable Evil
   (require 'evil)
   (evil-mode 1)


   ;; get rid of ugly gui
   (menu-bar-mode -1)
   (scroll-bar-mode -1)
   (tool-bar-mode -1)



   ;; theme
   (load-theme 'monokai t)
   (require 'doom-modeline)
   (doom-modeline-mode 1)

   (require 'vertico)
   (vertico-mode 1)

   
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("d824f0976625bb3bb38d3f6dd10b017bdb4612f27102545a188deef0d88b0cd9" "11cc65061e0a5410d6489af42f1d0f0478dbd181a9660f81a692ddc5f948bf34" "d516f1e3e5504c26b1123caa311476dc66d26d379539d12f9f4ed51f10629df3" "f00a605fb19cb258ad7e0d99c007f226f24d767d01bf31f3828ce6688cbdeb22" "ab729ed3a8826bf8927b16be7767aa449598950f45ddce7e4638c0960a96e0f1" "f4cdc8dea941e3c7e92b907e62cdc03e0483a350b738a43c2e118ce6be9880a6" "830596655dc39879096d9b7772768de6042fb5a4293c6b90c98a9b98bce96e4a" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" default))
 '(package-selected-packages
   '(geiser-mit racket-mode beacon scheme-complete docker darktooth-theme python-black exec-path-from-shell web-mode json-mode js2-mode tide typescript-mode kaolin-themes darkmine-theme flycheck nyan-mode which-key rainbow-delimiters moe-theme rust-mode melancholy-theme monokai-theme corfu affe use-package fireplace vertico circe-notifications magit vterm helpful evil doom-modeline company circe evil-magit bind-key)))
   
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
;;(setq indent-line-function 'insert-tab)
(global-linum-mode)

(setq c-basic-offset 4)

(load-file "~/.emacs.d/evil-magit.el")

(require 'evil-magit)

;;company

(setq company-idle-delay 0.01)
(setq company-minimum-prefix-lenth 1)

;;(use-package company-box
;;  :hook (company-mode . company-box-mode))

(load-file "~/.emacs.d/company-clang.el")

(which-key-mode)

(global-company-mode)
(global-flycheck-mode)


(defun kill-other-buffers ()
      "Kill all other buffers."
      (interactive)
      (mapc 'kill-buffer (delq (current-buffer) (buffer-list))))

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

;; aligns annotation to the right hand side
(setq company-tooltip-align-annotations t)

(add-to-list 'auto-mode-alist '("\\.js\\'" . js2-mode))
(add-to-list 'auto-mode-alist '("\\.sm\\'" . scheme-mode))
(flycheck-add-mode 'javascript-eslint 'js2-mode)
(flycheck-add-mode 'javascript-eslint 'tide-mode)


;;BINDINGS
;;  python
(define-key evil-normal-state-map (kbd "SPC w m") 'kill-other-buffers)
(define-key evil-normal-state-map (kbd "SPC SPC") 'find-file)
(define-key evil-normal-state-map (kbd "SPC g") 'magit-status)
(define-key evil-normal-state-map (kbd "SPC p b" 'python-black-buffer)
(define-key evil-normal-state-map (kbd "SPC p r" 'python-black-region)
;;; init.el ends here
