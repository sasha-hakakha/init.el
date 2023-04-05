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

(ensure-package-installed 'use-package 'magit 'helm 'evil 'evil-collection 'monokai-theme 'doom-modeline 'vertico 'company 'lsp-mode 'lsp-ui 'company 'lsp-treemacs 'flymake 'lsp-pyright 'ccls 'rainbow-delimiters)

;; evil
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(require 'evil-collection)
(evil-collection-init)

;; appearence
(load-theme 'monokai t)
(menu-bar-mode -1)
(scroll-bar-mode -1)
(tool-bar-mode -1)
(require 'doom-modeline)
(doom-modeline-mode 1)
(require 'vertico)
(vertico-mode 1)
(global-linum-mode)


;; Python
(add-hook 'python-mode-hook #'lsp-deferred)

;; Rust
(add-hook 'rust-mode-hook #'lsp-deferred)

;; TypeScript and Angular
(add-hook 'typescript-mode-hook #'lsp-deferred)
(add-hook 'web-mode-hook #'lsp-deferred)

;; lsp
(require 'lsp-mode)
(require 'lsp)
(lsp-register-client
 (make-lsp-client :new-connection (lsp-stdio-connection
                                   (lambda ()
                                     (cons "node"
                                           (list (expand-file-name "~/path/to/your/global/node_modules/@angular/language-server")
                                                 "--ngProbeLocations"
                                                 (expand-file-name "~/path/to/your/global/node_modules")
                                                 "--tsProbeLocations"
                                                 (expand-file-name "~/path/to/your/global/node_modules")
                                                 "--stdio"))))
                   :activation-fn (lsp-activate-on "angular")
                   :priority -1
                   :add-on? nil
                   :server-id 'angular-ls))

(require 'lsp-ui)
(setq lsp-ui-sideline-enable t
      lsp-ui-sideline-show-hover t
      lsp-ui-sideline-show-code-actions t
      lsp-ui-peek-enable t)
(add-hook 'lsp-mode-hook 'lsp-ui-mode)


;; Replace "~/path/to/your/global/node_modules" with the actual path to your global node_modules directory.
 
;; company
(require 'company)
(add-hook 'after-init-hook 'global-company-mode)
(setq company-minimum-prefix-length 1
      company-idle-delay 0.0
      company-selection-wrap-around t
      company-tooltip-align-annotations t
      company-require-match 'never)

(defun my/lsp-mode-setup ()
  (setq-local company-backends '((company-capf :with company-yasnippet))))
(add-hook 'lsp-mode-hook 'my/lsp-mode-setup)

;; Flymake
(require 'flymake)
(add-hook 'lsp-mode-hook 'flymake-mode)

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(flymake vterm vertico use-package rainbow-delimiters monokai-theme magit lsp-ui lsp-treemacs lsp-pyright helm evil-visual-mark-mode evil-collection doom-modeline company ccls)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
