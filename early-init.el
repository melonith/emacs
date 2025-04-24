(setq gc-cons-threshold (* 100 1024 1024))

(add-hook 'emacs-startup-hook
	  (lambda ()
	    (setq gc-cons-threshold (* 8 1024 1024))))

(when (fboundp 'menu-bar-mode)
  (menu-bar-mode -1))
(when (fboundp 'tool-bar-mode)
  (tool-bar-mode -1))
(when (fboundp 'scroll-bar-mode)
  (scroll-bar-mode -1))

(load-theme 'modus-vivendi t)

(setq inhibit-startup-screen t)
