;; TODO
;; - completion
;; - project management
;; - lsp
;; - C++ style
;; - TAB always tabs

;; =====================================================================================
;; General settings

(setq inhibit-startup-message t)
(set-fringe-mode 10)
(scroll-bar-mode -1)
;; (tool-bar-mode -1)
(tooltip-mode -1)
;; Make scroll behavior more normal
(setq-default scroll-preserve-screen-position t)
;; Delete selected text with typing or pasting
(delete-selection-mode 1)
(menu-bar-mode -1)
(setq visible-bell t)

(setq undo-limit (* 64 1024 1024))
(setq undo-strong-limit (* 128 1024 1024))

(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;; =====================================================================================
;; Keybindings

(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; =====================================================================================
;; Package sources

(setq package-archives '(("melpa" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 )
      )

(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))
(setq use-package-always-ensure t)

;; =====================================================================================
;; Completion
;(setq completion-ignore-case t)
;(setq completions-sort t)
(setq completion-styles '(flex))


;; =====================================================================================
;; Colors

(global-hl-line-mode 1)

(use-package doom-themes
  :config
  (load-theme 'doom-molokai t)
)

;; My theme
;; (add-to-list 'default-frame-alist '(foreground-color . "ivory2"))
;; (add-to-list 'default-frame-alist '(background-color . "#101040"))
;; (add-to-list 'default-frame-alist '(cursor-color . "green yellow"))

;; (set-face-attribute 'font-lock-comment-face nil :foreground "ivory4")
;; (set-face-attribute 'font-lock-function-name-face nil :foreground "OliveDrab2")
;; (set-face-attribute 'font-lock-variable-name-face nil :foreground "gold2")
;; (set-face-attribute 'font-lock-keyword-face nil :foreground "firebrick1")
;; (set-face-attribute 'font-lock-type-face nil :foreground "OliveDrab2")
;; (set-face-attribute 'font-lock-constant-face nil :foreground "gold2")
;; (set-face-attribute 'font-lock-function-name-face nil :foreground "OliveDrab2")
;; (set-face-attribute 'font-lock-preprocessor-face nil :foreground "gold1" :weight 'bold)
;; (set-face-attribute 'font-lock-string-face nil :foreground "gold2")
;; (set-face-attribute 'font-lock-punctuation-face nil :foreground "magenta2")
;; (set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground "gold1" :weight 'bold)
;; (set-face-attribute 'font-lock-number-face nil :foreground "ivory2")
;; (set-face-attribute 'font-lock-operator-face nil :foreground "ivory2")

(set-face-background 'hl-line "#203550")

(add-to-list 'default-frame-alist '(font . "UnifontExMono"))
(set-face-attribute 'default nil :font "UnifontExMono" :height 110)

;; =====================================================================================
;; Dired

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  )


;; =====================================================================================
;; Indentation

(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)


;; =====================================================================================

;; Optional packages

(use-package diminish)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

;; (use-package swiper)

;; (use-package ivy
;;   :diminish
;;   :bind (("C-s" . swiper)
;;          :map ivy-minibuffer-map
;;          ("TAB" . ivy-alt-done)	
;;          ("C-l" . ivy-alt-done)
;;          ("C-j" . ivy-next-line)
;;          ("C-k" . ivy-previous-line)
;;          :map ivy-switch-buffer-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-l" . ivy-done)
;;          ("C-d" . ivy-switch-buffer-kill)
;;          :map ivy-reverse-i-search-map
;;          ("C-k" . ivy-previous-line)
;;          ("C-d" . ivy-reverse-i-search-kill))
;;   :config
;;   (ivy-mode 1))

;; (use-package rainbow-delimiters
;;   :hook (prog-mode . rainbow-delimiters-mode))




;; (use-package projectile
;;   :diminish projectile-mode
;;   :config (projectile-mode)
;;   :custom ((projectile-completion-system 'ivy))
;;   :bind-keymap
;;   ("C-c p" . projectile-command-map)
;;   :init
;;   ;; NOTE: Set this to the folder where you keep your Git repos!
;;   (when (file-directory-p "~/workspace")
;;     (setq projectile-project-search-path '("~/workspace")))
;;   (setq projectile-switch-project-action #'projectile-dired))

;; (use-package counsel-projectile
;;   :config (counsel-projectile-mode))


;; (setq-default c-basic-offset 2)
;; (setq-default c-elecric-flag t)
;; (setq-default c-tab-always-indent t)
;; ;(setq-default c-syntactic-indentation nil)

;; ;; Create my personal style.
;; (defconst my-c-style
;;   '((c-tab-always-indent        . t)
;;     (c-comment-only-line-offset . 0)
;;     (c-basic-offset . 2)
;;     ;; (c-hanging-braces-alist     . ((substatement-open after)
;;     ;;                                (brace-list-open)))
;;     ;; (c-hanging-colons-alist     . ((member-init-intro before)
;;     ;;                                (inher-intro)
;;     ;;                                (case-label after)
;;     ;;                                (label after)
;;     ;;                                (access-label after)))
;;     ;; (c-cleanup-list             . (scope-operator
;;     ;;                                empty-defun-braces
;;     ;;                                defun-close-semi))
;;     (c-offsets-alist            . (
;;                                    ;; (arglist-close . c-lineup-arglist)
;;                                    (substatement-open . 0)
;;                                    (block-open        . 0)
;;                                    (arglist-intro     . ++)
;;                                    (arglist-close     . 0)
;; ;                                   (arglist-cont-nonempty . t-intro)
;;                                    (label                 . -2)
;;                                    ;; (access-label          . -2) 
;;                                    ;; (substatement-open     .  0) 
;;                                    (statement-case-intro  .  +)
;;                                    (statement-block-intro .  +)
;;                                    (case-label            .  +)
;;                                    ;; (inline-open           .  0)
;;                                    ;; (topmost-intro-cont    .  0)
;;                                    ;; (knr-argdecl-intro     . -4)
;;                                    (brace-list-open       .  0)
;;                                    (brace-list-intro      .  2)

;;                                    ))
;;     (c-echo-syntactic-information-p . t)
;;     )
;;   "My C Programming Style")

;; (c-add-style "PERSONAL" my-c-style)

;; (defun my-c-mode-hook ()
;;   (c-set-style "PERSONAL")

;;   )

;; (add-hook 'c-mode-common-hook 'my-c-mode-hook)


;; (defun my-compilation-mode-hook ()
;;   (next-error-follow-minor-mode)
;;   )

;; (add-hook 'compilation-mode-hook 'my-compilation-mode-hook)


;; (load "/home/lenny/workspace/env/.emacs.d/myfuncs")



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP


;; (use-package lsp-mode
;;   :commands (lsp lsp-deferred)
;;   :init
;;   (setq lsp-keymap-prefix "C-c l")
;;   :config
;;   (lsp-enable-which-key-integration t))

;; (use-package yasnippet)
;; (use-package flycheck)
;; (use-package dap-mode)
;; (use-package company)


;; ;; (add-hook 'c-mode-hook 'lsp-deferred)
;; ;; (add-hook 'c++-mode-hook 'lsp-deferred)

;; (add-hook 'c-mode-hook 'lsp)
;; (add-hook 'c++-mode-hook 'lsp)

;; (setq gc-cons-threshold (* 100 1024 1024)
;;       read-process-output-max (* 1024 1024)
;;       treemacs-space-between-root-nodes nil
;;       company-idle-delay 0.0
;;       company-minimum-prefix-length 1
;;       lsp-idle-delay 0.1)  ;; clangd is fast

;; (with-eval-after-load 'lsp-mode
;;   (add-hook 'lsp-mode-hook #'lsp-enable-which-key-integration)
;;   (require 'dap-cpptools)
;;   (yas-global-mode))

;; (use-package lsp-ivy :commands lsp-ivy-workspace-symbol)
;; (use-package lsp-treemacs :commands lsp-treemacs-errors-list)


; TODO make a function to configure C mode
;(define-key c-mode-base-map "\t" 'self-insert-command)

;(electric-indent-mode -1)

;; (require 'cc-mode)
;; (add-to-list 'c-mode-common-hook
;;   (lambda () (setq c-syntactic-indentation nil)))



;(use-package councel
;  :bind (("M-x" . councel-M-x)
;	 ("C-x b" . councel-ibuffer)
;	 ("C-x C-f" . councel-find-file)
;	 :map minibuffer-local-map
;	 ("C-r" . 'councel-minibuffer-history))
;  :config
;  (setq ivy-initial-inputs-alist nil))


;(use-package ivy-rich
;  :init
;  (ivy-rich-mode 1))

;(use-package councel
;  :bind (("M-x" . councel-M-x)
;	 ("C-x b" . councel-ibuffer)
;	 ("C-x C-f" . councel-find-file)
;	 :map minibuffer-local-map
;	 ("C-r" . 'councel-minibuffer-history))
;  :config
;  (setq ivy-initial-inputs-alist nil))

;; ;; (defun noop-split-window nil)
;; ;; (setq split-window-preferred-function 'noop-split-window)
;; ;; (split-window-horizontally)             

;; =====================================================================================


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(dired-single dired counsel-projectile projectile cmake-mode which-key use-package swiper rainbow-delimiters ivy-rich doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
