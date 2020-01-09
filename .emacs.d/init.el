;;(load-file "/home/ggt/src/cedet-1.1/common/cedet.el")
;;(global-ede-mode 1)                      ; Enable the Project management system
;;(semantic-load-enable-code-helpers)      ; Enable prototype help and smart completion 
;;(global-srecode-minor-mode 1)            ; Enable template insertion menu

;; Adding ~/.emacs.d/elisp directory to load path
(add-to-list 'load-path "/home/golde/.emacs.d/dictionaries")
(add-to-list 'load-path "/home/golde/.emacs.d/elisp/julia")
(add-to-list 'load-path "/home/golde/.emacs.d/elisp/leim")


;; JDEE for java programming
(add-to-list 'load-path "~/.emacs.d/jdee-2.4.1/lisp")
;; (load "jde")

;; load cl-macs
(require 'cl)

;; ELPHA
;; make it easy to install packages
(load "package")
(package-initialize)
(add-to-list 'package-archives
             '("marmalade" . "http://marmalade-repo.org/packages/"))
(add-to-list 'package-archives
             '("melpa" . "http://melpa.milkbox.net/packages/") t)
(add-to-list 'package-archives '("org" . "http://orgmode.org/elpa/") t)

(setq package-archive-enable-alist '(("melpa" deft magit)))

;; Default packages
(defvar abedra/packages '(ac-slime
                          auto-complete
                          autopair
                          clojure-mode
                          clojure-test-mode
                          coffee-mode
                          csharp-mode
                          deft
                          erlang
                          feature-mode
                          flycheck
                          gist
                          go-mode
                          graphviz-dot-mode
                          haml-mode
                          haskell-mode
													highlight-parentheses
                          htmlize
                          magit
                          markdown-mode
                          marmalade
                          nodejs-repl
                          nrepl
                          o-blog
                          org
                          paredit
                          php-mode
                          puppet-mode
                          restclient
                          rvm
                          scala-mode
                          smex
                          sml-mode
                          web-mode
                          writegood-mode
                          yaml-mode
			  auctex
			  neotree)
  "Default packages")

(add-hook 'java-mode-hook (lambda ()
                            (setq c-basic-offset 2
                                  tab-width 2
                                  indent-tabs-mode t)))

(add-to-list 'load-path "neotree")
(require 'neotree)
(global-set-key [f2] 'neotree-toggle)

(defun abedra/packages-installed-p ()
  (loop for pkg in abedra/packages
        when (not (package-installed-p pkg)) do (return nil)
        finally (return t)))

(unless (abedra/packages-installed-p)
  (message "%s" "Refreshing package database...")
  (package-refresh-contents)
  (dolist (pkg abedra/packages)
    (when (not (package-installed-p pkg))
      (package-install pkg))))

;; Show title names on the frame
(when window-system
  (setq frame-title-format '(buffer-file-name "%f" ("%b"))))

;; Show where the file ends
(setq-default indicate-empty-lines t)
(when (not indicate-empty-lines)
  (toggle-indicate-empty-lines))

;; (setq tab-width 2
;;       indent-tabs-mode nil)

;; (setq-default indent-tabs-mode nil)
;; (setq-default tab-width 2)
;; (setq indent-line-function 'insert-tab)

(setq-default indent-tabs-mode nil)
(setq-default tab-width 2)

;;; And I have tried
(setq indent-tabs-mode nil)
(setq tab-width 2)

;; shorts for yes-or-no
(defalias 'yes-or-no-p 'y-or-n-p)

;; global key binding
(global-set-key (kbd "RET") 'newline-and-indent)
(global-set-key (kbd "C-+") 'text-scale-increase)
(global-set-key (kbd "C--") 'text-scale-decrease)
(global-set-key (kbd "C-c C-k") 'compile)
(global-set-key (kbd "C-x g") 'magit-status)

;; turn down keystroke echo
;; use echo area for everything
(setq echo-keystrokes 0.1
      use-dialog-box nil
      visible-bell t)

;; auto pairing parenthesis
(require 'autopair)

;; Ido mode for nice file system browsing
(ido-mode t)
(setq ido-enable-flex-matching t
      ido-use-virtual-buffers t)


;; Julia
(require 'julia-mode)

;; Turn on autcomplete
(require 'auto-complete-config)
(ac-config-default)

(push 'jde-mode ac-modes)

;; Web mode for .hbs, .erb files
(add-to-list 'auto-mode-alist '("\\.hbs$" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb$" . web-mode))

;; Enable ruby mode for the following files
(add-hook 'ruby-mode-hook
          (lambda ()
            (autopair-mode)))

(add-to-list 'auto-mode-alist '("\\.rake$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.gemspec$" . ruby-mode))
(add-to-list 'auto-mode-alist '("\\.ru$" . ruby-mode))
(add-to-list 'auto-mode-alist '("Rakefile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Gemfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Capfile" . ruby-mode))
(add-to-list 'auto-mode-alist '("Vagrantfile" . ruby-mode))

;; Enable Ruby Version Manager mode and tell it to use the default Ruby
(rvm-use-default)

;; Yaml mode
(add-to-list 'auto-mode-alist '("\\.yml$" . yaml-mode))
(add-to-list 'auto-mode-alist '("\\.yaml$" . yaml-mode))


;; Hide, show code blocks
(load-library "hideshow")

;; (global-set-key (kbd "C-+") 'toggle-hiding)
;; (global-set-key (kbd "C-|") 'toggle-selective-display)

(add-hook 'c-mode-common-hook   'hs-minor-mode)
(add-hook 'emacs-lisp-mode-hook 'hs-minor-mode)
(add-hook 'java-mode-hook       'hs-minor-mode)
(add-hook 'lisp-mode-hook       'hs-minor-mode)
(add-hook 'perl-mode-hook       'hs-minor-mode)
(add-hook 'sh-mode-hook         'hs-minor-mode)
(defun toggle-selective-display (column)
  (interactive "P")
  (set-selective-display
   (or column
       (unless selective-display
	 (1+ (current-column))))))

(defun toggle-hiding (column)
  (interactive "P")
  (if hs-minor-mode
      (if (condition-case nil
p	      (hs-toggle-hiding)
	    (error t))
	  (hs-show-all))
    (toggle-selective-display column)))

;; Comments too
(setq hs-hide-comments nil)
;; Hide initial comments
(hs-hide-initial-comment-block)
;; Expand when goto line is used
(defadvice goto-line (after expand-after-goto-line
			    activate compile)
  "hideshow-expand affected block when using goto-line in a collapsed buffer"
  (save-excursion
    (hs-show-block)))

;; Cuda
(add-to-list 'auto-mode-alist '("\\.cu$" . c-mode))

;; Octave mode
(setq auto-mode-alist
      (cons '("\\.m$" . octave-mode) auto-mode-alist))
(add-hook 'octave-mode-hook
          (lambda ()
            (abbrev-mode 1)
            (auto-fill-mode 1)
	    (setq comment-start "% ")
            (if (eq window-system 'x)
                (font-lock-mode 1))))

;; Markdown mode
(autoload 'markdown-mode "markdown-mode"
  "Major mode for editing Markdown files" t)
(add-to-list 'auto-mode-alist '("\\.text$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.markdown$" . markdown-mode))
(add-to-list 'auto-mode-alist '("\\.md$" . markdown-mode))
;(markdown-enable-math t)

;; Auto revert all buffers automatically
(global-auto-revert-mode t)

;; Add mongolian language support
(load-library "quail/mongolian")

;; Coffeescript mode
(require 'coffee-mode)

;; autopair brackets
(require 'autopair)
(autopair-mode t)

;; Save sessions
(desktop-save-mode 1)

;; Parentheses highlightening
(require 'highlight-parentheses)

;; Integrate highlight-parentheses with autopair mode
(add-hook 'highlight-parentheses-mode-hook
          '(lambda ()
             (setq autopair-handle-action-fns
                   (append
		    (if autopair-handle-action-fns
			autopair-handle-action-fns
		      '(autopair-default-handle-action))
		    '((lambda (action pair pos-before)
			(hl-paren-color-update)))))))

;; Enables highlight-parentheses-mode on all buffers
(define-globalized-minor-mode global-highlight-parentheses-mode
  highlight-parentheses-mode
  (lambda ()
    (highlight-parentheses-mode t)))
(global-highlight-parentheses-mode t)

;; Define indention style
(setq c-default-style "linux")

;; Spell checking
(require 'ispell)
(setq ispell-program-name (executable-find "hunspell")
      ispell-personal-dictionary "mn-MN")

;; Spell checking
;; (setq ispell-program-name "hunspell")
;; (setq ispell-local-dictionary "mn_MN")

;; FlySpell check
(dolist (hook '(text-mode-hook))
  (add-hook hook (lambda () (flyspell-mode 1))))
(dolist (hook '(change-log-mode-hook log-edit-mode-hook))
  (add-hook hook (lambda () (flyspell-mode -1))))

;; Smex mode
(require 'smex)
(smex-initialize)
(global-set-key (kbd "M-x") 'smex)
(global-set-key (kbd "M-X") 'smex-major-mode-commands)
;; This is your old M-x.
(global-set-key (kbd "C-c C-c M-x") 'execute-extended-command)


;; Changing backup directory to system's temp directory
(setq backup-directory-alist
          `((".*" . ,temporary-file-directory)))    (setq auto-save-file-name-transforms
          `((".*" ,temporary-file-directory t)))

;; Showing the recently opened files
(require 'recentf)
(recentf-mode 1)
(setq recentf-max-menu-items 25)
(global-set-key "\C-x\ \C-r" 'recentf-open-files)

;; set goto-line
(global-set-key "\M-g" 'goto-line)

;; Original idea from
;; http://www.opensubscriber.com/message/emacs-devel@gnu.org/10971693.html
;; comment and uncomment the line
(defun comment-dwim-line (&optional arg)
  "Replacement for the comment-dwim command.
        If no region is selected and current line is not blank and we are not at the end of the line,
        then comment current line.
        Replaces default behaviour of comment-dwim, when it inserts comment at the end of the line."
  (interactive "*P")
  (comment-normalize-vars)
  (if (and (not (region-active-p)) (not (looking-at "[ \t]*$")))
      (comment-or-uncomment-region (line-beginning-position) (line-end-position))
    (comment-dwim arg)))

(global-set-key "\M-;" 'comment-dwim-line)

;; Backspace replacement
(global-set-key (kbd "C-;") 'delete-backward-char)

;; Owerwrite the selected region
(delete-selection-mode t)
(transient-mark-mode t)

;; copy to clipboard
(setq x-select-enable-clipboard t)

;; xdvik textlive
;;(add-to-list 'load-path "/usr/share/emacs/site-lisp/tex-utils")
;;(require 'xdvi-search)


;;;### APPEARANCE

;; Hide scrollbar, toolbar and menubar
(tool-bar-mode -1)
(menu-bar-mode -1)
(scroll-bar-mode -1)

;; Setting colortheme
;; (load-theme 'manoj-dark)

;;(require 'color-theme)
;; (color-theme-initialize)
;; (color-theme-subtle-hacker)

;; turn off welcome screen
(setq inhibit-startup-message t) 

;; set frame font size
(set-face-attribute 'default (selected-frame) :height 110)
;; (set-face-attribute 'default nil :height 150)

;; Fullscreen
;; (defun fullscreen ()
;;  (interactive)
;;  (x-send-client-message nil 0 nil "_NET_WM_STATE" 32
;; 	    		 '(2 "_NET_WM_STATE_FULLSCREEN" 0)))
;; (if (eq (window-system) 'x)
;;    (fullscreen))

;; display date and time always
(setq display-time-day-and-date t)
(display-time)

;; show column-number in mode line
(column-number-mode t)

;; Showing the line numbers on the left margin
;;(global-linum-mode 1)
;;(setq linum-format "%d  ")

;;;### LaTex

;; Activating AUCTEX mode
(load "auctex.el" nil t t)
(require 'tex-mik)

;; Enabling Document parsing
(setq TeX-auto-save t)
(setq TeX-parse-self t)

;; Make AUCTEX aware of the multi-file document structure
(setq-default Tex-master nil)

;; Set latex to use pdfLatex
(setq TeX-PDF-mode t)
;; (setq latex-run-command "pdflatex")


;;;### Org-Mode
;; (require 'org-install)

;; (add-to-list 'auto-mode-alist '("\\.org$" . org-mode))

;; (define-key mode-specific-map [?a] 'org-agenda)

;; (eval-after-load "org-agenda"
;;   '(progn
;;      (define-prefix-command 'org-todo-state-map)

;;      (define-key org-mode-map "\C-cx" 'org-todo-state-map)

;;      (define-key org-todo-state-map "x"
;;        #'(lambda nil (interactive) (org-todo "CANCELLED")))
;;      (define-key org-todo-state-map "d"
;;        #'(lambda nil (interactive) (org-todo "DONE")))
;;      (define-key org-todo-state-map "f"
;;        #'(lambda nil (interactive) (org-todo "DEFERRED")))
;;      (define-key org-todo-state-map "l"
;;        #'(lambda nil (interactive) (org-todo "DELEGATED")))
;;      (define-key org-todo-state-map "s"
;;        #'(lambda nil (interactive) (org-todo "STARTED")))
;;      (define-key org-todo-state-map "w"
;;        #'(lambda nil (interactive) (org-todo "WAITING")))

;;      (define-key org-agenda-mode-map "\C-n" 'next-line)
;;      (define-key org-agenda-keymap "\C-n" 'next-line)
;;      (define-key org-agenda-mode-map "\C-p" 'previous-line)
;;      (define-key org-agenda-keymap "\C-p" 'previous-line)))

;; (require 'remember)

;; (add-hook 'remember-mode-hook 'org-remember-apply-template)

;; (global-set-key (kbd "C-M-r") 'remember)

;; (put 'upcase-region 'disabled nil)


;; (custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  '(ido-enable-flex-matching t)
;;  '(org-agenda-custom-commands (quote (("d" todo "DELEGATED" nil) ("c" todo "DONE|DEFERRED|CANCELLED" nil) ("w" todo "WAITING" nil) ("W" agenda "" ((org-agenda-ndays 21))) ("A" agenda "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote notregexp) "\\=.*\\[#A\\]"))) (org-agenda-ndays 1) (org-agenda-overriding-header "Today's Priority #A tasks: "))) ("u" alltodo "" ((org-agenda-skip-function (lambda nil (org-agenda-skip-entry-if (quote scheduled) (quote deadline) (quote regexp) "
;; ]+>"))) (org-agenda-overriding-header "Unscheduled TODO entries: "))))))
;;  '(org-agenda-files (quote ("~/todo.org")))
;;  '(org-agenda-ndays 7)
;;  '(org-agenda-show-all-dates t)
;;  '(org-agenda-skip-deadline-if-done t)
;;  '(org-agenda-skip-scheduled-if-done t)
;;  '(org-agenda-start-on-weekday nil)
;;  '(org-deadline-warning-days 14)
;;  '(org-default-notes-file "~/notes.org")
;;  '(org-fast-tag-selection-single-key (quote expert))
;;  '(org-remember-store-without-prompt t)
;;  '(org-remember-templates (quote ((116 "* TODO %?
;;   %u" "~/todo.org" "Tasks") (110 "* %u %?" "~/notes.org" "Notes"))))
;;  '(org-reverse-note-order t)
;;  '(remember-annotation-functions (quote (org-remember-annotation)))
;;  '(remember-handler-functions (quote (org-remember-handler)))
;;  '(send-mail-function (quote sendmail-send-it)))
;; (custom-set-faces
;;  ;; custom-set-faces was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;;  )
(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cb" 'org-iswitchb)
(global-set-key "\C-cl" 'org-store-link)

(setq org-default-notes-file "~/org/notes.org")

(setq org-capture-templates
      '(("t" "Todo" entry (file+headline "~/org/todos.org" "Tasks")
	 "* TODO %?\n %i\n %a")
	("a" "Academic" entry (file+headline "~/org/todos.org" "Academic")
	 "* TODO %?\n %i\n %a")
	("c" "Church" entry (file+headline "~/org/todos.org" "Church")
	 "* TODO %?\n %i\n")
	("b" "Book (C++)" entry (file+headline "~/org/todos.org" "Book C++")
	 "* TODO %?\n %i\n")
	("p" "Personal" entry (file+headline "~/org/todos.org" "Personal")
	 "* TODO %?\n %i\n")
	("j" "Journal" entry (file+datetree "~/org/journal.org")
	 "* %?\nEntered on %U\n %i\n %a")))
;; add diaries to org
(setq org-agenda-include-diary t)
;; todo sequence
(setq org-todo-keywords
      '((sequence "TODO(t)" "STARTED(s)" "Ulaankhuu(u)" "Otgoo(o)" "Lorena(l)" "|" "DONE(d)" "DELEGATED(e)")
	(sequence "Research(r)" "BUG(b)" "KNOWNCAUSE(k)" "|" "FIXED(f)")
	(sequence "|" "CANCELED(c)")))

(setq org-todo-keyword-faces
      '(("TODO" . org-warning) ("STARTED" . "yellow")
	("CANCELED" . (:foreground "blue" :weight bold))))
;; Log save the time when the task marked done
(setq org-log-done 'time)
;; C-c C-x C-i start the clock, C-c C-x C-o stop the clock when you start working on the task
(setq org-clock-persist 'history)
(org-clock-persistence-insinuate)

(defun org-summary-todo (n-done n-not-done)
  "Switch entry to DONE when all subentries are done, to TODO otherwise."
  (let (org-log-done org-log-states) ; turn off logging
    (org-todo (if (= n-not-done 0) "DONE" "TODO"))))

(add-hook 'org-after-todo-statistics-hook 'org-summary-todo)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(org-agenda-files (quote ("~/org/anniversaries.org" "~/org/todos.org")))
 '(package-selected-packages
   (quote
    (vue-mode vue-html-mode gradle-mode dart-mode sed-mode latex-extra yaml-mode writegood-mode web-mode solarized-theme sml-mode smex scala-mode rvm restclient puppet-mode php-mode paredit org-plus-contrib org o-blog nrepl nodejs-repl marmalade markdown-mode magit htmlize highlight-parentheses haskell-mode haml-mode graphviz-dot-mode go-mode gist flycheck feature-mode erlang deft csharp-mode coffee-mode clojure-test-mode autopair auto-complete ac-slime))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )

;;================ SQL =============================

(require 'sql)
;; (defalias 'sql-get-login 'ignore)
;; Saving sql histories for each product in a seperate folder
(defun my-sql-save-history-hook ()
  (let ((lval 'sql-input-ring-file-name)
	(rval 'sql-product))
    (if (symbol-value rval)
	(let ((filename 
	       (concat "~/.emacs.d/sql/"
		       (symbol-name (symbol-value rval))
		       "-history.sql")))
	  (set (make-local-variable lval) filename))
      (error
       (format "SQL history will not be saved because %s is nil"
	       (symbol-name rval))))))

(add-hook 'sql-interactive-mode-hook 'my-sql-save-history-hook)

;; A function to uppercase all sql keywords in the buffer using FontLockMode to determine the keywords.
(defun upcase-sql-keywords ()
  (interactive)
  (save-excursion
    (dolist (keywords sql-mode-postgres-font-lock-keywords)
      (goto-char (point-min))
      (while (re-search-forward (car keywords) nil t)
	(goto-char (+ 1 (match-beginning 0)))
	(when (eql font-lock-keyword-face (face-at-point))
	  (backward-char)
	  (upcase-word 1)
	  (forward-char))))))

;; make emacs not to restore any frames
(setq desktop-restore-frames nil)

(add-hook 'plain-TeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			  (cons "$" "$"))))
(add-hook 'LaTeX-mode-hook
	  (lambda () (set (make-variable-buffer-local 'TeX-electric-math)
			  (cons "$" "$"))))

;; React/React-native
(require 'web-mode)

(add-to-list 'auto-mode-alist '(".*/react/.*\\.js[x]?\\'" . web-mode))
(setq web-mode-content-types-alist
  '(("jsx"  . "/.*/react/.*\\.js[x]?\\'")))

(setq web-mode-markup-indent-offset 2
      web-mode-css-indent-offset 2
      web-mode-code-indent-offset 2)
(setq js-indent-level 2)

(define-key web-mode-map (kbd "C-l") 'web-mode-tag-match)

;; auto pair
(setq web-mode-extra-auto-pairs
      '(("erb"  . (("beg" "end")))
        ("php"  . (("beg" "end")
                   ("beg" "end")))
       ))
;; enable auto pair
(setq web-mode-enable-auto-pairing t)

(eval-after-load 'latex
  '(setq LaTeX-clean-intermediate-suffixes
         (append LaTeX-clean-intermediate-suffixes (list "\\.lol" "\\.nlo"))))

;; (add-to-list 'LaTeX-clean-intermediate-suffixes "\\.foo" t)


;; (defun vue-mode/init-vue-mode ()
;;   (use-package vue-mode
;;                :config
;;                ;; 0, 1, or 2, representing (respectively) none, low, and high coloring
;;                (setq mmm-submode-decoration-level 0)))

(add-hook 'mmm-mode-hook
          (lambda ()
            (set-face-background 'mmm-default-submode-face nil)))

(require 'web-mode)
(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.html\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.js\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))

;; (define-key web-mode-map (kbd "C-n") 'web-mode-tag-match)
(setq web-mode-enable-current-element-highlight t)

(setq web-mode-ac-sources-alist
  '(("css" . (ac-source-css-property))
    ("html" . (ac-source-words-in-buffer ac-source-abbrev))))

(local-set-key (kbd "RET") 'newline-and-indent)
