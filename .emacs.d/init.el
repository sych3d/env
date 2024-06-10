;; TODO
;; - window management

;; =====================================================================================
;; General settings

(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(async-shell-command-buffer 'confirm-kill-process)
 '(auto-revert-use-notify t)
 '(completion-ignore-case t)
 '(completion-styles '(substring))
 '(gc-cons-threshold (* 64 1024 1024))
 '(global-auto-revert-mode t)
 '(global-display-line-numbers-mode t)
 '(global-hl-line-mode 1)
 '(inhibit-startup-screen t)
 '(package-selected-packages '(company which-key diminish))
 '(read-process-output-max (* 8 1024 1024) t)
 '(scroll-preserve-screen-position t)
 '(setq-default tab-always-indent)
 '(truncate-lines t)
 '(undo-limit (* 64 1024 1024))
 '(undo-strong-limit (* 128 1024 1024))
 '(use-package-always-ensure t)
 '(visible-bell t))

(set-fringe-mode 10)
(scroll-bar-mode -1)
;; (tool-bar-mode -1)
(tooltip-mode -1)
;; Delete selected text with typing or pasting
(delete-selection-mode 1)
(menu-bar-mode -1)
(tool-bar-mode -1)

(column-number-mode)

(dolist (mode '(org-mode-hook
		term-mode-hook
		shell-mode-hook
		eshell-mode-hook))
  (add-hook mode (lambda () (display-line-numbers-mode 0))))


(dolist (mode '(compilation-mode-hook))
  (add-hook mode (lambda () (custom-set-variables '(truncate-lines nil)))))

;; =====================================================================================
;; Keybindings

(global-set-key (kbd "C-/") 'comment-line)
(global-set-key (kbd "<escape>") 'keyboard-escape-quit)
(global-set-key [mouse-3] nil)

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



;; =====================================================================================
;; Completion


;; =====================================================================================
;; Colors
;; list-colors-display - shows colors

;; (use-package doom-themes
;;   :config
;;   (load-theme 'doom-moonlight t)
;; )

(add-to-list 'default-frame-alist '(font . "Liberation Mono-12"))
(set-face-attribute 'default nil :font "Liberation Mono-12")

;; (add-to-list 'default-frame-alist '(font . "UnifontExMono"))
;; (set-face-attribute 'default nil :font "UnifontExMono" :height 100)

(add-to-list 'default-frame-alist '(foreground-color . "grey90"))
(add-to-list 'default-frame-alist '(background-color . "midnight blue"))
(add-to-list 'default-frame-alist '(cursor-color . "green2"))

(set-face-attribute 'font-lock-keyword-face nil :foreground "grey100" :weight 'bold)
(set-face-attribute 'font-lock-preprocessor-face nil :foreground "yellow" :weight 'bold)

(set-face-attribute 'font-lock-comment-face nil :foreground "grey64")
(set-face-attribute 'font-lock-doc-face nil :foreground "grey64")

(set-face-attribute 'font-lock-function-name-face nil :foreground "LightGoldenrod1")
(set-face-attribute 'font-lock-variable-name-face nil :foreground "LightGoldenrod1")
(set-face-attribute 'font-lock-type-face nil :foreground "LightGoldenrod1")
(set-face-attribute 'font-lock-punctuation-face nil :foreground "grey80")
(set-face-attribute 'font-lock-operator-face nil :foreground "grey90")
(set-face-attribute 'font-lock-regexp-grouping-backslash nil :foreground "grey100" :weight 'bold)

(set-face-attribute 'font-lock-constant-face nil :foreground "LightGoldenrod1")
(set-face-attribute 'font-lock-string-face nil :foreground "khaki")
(set-face-attribute 'font-lock-number-face nil :foreground "LightGoldenrod1")

(set-face-attribute 'line-number nil :foreground "grey90")
(set-face-attribute 'line-number-current-line nil :foreground "grey100" :weight 'bold)

(set-face-attribute 'mode-line nil :foreground "grey90" :background "grey32")
(set-face-attribute 'mode-line-inactive nil :background "grey16")
(set-face-attribute 'region nil :background "grey32")

;; (add-to-list 'default-frame-alist '(font . "Liberation Mono-11.5"))
;; (set-face-attribute 'default t :font "Liberation Mono-11.5")
;; (set-face-attribute 'font-lock-builtin-face nil :foreground "#DAB98F")
;; (set-face-attribute 'font-lock-comment-face nil :foreground "gray50")
;; (set-face-attribute 'font-lock-constant-face nil :foreground "olive drab")
;; (set-face-attribute 'font-lock-doc-face nil :foreground "gray50")
;; (set-face-attribute 'font-lock-function-name-face nil :foreground "burlywood3")
;; (set-face-attribute 'font-lock-keyword-face nil :foreground "DarkGoldenrod3")
;; (set-face-attribute 'font-lock-string-face nil :foreground "olive drab")
;; (set-face-attribute 'font-lock-type-face nil :foreground "burlywood3")
;; (set-face-attribute 'font-lock-variable-name-face nil :foreground "burlywood3")


(set-face-background 'hl-line "#303030")


;; =====================================================================================
;; Dired

(use-package dired
  :ensure nil
  :commands (dired dired-jump)
  :custom ((dired-listing-switches "-agho --group-directories-first"))
  )


;; =====================================================================================
;; Indentation




;; =====================================================================================
;; Optional packages

(use-package diminish)

(use-package which-key
  :init (which-key-mode)
  :diminish which-key-mode
  :config
  (setq which-key-idle-delay 0.5))

;; =====================================================================================
;; Customization

(defun my-backward-kill-word ()
  (interactive)
  (cond 
   ((looking-back (rx (char word)) 1)
    (backward-kill-word 1))
   ((looking-back (rx (char blank)) 1)
    (delete-horizontal-space t))
   (t
    (backward-delete-char 1))))


(defun my-kill-word ()
  (interactive)
  (cond 
   ((looking-at (rx (char word)) 1)
    (kill-word 1))
   ((looking-at (rx (char blank)) 1)
    (delete-horizontal-space nil))
   (t
    (delete-char 1))))


(defun my-home (arg)
  (interactive "^p")
  (message "my home")
  (if (= (current-column) 0)
      (back-to-indentation)
     (move-beginning-of-line arg)
    )
  )

(defun my-split-window (arg)
  (let ((all-windows (window-list nil 0)))
    (if (<= (length all-windows)  1)
	(split-window-horizontally)
      )
    )
  )

(setq split-window-preferred-function 'my-split-window)
;; (split-window-horizontally)  

(global-set-key (kbd "C-<backspace>") 'my-backward-kill-word)
(global-set-key (kbd "C-<delete>") 'my-kill-word)
(global-set-key (kbd "<home>") 'my-home)



;; (defun my-compilation-mode-hook ()
;;   (next-error-follow-minor-mode)
;;   )

;; (add-hook 'compilation-mode-hook 'my-compilation-mode-hook)



;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; LSP

(use-package eglot
  :custom
  (eglot-events-buffer-size 0)
  (eglot-autoshutdown t)
  (eglot-send-changes-idle-time 1)
  (flymake-no-changes-timeout 3)
  :config
  (setq eglot-report-progress nil)
  (add-to-list 'eglot-stay-out-of 'eldoc)
  )

(use-package company
  :config
  (setq company-idle-delay 0.5)
  (setq company-minimum-prefix-length 1)
  )


;; =====================================================================================
;; C-mode

;; Create my personal style.
(defconst my-c-style
  '((c-tab-always-indent . t)
    (c-basic-offset . 2)
    (c-elecric-flag . t)
    (c-echo-syntactic-information-p . t)
    (c-offsets-alist            . (
                                   (innamespace . +)
                                   (defun-block-intro . +)
                                   (block-open        . 0)
                                   (arglist-intro     . ++)
                                   (arglist-close     . 0)
                                   (label                 . -2)
                                   (statement-case-intro  .  +)
                                   (statement-block-intro .  +)
                                   (case-label            .  +)
                                   (brace-list-open       .  0)
                                   (brace-list-intro      .  +)
                                   )
                                ))
  "My C Programming Style")
(c-add-style "PERSONAL" my-c-style)

(defun my-check-file-name-exts (file-name exts)
  (let ((result)
        (file-ext (downcase (file-name-extension file-name)))
        )
    (dolist (ext exts result)
      (if (string= file-ext ext)
          (setq result t)))
    result))


(defun my-c-header-p (file-name)
  (my-check-file-name-exts file-name '("h" "hh" "hpp")))

(defun my-c-src-p (file-name)
  (my-check-file-name-exts file-name '("c" "cc" "cpp")))

(defun my-replace-ext (file-name new-ext)
  (concat (file-name-sans-extension file-name) "." new-ext)
  )

(defun my-c-get-other-file-name (file-name)
  (let ((candidate-extensions '())
        (result)
        )
    (pcase file-name
      ((pred my-c-header-p) (setq candidate-extensions '("cpp" "cc" "c" "C")))
      ((pred my-c-src-p) (setq candidate-extensions '("h" "hh" "hpp"))))
     (dolist (candidate-extension candidate-extensions result)
       (let ((candidate-file-name (my-replace-ext file-name candidate-extension)))
         (if (file-exists-p candidate-file-name)
             (setq result candidate-file-name)
           )
         )
      )
    result
    )
  )

(defun my-c-find-other-file ()
  (interactive)
  (let ((other-file-name (my-c-get-other-file-name buffer-file-name)))
        (if other-file-name
            (find-file other-file-name)
          )))

(defun my-find-file-rec (dir file-name)
  (if dir
      (let ((full-file-name (concat (file-name-as-directory dir) file-name))
            (next-dir (file-name-directory (directory-file-name dir))))
        (if (file-exists-p full-file-name)
            full-file-name
          (if (not (string= dir next-dir))
              (my-find-file-rec next-dir file-name)
            nil
            )
          )
        )
    nil
    )
  )

(defun my-build ()
  (interactive)
  
  (let ((build-script-path (my-find-file-rec (file-name-directory buffer-file-name) "ll_build.sh")))
    (if build-script-path
        (let ((default-directory (file-name-directory build-script-path))) 
          (compile build-script-path))
      )
    )
  )

(defun my-run ()
  (interactive)
  
  (let ((run-script-path (my-find-file-rec (file-name-directory buffer-file-name) "ll_run.sh")))
    (if run-script-path
        (async-shell-command run-script-path "ll-run"))
    )
  )

(defun my-c-mode-common-hook ()
  (c-set-style "PERSONAL")
  (local-set-key (kbd "C-c k o") 'my-c-find-other-file)
  (local-set-key (kbd "C-b") 'my-build)
  (local-set-key (kbd "<f5>") 'my-run)
  (eglot-ensure)
  (company-mode 1)
  )

(add-hook 'c-mode-common-hook 'my-c-mode-common-hook)
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
