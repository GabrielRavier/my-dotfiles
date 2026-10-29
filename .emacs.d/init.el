;; Pray.
(setq debug-on-error t)

(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-enabled-themes '(tango-dark))
 '(font-use-system-font t)
 '(package-selected-packages
   '(haskell-mode go-mode rust-mode treemacs-magit magit treemacs yasnippet-snippets yasnippet helm-xref helm)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 90 :width normal)))))

;; Yes I'm happy to scroll horizontally lmao
(put 'scroll-left 'disabled nil)

;; Yes I'm happy to do this magit
(put 'magit-diff-edit-hunk-commit 'disabled nil)

;; Toggle on displaying the current column number in the mode line
(column-number-mode 1)

;; Adjust read-process-output-max (emacs default is 64k, some LSP servers casually respond with 3MiB)
(setq read-process-output-max (* 512 1024)) ;; 512k

(use-package yasnippet
  :ensure
  :config
  (yas-global-mode 1))
(use-package yasnippet-snippets :ensure :after yasnippet)

(use-package helm
  :ensure
  :config
  (helm-mode 1)
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini)
  (define-key global-map [remap bookmark-jump] #'helm-filtered-bookmarks))

(use-package helm-xref :ensure :after helm)

(use-package which-key
  :config
  (which-key-mode))

;; Should place a brace that opens an in-class inline method on the same indent level, instead of four spaces in (which is bullshit)
(c-set-offset 'inline-open '0)

;; Setup indentation settings properly
(setq c-default-style "linux"
      c-basic-offset 4)
(setq-default tab-width 4
              indent-tabs-mode nil)

;; Make it so that tilde files are instead saved in a consistent directory instead of right next to the file I'm editing
(setq backup-directory-alist `(("." . "~/.emacs.d/tilde-file-backups-directory")))

(setq delete-old-versions t ;; Don't ask me every time emacs wants to delete excess backups
      kept-new-versions 10 ;; Number of newest versions to keep
      version-control t ;; Use version numbers for backups
      backup-by-copying t ;; Copy files instead of renaming them when doing a backup
      vc-make-backup-files t) ;; VCS doesn't preclude Emacs's backups

(provide 'init)
;;; init.el ends here

