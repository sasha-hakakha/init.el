(require 'package)
   (add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
   ;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
   ;; and `package-pinned-packages`. Most users will not need or want to do this.
   ;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
   (package-initialize)

   ;; Set up package.el to work with MELPA
   (require 'package)
   (add-to-list 'package-archives
		             '("melpa" . "https://melpa.org/packages/") t)
   (package-initialize)
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
   (load-theme 'monokai)
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
   '("f4cdc8dea941e3c7e92b907e62cdc03e0483a350b738a43c2e118ce6be9880a6" "830596655dc39879096d9b7772768de6042fb5a4293c6b90c98a9b98bce96e4a" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "02f57ef0a20b7f61adce51445b68b2a7e832648ce2e7efb19d217b6454c1b644" "05626f77b0c8c197c7e4a31d9783c4ec6e351d9624aa28bc15e7f6d6a6ebd926" "60ada0ff6b91687f1a04cc17ad04119e59a7542644c7c59fc135909499400ab8" default))
 '(package-selected-packages
   '(moe-theme rust-mode melancholy-theme monokai-theme corfu affe use-package fireplace vertico circe-notifications magit vterm helpful evil doom-modeline company circe evil-magit bind-key)))
   
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

(setq-default indent-tabs-mode nil)
(setq-default tab-width 4)
(setq indent-line-function 'insert-tab)

(setq c-basic-offset 4)

(load-file "~/.emacs.d/evil-magit.el")

(require 'evil-magit)

;;company

(setq company-idle-delay 0)
(setq company-minimum-prefix-lenth 0)

(use-package company-box
  :hook (company-mode . company-box-mode))

(load-file "~/.emacs.d/company-clang.el")

