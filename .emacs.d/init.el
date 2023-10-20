(setq inhibit-startup-message t)

(setq undo-limit 40000000)
(setq undo-strong-limit 100000000)

(global-hl-line-mode 1)
(set-face-background 'hl-line "khaki4")

(scroll-bar-mode -1)        ; Disable visible scrollbar
(tool-bar-mode -1)          ; Disable the toolbar
(tooltip-mode -1)           ; Disable tooltips
(set-fringe-mode 10)        ; Give some breathing room
(setq-default scroll-preserve-screen-position t)

(menu-bar-mode -1)            ; Disable the menu bar

;; Set up the visible bell
(setq visible-bell t)

;(set-face-attribute 'default nil :font "Fira Code Retina" :height 280)

;; (defun noop-split-window nil)
;; (setq split-window-preferred-function 'noop-split-window)
;; (split-window-horizontally)             


;; Make ESC quit prompts
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)

;; Initialize package sources
(require 'package)

(setq package-archives '(("melpa" . "https://stable.melpa.org/packages/")
                         ("org" . "https://orgmode.org/elpa/")
                         ("elpa" . "https://elpa.gnu.org/packages/")
			 )
      )

(package-initialize)
(unless package-archive-contents
 (package-refresh-contents))

;; Initialize use-package on non-Linux platforms
(unless (package-installed-p 'use-package)
   (package-install 'use-package))

(require 'use-package)
(setq use-package-always-ensure t)
;(package-refresh-contents)

(column-number-mode)
(global-display-line-numbers-mode t)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))

;(use-package command-log-mode)
(use-package swiper)

(use-package ivy
  :diminish
  :bind (("C-s" . swiper)
         :map ivy-minibuffer-map
         ("TAB" . ivy-alt-done)	
         ("C-l" . ivy-alt-done)
         ("C-j" . ivy-next-line)
         ("C-k" . ivy-previous-line)
         :map ivy-switch-buffer-map
         ("C-k" . ivy-previous-line)
         ("C-l" . ivy-done)
         ("C-d" . ivy-switch-buffer-kill)
         :map ivy-reverse-i-search-map
         ("C-k" . ivy-previous-line)
         ("C-d" . ivy-reverse-i-search-kill))
  :config
  (ivy-mode 1))

(use-package rainbow-delimiters
  :hook (prog-mode . rainbow-delimiters-mode))

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

(use-package doom-themes
  :config
  (load-theme 'doom-molokai t)
)


(use-package projectile
  :diminish projectile-mode
  :config (projectile-mode)
  :custom ((projectile-completion-system 'ivy))
  :bind-keymap
  ("C-c p" . projectile-command-map)
  :init
  ;; NOTE: Set this to the folder where you keep your Git repos!
  (when (file-directory-p "~/workspace")
    (setq projectile-project-search-path '("~/workspace")))
  (setq projectile-switch-project-action #'projectile-dired))

(use-package counsel-projectile
  :config (counsel-projectile-mode))

; indentation
(setq-default tab-width 2)
(setq-default indent-tabs-mode nil)

(setq-default c-basic-offset 2)
(setq-default c-elecric-flag t)
(setq-default c-tab-always-indent t)
;(setq-default c-syntactic-indentation nil)

;; Create my personal style.
(defconst my-c-style
  '((c-tab-always-indent        . t)
    (c-comment-only-line-offset . 0)
    (c-basic-offset . 2)
    ;; (c-hanging-braces-alist     . ((substatement-open after)
    ;;                                (brace-list-open)))
    ;; (c-hanging-colons-alist     . ((member-init-intro before)
    ;;                                (inher-intro)
    ;;                                (case-label after)
    ;;                                (label after)
    ;;                                (access-label after)))
    ;; (c-cleanup-list             . (scope-operator
    ;;                                empty-defun-braces
    ;;                                defun-close-semi))
    (c-offsets-alist            . (
                                   ;; (arglist-close . c-lineup-arglist)
                                   (substatement-open . 0)
                                   (block-open        . 0)
                                   (arglist-intro     . ++)
                                   (arglist-close     . 0)
;                                   (arglist-cont-nonempty . t-intro)
                                   (label                 . -2)
                                   ;; (access-label          . -2) 
                                   ;; (substatement-open     .  0) 
                                   (statement-case-intro  .  +)
                                   (statement-block-intro .  +)
                                   (case-label            .  0)
                                   ;; (inline-open           .  0)
                                   ;; (topmost-intro-cont    .  0)
                                   ;; (knr-argdecl-intro     . -4)
                                   (brace-list-open       .  0)
                                   (brace-list-intro      .  2)

                                   ))
    (c-echo-syntactic-information-p . t)
    )
  "My C Programming Style")

(c-add-style "PERSONAL" my-c-style)

(defun my-c-mode-hook ()
  (c-set-style "PERSONAL")

  )

(add-hook 'c-mode-common-hook 'my-c-mode-hook)


(defun my-compilation-mode-hook ()
  (next-error-follow-minor-mode)
  )

(add-hook 'compilation-mode-hook 'my-compilation-mode-hook)


;(setq-default c-default-style "k&r")

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

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(package-selected-packages
   '(counsel-projectile projectile cmake-mode which-key use-package swiper rainbow-delimiters ivy-rich doom-themes)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
