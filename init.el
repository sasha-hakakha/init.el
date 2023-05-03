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

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

(unless package-archive-contents
  (package-refresh-contents))

(ensure-package-installed 'use-package 'magit 'helm 'evil 'evil-collection 'monokai-theme 'doom-modeline 'vertico 'company 'company 'eglot 'flycheck 'ccls 'rainbow-delimiters 'yasnippet 'ivy 'counsel 'which-key 'projectile 'counsel-projectile 'popup 'web-mode 'json-reformat 'recentf)

;; evil
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(require 'evil-collection)
(evil-collection-init)

;; Appearence
(load-theme 'monokai t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(require 'doom-modeline)
(doom-modeline-mode 1)
(require 'vertico)
(vertico-mode 1)
(global-linum-mode)
(which-key-mode)
;; Eglot
(require 'eglot)
(add-to-list 'eglot-server-programs '(web-mode . ("typescript-language-server" "--stdio")))
(add-to-list 'eglot-server-programs '(python-mode . ("python" "-m" "lsp")))
(add-hook 'web-mode 'eglot-ensure)
(add-hook 'eglot-managed-mode-hook (lambda ()
				     (company-mode)
                                     (add-to-list (make-local-variable 'company-backends)
                                                 'company-capf)))

;; flycheck
;; (require 'flycheck)

;; recent files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(setq recentf-max-saved-items 25)
(global-set-key (kbd "C-x C-r") 'recentf-open-files)

;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
;; (add-hook 'web-mode 'company-mode)

(setq web-mode-code-indent-offset 2)
(add-hook 'web-mode-hook 'eglot-ensure)


(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
;;  (flycheck-mode +1)
;;  (setq flycheck-check-syntax-automatically '(save mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  (company-mode +1))


(add-hook 'web-mode-hook #'setup-tide-mode)


;; Python
(add-hook 'python-mode-hook 'eglot-ensure)

;; Rust

;; TypeScript and Angular
(add-to-list 'auto-mode-alist '("\\.ts\\'" . web-mode))

 
;; Company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 3
      company-idle-delay 0.1
      company-selection-wrap-around t
      company-tooltip-align-annotations t
      company-require-match 'never)

;; Ivy
(require 'counsel)
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-c r") 'counsel-projectile-rg)
(global-set-key (kbd "C-c f") 'counsel-projectile-find-file)
;; Navigation
(defun open-repos ()
  "Open dired in the ~/repos directory."
  (interactive)
  (dired "~/repos"))
(global-set-key (kbd "C-c R") 'open-repos)

;; terminal
(defun vterm-and-disable-evil ()
  (interactive)
  (vterm)
  (evil-local-mode -1))

(global-set-key (kbd "M-RET") 'vterm-and-disable-evil)


;; tabs/spaces

;; custom set vars
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(flycheck-eglot json-reformat js2-mode dashboard treemacs-all-the-icons treemacs-evil treemacs counsel-projectile which-key counsel swiper ivy eglot flymake-eslint tide flymake vterm vertico use-package rainbow-delimiters monokai-theme magit lsp-ui lsp-treemacs lsp-pyright helm evil-visual-mark-mode evil-collection doom-modeline company ccls)))

(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
