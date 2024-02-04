(defun ll-get-other-file-name (file-name)
  (let (
        (ext (file-name-extension file-name))
        (stem (file-name-sans-extension file-name))
        (candidate-extensions)
        (result)
        (src-ext '("c" "cc" "cpp" "C"))
        (hdr-ext '("h" "hh" "hpp"))
        )

    (pcase ext
      ("h" (setq candidate-extensions src-ext))
      ("hh" (setq candidate-extensions src-ext))
      ("hpp" (setq candidate-extensions src-ext))
      ("c" (setq candidate-extensions hdr-ext))
      ("cc" (setq candidate-extensions hdr-ext))
      ("cpp" (setq candidate-extensions hdr-ext))
      ("C" (setq candidate-extensions hdr-ext))
      (_ nil)
      )
    
    (dolist (candidate-extension candidate-extensions result)
       (let ((candidate-file-name (concat stem "." candidate-extension)))
         (if (file-exists-p candidate-file-name)
             (setq result candidate-file-name)
           )
         )
      )
    result
    )
  )

(defun ll-find-other-file ()
  (interactive)
  (let ((other-file-name (ll-get-other-file-name buffer-file-name)))
        (if other-file-name
            (find-file other-file-name)
          )
        )
  )

(defun ll-find-file-rec (dir file-name)
  (if dir
      (let ((full-file-name (concat (file-name-as-directory dir) file-name))
            (next-dir (file-name-directory (directory-file-name dir))))
        (if (file-exists-p full-file-name)
            full-file-name
          (if (not (string= dir next-dir))
              (ll-find-file-rec next-dir file-name)
            nil
            )
          )
        )
    nil
    )
  )

(defun ll-build ()
  (interactive)
  
  (let ((build-script-path (ll-find-file-rec (file-name-directory buffer-file-name) "ll_build.sh")))
    (if build-script-path
        (let ((default-directory (file-name-directory build-script-path))) 
          (compile build-script-path))
      )
    )
  )

(setq-default async-shell-command-buffer 'confirm-kill-process)

(defun ll-run ()
  (interactive)
  
  (let ((run-script-path (ll-find-file-rec (file-name-directory buffer-file-name) "ll_run.sh")))
    (if run-script-path
        (async-shell-command run-script-path "ll-run"))
    )
  )


;; (file-name-concat "1" "2")

;; (file-name-directory "/")

(global-set-key (kbd "C-b") 'll-build)
(global-set-key (kbd "<f5>") 'll-run)


(defun ll-c-mode-hook ()
   (local-set-key (kbd "C-c k o") 'll-find-other-file)
  )

(add-hook 'c-mode-common-hook 'll-c-mode-hook)



;; (let (
;;         (src-ext '(".c" ".cc" ".cpp" ".C"))
;;         (hdr-ext '(".h" ".hh" ".hpp"))
;;         )
;;   (member ".cpp" src-ext))
 

;; (setq test-file-names '(
;;                         "/home/lenny/workspace/phys2d/src/ph2d_engine/CMakeLists.txt"
;;                         "/home/lenny/workspace/phys2d/src/ph2d_engine/ph2d_visualizer.cpp"
;;                         "/home/lenny/workspace/phys2d/src/ph2d_engine/ph2d_engine.hh"
;;                         )
;;       )
                      
;; (dolist (file-name test-file-names)
;;   (message "File name: %s other file name %s" file-name (ll-get-other-file-name file-name)))

;; (ll-get-other-file-name "test.c")
;; (message (ll-get-other-file-name "test.h"))


;; (buffer-file-name)
;; (file-name-extension buffer-file-name)

