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

(unless (package-installed-p 'quelpa)
  (with-temp-buffer
    (url-insert-file-contents "https://raw.githubusercontent.com/quelpa/quelpa/master/quelpa.el")
    (eval-buffer)
    (quelpa-self-upgrade)))
(require 'quelpa)

(unless (package-installed-p 'quelpa-use-package)
  (quelpa
   '(quelpa-use-package
     :fetcher git
     :url "https://framagit.org/steckerhalter/quelpa-use-package.git")))
(require 'quelpa-use-package)
  ;; (package-initialize)

(defun ensure-package-installed (&rest packages)
  "Assure every package is installed, ask for installation if it’s not.

Return a list of installed packages or nil for every skipped package."
  (package-refresh-contents)
  (mapcar
   (lambda (package)
     (if (package-installed-p package)
         nil
       (if (y-or-n-p (format "Package %s is missing. Install it? " package))
           (package-install package)
         package)))
   packages))

(ensure-package-installed 'use-package 'magit 'helm 'evil 'evil-collection 'monokai-theme 'doom-modeline 'vertico 'company 'company 'eglot 'flycheck 'ccls 'rainbow-delimiters 'yasnippet 'ivy 'counsel 'which-key 'projectile 'counsel-projectile 'popup 'web-mode 'json-reformat 'web-beautify 'vterm 'rust-mode 'helpful 'smartparens 'undo-tree 'ibuffer-projectile 'evil-snipe 'frog-jump-buffer 'evil-easymotion 'evil-lion 'org-gcal 's 'dash 'editorconfig)

;; evil
(setq evil-want-keybinding nil)
(require 'evil)
(evil-mode 1)
(require 'evil-collection)
(evil-collection-init)
(require 'evil-snipe)
(evil-snipe-mode +1)
(evil-snipe-override-mode +1)
(evilem-default-keybindings "SPC")
(evil-lion-mode +1)

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
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
(global-visual-line-mode)

;; ;; org
;; ;; defines google-client-id google-client-secret google-calendar-id 
;; (load-file "~/dotfiles/keys.el")
;; (require 'plstore)
;; (add-to-list 'plstore-encrypt-to '(gpg-key-id))
;; (load-file "~/dotfiles/google_auth.el")
;; (require 'org-gcal)
;; (setq org-gcal-client-id google-client-id
;;       org-gcal-client-secret google-client-secret
;;       org-gcal-file-alist '(("sasha.hakakha@dat.com" . "~/.emacs.d/gcal.org")))


(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(frog-jump-buffer-current-buffer-face ((t (:foreground "#ABB2BF" :background "#282C34"))))
 '(frog-jump-buffer-heading-face ((t (:foreground "#ABB2BF" :background "#282C34"))))
 '(frog-jump-buffer-visible-buffer-face ((t (:foreground "#ABB2BF" :background "#282C34")))))

;; ;; ;; Copilot
;; (load-file "~/.emacs.d/copilot.el")
;; (require 'copilot)
;; (add-hook 'prog-mode-hook 'copilot-mode)


(defun reload-init-file ()
  
  (interactive)
  (load-file "~/.emacs.d/init.el"))
(evil-define-key 'normal global-map (kbd "SPC s c") 'reload-init-file)

;; movement
(defun evil-window-split-and-switch ()
  "Split the window vertically and switch to the new buffer."
  (interactive)
  (evil-window-split)
  (other-window 1))

(defun evil-window-vsplit-and-switch ()
  "Split the window horizontally and switch to the new buffer."
  (interactive)
  (evil-window-vsplit)
  (other-window 1))



;; Define functions for non-Evil key bindings
(defun window-split-and-switch ()
  (interactive)
  (split-window-below)
  (other-window 1))

(defun window-vsplit-and-switch ()
  (interactive)
  (split-window-right)
  (other-window 1))

;; Non-Evil keybinding

(defun equalize-buffer-sizes ()
  "Makes all open buffers the same size."
  (interactive)
  (let ((buffers (buffer-list))
        (num-buffers (count-windows)))
    (delete-other-windows)
    (dotimes (i num-buffers)
      (split-window-horizontally))
    (balance-windows)))

(evil-define-key 'normal global-map (kbd "SPC w e") 'equalize-buffer-sizes)

;; buffers
;;(use-package ibuffer
;;  :ensure t
;;  :bind ("C-x C-b" . ibuffer))

(use-package ibuffer-projectile
  :ensure t
  :config
  (add-hook 'ibuffer-hook
            (lambda ()
              (ibuffer-projectile-set-filter-groups)
              (unless (eq ibuffer-sorting-mode 'alphabetic)
                (ibuffer-do-sort-by-alphabetic)))))

;; git
(setq magit-display-buffer-function #'magit-display-buffer-same-window-except-diff-v1)
(evil-define-key 'normal global-map (kbd "SPC g") 'magit-status)

;; typing behavior (?)
(use-package smartparens
  :ensure t
  :config
  (require 'smartparens-config)
  (smartparens-global-mode t)
  (show-smartparens-global-mode t))

;; Eglot
(require 'eglot)
;;(require 'lsp-eslint)

;;(add-to-list 'eglot-server-programs '(web-mode  eglot-eslint "eslint" "--stdin" "--stdin-filename" "%s"))
(add-to-list 'eglot-server-programs '(rust-mode . ("~/.local/bin/rust-analyzer")))
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


(require 'typescript-mode)
(add-hook 'typescript-mode-hook #'setup-tide-mode)

(defun setup-tide-mode ()
  (interactive)
  (tide-setup)
  (flycheck-mode +1)
  (setq flycheck-check-syntax-automatically '(idle-change mode-enabled))
  (eldoc-mode +1)
  (tide-hl-identifier-mode +1)
  ;; company is an optional dependency. You have to
  ;; install it separately via package-install
  ;; `M-x package-install [ret] company`
  (company-mode +1))

(defun my-ts-mode-hook ()
  (setq-default tab-width 2)
  (setq-default typescript-indent-level 2)
  (setq-default indent-tabs-mode nil)
  (setup-tide-mode))

(add-hook 'typescript-mode-hook #'my-ts-mode-hook)

;; Python
(add-hook 'python-mode-hook 'eglot-ensure)

;; Rust
(require 'rust-mode)
(add-hook 'rust-mode-hook 'eglot-ensure)
;; TypeScript and Angular
;; (add-to-list 'auto-mode-alist '("\\.ts\\'" . typescript-mode))
(add-to-list 'auto-mode-alist '("\\.rs\\'" . rust-mode))

 
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


;; Navigation
(defun open-repos ()
  "Open dired in the ~/repos directory."
  (interactive)
  (dired "~/repos"))

;; terminal
(defun vterm-and-disable-evil ()
  (interactive)
  (vterm)
  (evil-local-mode -1))

(global-set-key (kbd "M-RET") 'vterm-and-disable-evil)

;; auto-save
(setq auto-save-default t)
(setq auto-save-interval 300) ;; Save every 300 characters typed
(setq auto-save-timeout 30)    ;; Save after 30 seconds of idle time

;; 
(use-package helpful
  :ensure t
  :bind (("C-h f" . helpful-callable)
         ("C-h v" . helpful-variable)
         ("C-h k" . helpful-key)))
;; chatgpt
(load "~/dotfiles/chatgpt.el")
(setq chatgpt-shell-openai-key chatgpt-key)
(defun chatgpt-and-disable-evil ()
  (interactive)
  (chatgpt-shell)
  (evil-local-mode -1))

(global-set-key (kbd "C-c q") 'chatgpt-and-disable-evil)

 ;; :bind ("C-c q" . chatgpt-query))

;; mac
(if (eq system-type 'darwin)
    (lambda()
    (setq mac-command-modifier 'none)
    (setq mac-option-modifier) 'meta))

;; big files
(defun big-file ()
  "Disable specific modes."
  (interactive)
  (when (bound-and-true-p linum-mode)
    (linum-mode -1))
  (when (bound-and-true-p visual-line-mode)
    (visual-line-mode -1))
  ;; Add more modes to disable here. Use the pattern:
  ;; (when (bound-and-true-p your-mode)
  ;;   (your-mode -1))
  )

;; eVIl bindings
(evil-define-key 'normal global-map (kbd "SPC s s") 'save-buffer)
(evil-define-key 'normal global-map (kbd "SPC !") 'abort-recursive-edit)
(evil-define-key 'normal global-map (kbd "SPC f f")  'find-file)

(evil-define-key 'normal global-map (kbd "SPC w n j") 'evil-window-split-and-switch)
(evil-define-key 'normal global-map (kbd "SPC w n k") 'evil-window-split-and-switch)
(evil-define-key 'normal global-map (kbd "SPC w n h") 'evil-window-vsplit-and-switch)
(evil-define-key 'normal global-map (kbd "SPC w n l") 'evil-window-vsplit-and-switch)
(evil-define-key 'normal global-map (kbd "SPC w h") 'evil-window-left)
(evil-define-key 'normal global-map (kbd "SPC w j") 'evil-window-down)
(evil-define-key 'normal global-map (kbd "SPC w k") 'evil-window-up)
(evil-define-key 'normal global-map (kbd "SPC w l") 'evil-window-right)
(evil-define-key 'normal global-map (kbd "SPC w w") 'delete-window)
(evil-define-key 'normal global-map (kbd "SPC w q") 'delete-window)
(evil-define-key 'normal global-map (kbd "SPC w b") 'balance-windows)

(evil-define-key 'normal global-map (kbd "SPC SPC") 'frog-jump-buffer)

(with-eval-after-load 'tide
  (evil-define-key 'normal global-map (kbd "SPC m R") 'tide-restart-server)
  (evil-define-key 'normal global-map (kbd "SPC m r s") 'tide-rename-symbol)
  (evil-define-key 'normal global-map (kbd "SPC m r f") 'tide-rename-file)
  (evil-define-key 'normal global-map (kbd "SPC m f") 'tide-format))

(evil-define-key 'normal global-map (kbd "SPC c p")  'counsel-projectile-switch-project)
(evil-define-key 'normal global-map (kbd "SPC c f")  'counsel-projectile-find-file)
(evil-define-key 'normal global-map (kbd "SPC c r")  'counsel-projectile-rg)

(evil-define-key 'normal global-map (kbd "SPC R")  'open-repos)

(evil-define-key 'normal global-map (kbd "SPC F")  'toggle-frame-fullscreen)

(evil-define-key 'normal global-map (kbd "SPC B")  'big-file)

;; non-evil bindings
(global-set-key (kbd "M-x") 'counsel-M-x)
(global-set-key (kbd "C-c r") 'counsel-projectile-rg)
(global-set-key (kbd "C-c f") 'counsel-projectile-find-file)
(global-set-key (kbd "C-c p") 'counsel-projectile-switch-project)
(global-set-key (kbd "C-c w n j") 'window-split-and-switch)
(global-set-key (kbd "C-c w n k") 'window-split-and-switch)
(global-set-key (kbd "C-c w n h") 'window-vsplit-and-switch)
(global-set-key (kbd "C-c w n l") 'window-vsplit-and-switch)
(global-set-key (kbd "C-c w h") 'windmove-left)
(global-set-key (kbd "C-c w j") 'windmove-down)
(global-set-key (kbd "C-c w k") 'windmove-up)
(global-set-key (kbd "C-c w l") 'windmove-right)
(global-set-key (kbd "C-c w w") 'delete-window)

(global-set-key (kbd "C-c R") 'open-repos)

(global-set-key (kbd "C-x g") 'magit-status)

(global-set-key (kbd "C-c F") 'toggle-frame-fullscreen)
;; tabs/spaces
(setq make-backup-files nil)
;; custom set vars
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   '("3e200d49451ec4b8baa068c989e7fba2a97646091fd555eca0ee5a1386d56077" "42abd324628cb258bb8bbb1fc8ebcd4920f6681f616eb1ac80c6f8853258c595" "21055a064d6d673f666baaed35a69519841134829982cbbb76960575f43424db" "3325e2c49c8cc81a8cc94b0d57f1975e6562858db5de840b03338529c64f58d1" "d89e15a34261019eec9072575d8a924185c27d3da64899905f8548cbd9491a36" "f681100b27d783fefc3b62f44f84eb7fa0ce73ec183ebea5903df506eb314077" "d80952c58cf1b06d936b1392c38230b74ae1a2a6729594770762dc0779ac66b7" "b1a691bb67bd8bd85b76998caf2386c9a7b2ac98a116534071364ed6489b695d" "78e6be576f4a526d212d5f9a8798e5706990216e9be10174e3f3b015b8662e27" "fb83a50c80de36f23aea5919e50e1bccd565ca5bb646af95729dc8c5f926cbf3" default))
 '(helm-minibuffer-history-key "M-p")
 '(package-selected-packages
   '(vlf molokai-theme ayu-theme fireplace jdee solarized-theme org-gcal evil-lion frog-jump-buffer free-keys evil-easymotion evil-snipe gruvbox-theme dracula-theme chatgpt-shell quelpa-use-package quelpa ibuffer-projectile undo-tree smartparens helpful monokai-pro-theme company-box rust-mode flycheck-eglot json-reformat js2-mode dashboard treemacs-all-the-icons treemacs-evil treemacs counsel-projectile which-key counsel swiper ivy eglot flymake-eslint tide flymake vterm vertico use-package rainbow-delimiters monokai-theme magit lsp-ui lsp-treemacs lsp-pyright helm evil-visual-mark-mode evil-collection doom-modeline company ccls)))


