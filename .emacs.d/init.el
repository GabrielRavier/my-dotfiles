(require 'package)
(add-to-list 'package-archives '("melpa" . "https://melpa.org/packages/") t)
;; Comment/uncomment this line to enable MELPA Stable if desired.  See `package-archive-priorities`
;; and `package-pinned-packages`. Most users will not need or want to do this.
;;(add-to-list 'package-archives '("melpa-stable" . "https://stable.melpa.org/packages/") t)
(package-initialize)
(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(column-number-mode t)
 '(company-c-headers-path-system
   '("/usr/include/" "/usr/local/include/" "/usr/lib/gcc/x86_64-redhat-linux/10/include" "/usr/lib/gcc/x86_64-redhat-linux/"))
 '(custom-enabled-themes '(tango-dark))
 '(flycheck-checker-error-threshold 5000)
 '(font-use-system-font t)
 '(package-selected-packages
   '(lsp-haskell haskell-mode go-mode rust-mode default-text-scale treemacs-magit magit ccls lsp-helm lsp-treemacs treemacs which-key yasnippet-snippets yasnippet lsp use-package dap-mode flycheck helm-xref helm-lsp helm company-lsp lsp-mode company-c-headers clang-format company)))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(default ((t (:family "Source Code Pro" :foundry "ADBO" :slant normal :weight normal :height 90 :width normal)))))

(eval-when-compile
  (require 'use-package))

;; Toggle on displaying the current column number in the mode line
(setq column-number-mode t)
(put 'scroll-left 'disabled nil)

;; Adjust gc-cons-threshold for lsp-mode's needs so that the garbage collector doesn't run too often
(setq gc-cons-threshold 100000000)

;; Adjust read-process-output-max, same reason (emacs default is 4k, some LSP servers casually respond with 3MiB)
(setq read-process-output-max (* 1024 1024)) ;; 1 MiB

(use-package company
  :ensure
  :config
  (add-to-list 'company-backends 'company-c-headers)
  (global-company-mode 1))

(use-package lsp-mode
  :ensure
  :after lsp
  :config
  ;; Make lsp start when opening C and C++ files
  (add-hook 'c-mode-hook 'lsp)
  (add-hook 'cpp-mode-hook 'lsp))

(use-package flycheck
  :ensure
  :after lsp
  :config
  (global-flycheck-mode)
  (flycheck-add-next-checker 'lsp 'c/c++-cppcheck))

(use-package yasnippet
  :ensure
  :config
  (yas-global-mode 1))

(use-package helm
  :ensure
  :config
  (helm-mode 1)
  (define-key global-map [remap find-file] #'helm-find-files)
  (define-key global-map [remap execute-extended-command] #'helm-M-x)
  (define-key global-map [remap switch-to-buffer] #'helm-mini)
  (define-key global-map [remap bookmark-jump] #'helm-filtered-bookmarks))

(use-package which-key
  :ensure
  :config
  (which-key-mode))

(use-package lsp-treemacs
  :ensure
  :config
  (lsp-treemacs-sync-mode 1))

(use-package helm-lsp
  :ensure
  :config
  (define-key lsp-mode-map [remap xref-find-apropos] #'helm-lsp-workspace-symbol))

;; Should place a brace that opens an in-class inline method on the same indent level, instead of four spaces in (which is bullshit)
(c-set-offset 'inline-open '0)

;; Setup indentation settings properly
(setq c-default-style "linux"
      c-basic-offset 4
      tab-width 4)
(setq tab-stop-list '(4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80))
(setq-default indent-tabs-mode nil)

(provide 'init)
;;; init.el ends here
(put 'magit-diff-edit-hunk-commit 'disabled nil)

