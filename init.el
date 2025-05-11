;;; init.el ~*~ lexical-binding: t; ~*~

;;; user
(setq user-mail-address "lonniefr@proton.me"
      user-full-name "Lonnie F R")

;;; themes
(defvar my/theme-selection-night t
  "The theme selected number.")

(defun my/toggle-theme ()
  (interactive)
  (if my/theme-selection-night
      (progn
	(load-theme 'modus-vivendi t)
	(setq my/theme-selection-night nil))
    (progn
      (load-theme 'modus-operandi t)
      (setq my/theme-selection-night t))))

(defun my/toggle-window-transparency (arg)
  "Toggle the value of `alpha-background'.
Toggles between 100 and 75 by default. Can choose which value to
if called with ARG, or any prefix argument."
  (interactive "P")
  (let ((transparency (pcase arg
			((pred numberp) arg)
			((pred car) (read-number "Change the transparency to which value (0-100)? "))
			(_
			 (pcase (frame-parameter nil 'alpha-background)
			   (75 100)
			   (100 75)
			   (t 100))))))
    (set-frame-parameter nil 'alpha-background transparency)))

(global-set-key (kbd "C-c a") 'my/toggle-window-transparency)
(global-set-key (kbd "C-c t") 'my/toggle-theme)
;; Set transparency to 75 by default
(my/toggle-window-transparency 75)

(global-set-key (kbd "C-x k") 'kill-current-buffer) ; don't ask to confirm to kill the buffer.

;;; Autocomplete
(fido-mode +1)
(setq tab-always-indent 'complete)

(setq completion-styles `(flex
			  basic
			  partial-completion
			  emacs22
			  substringround
			  initials
			  shorhand)
      completion-auto-select t
      completion-auto-help 'lazy
      completions-format 'one-column
      completions-sort 'historical
      completions-max-height 20
      completion-ignore-case t)
(setq read-buffer-completion-ignore-case t
      read-file-name-completion-ignore-case t)

;;; auto save files and backups
(setq backup-directory-alist `(("." . "~/.saves")))
(setq make-backup-files t
      backup-by-copying t
      delete-old-versions t
      kept-new-versions 6
      kept-old-versions 2
      version-control t
      delete-by-moving-to-trash t
      auto-save-default t
      auto-save-timeout 20
      auto-save-interval 200
      vc-make-backup-files t)

;;; custom file
(setq custom-file (concat user-emacs-directory "custom.el"))

;;; package setup
(require 'package)
(add-to-list 'package-archives
	     '("melpa" . "https://melpa.org/packages/") t)

(unless (package-installed-p 'use-package)
  (package-initialize)
  (package-install 'use-package))

;;; org mode setup
(setq org-hide-emphasis-markers t)

(use-package org-bullets
  :ensure t
  :config
  (add-hook 'org-mode-hook (lambda () (org-bullets-mode 1))))

(add-hook 'org-mode-hook 'visual-line-mode)
(setq initial-major-mode (quote org-mode))
(setq initial-scratch-message nil)
(setq org-startup-indented t)

;;; meow edit
(defun meow-setup ()
  (setq meow-cheatsheet-layout meow-cheatsheet-layout-qwerty)
  (meow-motion-define-key
   '("j" . meow-next)
   '("k" . meow-prev)
   '("<escape>" . ignore))
  (meow-leader-define-key
   ;; Use SPC (0-9) for digit arguments.
   '("1" . meow-digit-argument)
   '("2" . meow-digit-argument)
   '("3" . meow-digit-argument)
   '("4" . meow-digit-argument)
   '("5" . meow-digit-argument)
   '("6" . meow-digit-argument)
   '("7" . meow-digit-argument)
   '("8" . meow-digit-argument)
   '("9" . meow-digit-argument)
   '("0" . meow-digit-argument)
   '("/" . meow-keypad-describe-key)
   '("?" . meow-cheatsheet))
  (meow-normal-define-key
   '("0" . meow-expand-0)
   '("9" . meow-expand-9)
   '("8" . meow-expand-8)
   '("7" . meow-expand-7)
   '("6" . meow-expand-6)
   '("5" . meow-expand-5)
   '("4" . meow-expand-4)
   '("3" . meow-expand-3)
   '("2" . meow-expand-2)
   '("1" . meow-expand-1)
   '("-" . negative-argument)
   '(";" . meow-reverse)
   '("," . meow-inner-of-thing)
   '("." . meow-bounds-of-thing)
   '("[" . meow-beginning-of-thing)
   '("]" . meow-end-of-thing)
   '("a" . meow-append)
   '("A" . meow-open-below)
   '("b" . meow-back-word)
   '("B" . meow-back-symbol)
   '("c" . meow-change)
   '("d" . meow-delete)
   '("D" . meow-backward-delete)
   '("e" . meow-next-word)
   '("E" . meow-next-symbol)
   '("f" . meow-find)
   '("g" . meow-cancel-selection)
   '("G" . meow-grab)
   '("h" . meow-left)
   '("H" . meow-left-expand)
   '("i" . meow-insert)
   '("I" . meow-open-above)
   '("j" . meow-next)
   '("J" . meow-next-expand)
   '("k" . meow-prev)
   '("K" . meow-prev-expand)
   '("l" . meow-right)
   '("L" . meow-right-expand)
   '("m" . meow-join)
   '("n" . meow-search)
   '("o" . meow-block)
   '("O" . meow-to-block)
   '("p" . meow-yank)
   '("q" . meow-quit)
   '("Q" . meow-goto-line)
   '("r" . meow-replace)
   '("R" . meow-swap-grab)
   '("s" . meow-kill)
   '("t" . meow-till)
   '("u" . meow-undo)
   '("U" . meow-undo-in-selection)
   '("v" . meow-visit)
   '("w" . meow-mark-word)
   '("W" . meow-mark-symbol)
   '("x" . meow-line)
   '("X" . meow-goto-line)
   '("y" . meow-save)
   '("Y" . meow-sync-grab)
   '("z" . meow-pop-selection)
   '("'" . repeat)
   '("<escape>" . ignore)))

(use-package meow
  :ensure t
  :config
  (meow-setup)
  (meow-global-mode 1))

(use-package which-key
  :ensure t
  :config
  (which-key-mode 1))

(use-package go-mode
  :ensure t)
