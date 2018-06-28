;; init.el --- Emacs configuration

;;-----------------------------------------------------------------
;; WELCOME TO MY EMACS INIT FILE
;;-----------------------------------------------------------------

;; ----------------------------------------------------------------
;; INSTALL PACKAGES
;; ----------------------------------------------------------------

(require 'package)
(add-to-list 'package-archives
       '("melpa" . "http://melpa.org/packages/") t)
(package-initialize)
(when (not package-archive-contents)
  (package-refresh-contents))

;;(defvar myPackages
;;  '(better-defaults
;;    ein ;; add the ein package (Emacs ipython notebook)
;;    elpy ;; add the elpy package 
;;    flycheck ;; add the flycheck package
;;    ;;material-theme
;;    py-autopep8)) ;; add the autopep8 package
;;;;
;;
;;(mapc #'(lambda (package)
;;    (unless (package-installed-p package)
;;      (package-install package)))
;;      myPackages)
;; ----------------------------------------------------------------



;; These 5 line do:
;; 1. Remove Tool bar
;; 2. set window size from begining
;; 3. Remove scroll bar
(if (fboundp 'menu-bar-mode) (menu-bar-mode -1))
(if (fboundp 'tool-bar-mode) (tool-bar-mode -1))
(if (fboundp 'mode-line-format) (mode-line-format -1))
;;(tool-bar-mode 0)
(toggle-scroll-bar -1)
;; turn off visual bell
(setq visible-bell 0)
(setq ring-bell-function 'ignore)
;; ----------------------------------------------------------------
;; BASIC CUSTOMIZATION
;; ----------------------------------------------------------------

(setq inhibit-startup-message t) ;; hide the startup message
(load-theme 'spacemacs-dark t)
;;(load-theme 'material t)
;;(load-theme 'zenburn t) ;; load zenburn theme
;;(load-theme 'helm t)
;;(add-to-list 'custom-theme-load-path "elpa/leuven-theme-20170919.252")
;;(load-theme 'leuven t)
;;(set-face-attribute 'default nil :height 110) ;; The value is 1/10pt, so 100 will give us 10pt
;;(setq global-linum-mode '(not helm-mode)) ;; disable line number in helm-mode
;;(global-linum-mode t) ;; enable line numbers globally
;; enable linum mode if we are not in helm mode
;;(global-linum-mode '(if (not (helm-mode)) (t) ))
;;(add-hook 'prog-mode-hook 'linum-mode)
;;(setq linum-format "%3d\u2502 ") ;; fix line number example is: 1| or 128|
;;(global-visual-line-mode t) ;; word-wrapped
;;(setq column-number-mode t)
(global-hl-line-mode 1)
;;(setq-default line-spacing 0.25)
;; ----------------------------------------------------------------

(set-frame-position nil 0 -24)
;; This is for 120 font
;;(set-frame-size nil 180 55)
;; This line down here is for window 100 font
;;(set-frame-size nil 210 70)
;; This line down here is for window 110 font
;; (set-frame-size nil 180 59)
;; This line down here is for default font
(set-frame-size nil 180 55)

;; If the value is greater than 100, redisplay will never recenter point,
;; but will always scroll just enough text to bring point into view,
;; even if you move far away. A value of zero means always recenter point if it moves off screen
(setq scroll-conservatively 101)

;; Set the right option alt-key to nil, do this so we can use [ and ] and ...
(setq mac-right-option-modifier nil)
;; auto insert closing bracket
(electric-pair-mode 1)
;;-------------------------------------------------------------------


;; ------------------------------------------------------------------
;; Scratch
;; ------------------------------------------------------------------
;; set scratch only text editor
(setq initial-major-mode 'org-mode)
(setq initial-scratch-message "\
# This buffer is for notes you don't want to save.
# If you want to create a file, visit that file with C-x C-f,
# then enter the text in that file's own buffer.")
;; ------------------------------------------------------------------




;;;; ----------------------------------------------------------------
;;;; PYTHON CONFIGURATION
;;;; ----------------------------------------------------------------
(require 'exec-path-from-shell)
(when (memq window-system '(mac ns x))
  (exec-path-from-shell-initialize)
;;(exec-path-from-shell-copy-env "PATH")
  ;;(exec-path-from-shell-copy-env "/Users/gudjon/miniconda3/bin/ipython")
  ;;/Users/gudjon/miniconda3/bin/python
  ;; two line follow is for Magit to use SSH
  (exec-path-from-shell-copy-env "SSH_AGENT_PID")
  (exec-path-from-shell-copy-env "SSH_AUTH_SOCK")
  (setq exec-path-from-shell-check-startup-files nil)
  )
;;;; Standard Jedi.el setting
;;(add-hook 'python-mode-hook 'jedi:setup)
;;(setq jedi:complete-on-dot t)
;;;; Type:
;;;;     M-x package-install RET jedi RET
;;;;     M-x jedi:install-server RET
;;;; Then open Python file.
;;;;(elpy-use-ipython)
;;(setq python-shell-interpreter "ipython"
;;      ;;python-shell-interpreter-args "-i --simple-prompt")
;;      python-shell-interpreter-args "-i --simple-prompt")
;;
;;;; RECOMENDED
;;;;(setq python-shell-interpreter "jupyter"
;;;;      python-shell-interpreter-args "console --simple-prompt")
;;;;(setq python-shell-interpreter "python"
;;;;      python-shell-interpreter-args "-i")
;;(elpy-enable) ;; pip install jedi flake8 autopep8
;;;;(elpy-use-ipython)
;;
;;;; flycheck
;;(when (require 'flycheck nil t)
;;  (setq elpy-modules (delq 'elpy-module-flymake elpy-modules))
;;  (add-hook 'elpy-mode-hook 'flycheck-mode))
;;
;;;; autopep8
;;(require 'py-autopep8)
;;(add-hook 'elpy-mode-hook 'py-autopep8-enable-on-save)
;;;;(add-hook 'python-mode-hook 'py-autopep8-enable-on-save)
;;;;(add-hook 'ob-ipython-mode-hook 'py-autopep8-enable-on-save)
;;
;;
;;;;(add-hook 'org-mode-hook 'py-autopep8-enable-on-save) ;; for Org mode
;;;; This codes for python 3.5 if update to python 3.6 than can remove the codes
;;;;(with-eval-after-load 'python
;;;;  (defun python-shell-completion-native-try ()
;;;;    "Return non-nil if can trigger native completion."
;;;;    (let ((python-shell-completion-native-enable t)
;;;;          (python-shell-completion-native-output-timeout
;;;;           python-shell-completion-native-try-output-timeout))
;;;;      (python-shell-completion-native-get-completions
;;;;       (get-buffer-process (current-buffer))
;;;;       nil "_"))))
;;
;;(setq python-shell-completion-native-enable nil)
;;;; -------------END------------------------------------------------




;;---------------------------------------------------------
;; Evil mode ---Start---
;;---------------------------------------------------------
;; copy all 2 lines below and paste in terminal
;; clone link below to ~/.emacs/
;; git clone https://github.com/emacs-evil/evil ~/.emacs.d/evil
(add-to-list 'load-path "~/.emacs.d/evil")
(require 'evil)
(evil-mode 1)
;; undo like in vim
(setq evil-want-fine-undo t) 
;;--------END-----------------------------------------------





;;---------------------------------------------------------
;; LaTeX ---Start---
;;---------------------------------------------------------
(setq exec-path (append exec-path '("/Library/TeX/texbin")))
;;--------END-----------------------------------------------


;;----------------------------------------------------------
;; Org mode ---START---
;;----------------------------------------------------------
;;(setq org-display-inline-images t)
;; copy all 4 lines of code below and paste in terminal
;; mkdir ~/src && cd ~/src
;; git clone https://code.orgmode.org/bzg/org-mode.git
;; cd org-mode
;; make autoloads
;;(add-to-list 'load-path "~/src/org-mode/lisp")
;;(add-to-list 'load-path "~/src/org-mode/contrib/lisp" t)
;; Enable Org mode
(require 'org)
;; Line down here is for ipython notebook
(require 'ob-ipython)
;;; display/update images in the buffer after I evaluate
(add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
;; Two line below adds bullets into org
(require 'org-bullets)
(add-hook 'org-mode-hook 'org-bullets-mode)

;; Enable transient mark mode
(transient-mark-mode 1)
;; Make Org mode work with files ending in .org
(add-to-list 'auto-mode-alist '("\\.org$" . org-mode))
;; This will able the shift in Org-mode
(setq org-support-shift-select t)
;; let org load languages
(org-babel-do-load-languages
 'org-babel-load-languages
 '(;;(python . t)
   (latex . t)
   (dot . t)
   ;; other languages..
   ))
;; this line below told org not to ask when execute code block
(setq org-confirm-babel-evaluate nil) 
;;; display/update images in the buffer after I evaluate
;; (add-hook 'org-babel-after-execute-hook 'org-display-inline-images 'append)
;; syntax highlight when export to pdf
;;(add-to-list 'org-latex-minted-langs '(ipython "python"))
;; This is the customize that I had put in zenburn-theme.el
;;`(org-level-1 ((t (:foreground ,zenburn-orange :height 136 :weight bold))))
;;`(org-level-2 ((t (:foreground ,zenburn-green+4 :height 134 :weight bold))))
;;`(org-level-3 ((t (:foreground ,zenburn-blue-1 :height 132 :weight bold))))
;;`(org-level-4 ((t (:foreground ,zenburn-yellow-2 :height 130 :weight bold))))
;;`(org-level-5 ((t (:foreground ,zenburn-cyan :height 128 :weight bold))))
;;`(org-level-6 ((t (:foreground ,zenburn-green+2 :height 126 :weight bold))))
;;`(org-level-7 ((t (:foreground ,zenburn-red-4 :height 124 :weight bold))))
;;`(org-level-8 ((t (:foreground ,zenburn-blue-4 :height 122 :weight bold))))


;; Customize TODO list
;; We could also put the following line to the top of org file:
;; #+SEQ_TODO: PROCESS(p) NEXT(n) TODO(t) WAITING(w) SOMEDAY(s) | DONE(d) CANCELLED(c)
;; or have the following code in init.el as global default
(setq org-todo-keywords     
      '((sequence "PROCESS(p)" "NEXT(n)" "TODO(t)" "WAITING(w)" "RESCHEDULE(r)"  
                  "|" "DONE(d)" "CANCELLED(c)")))
;; or we could use Org Babel like this:
;; #+BEGIN_SRC emacs-lisp
;;   (setq-local org-todo-keywords     
;;         '((sequence "PROCESS()" "NEXT()" "TODO()" "WAITING()" "RESCHEDULE()"  
;;                     "|" "DONE()" "CANCELLED()")))
;; #+END_SRC


;; TODO keys color
(setq org-todo-keyword-faces
      (quote (("PROCESS" :foreground "gold" :height 142 :weight bold)
              ("NEXT" :foreground "orange" :height 142 :weight bold)
              ("TODO" :foreground "tomato" :height 142 :weight bold)
              ("WAITING" :foreground "orchid" :height 142 :weight bold)
	      ("RESCHEDULE" :foreground "chocolate" :height 142 :weight bold)
              ("DONE" :foreground "green" :height 142 :weight bold)
              ("CANCELLED" :foreground "red" :height 142 :weight bold))))
;;(setq org-todo-keyword-faces
;;      (quote (("PROCESS" :foreground "gold")
;;              ("NEXT" :foreground "orange")
;;              ("TODO" :foreground "tomato")
;;              ("WAITING" :foreground "orchid")
;;	      ("RESCHEDULE" :foreground "chocolate")
;;              ("DONE" :foreground "green")
;;              ("CANCELLED" :foreground "red"))))



;; EASY TEMPLATE (shortkey)
(setq org-structure-template-alist
      '(("s" "#+begin_src ?\n\n#+end_src" "<src lang=\"?\">\n\n</src>")
        ("e" "#+begin_example\n?\n#+end_example" "<example>\n?\n</example>")
        ("q" "#+begin_quote\n?\n#+end_quote" "<quote>\n?\n</quote>")
        ("v" "#+BEGIN_VERSE\n?\n#+END_VERSE" "<verse>\n?\n</verse>")
        ("c" "#+BEGIN_COMMENT\n?\n#+END_COMMENT")
        ("p" "#+BEGIN_PRACTICE\n?\n#+END_PRACTICE")
        ("l" "#+begin_src emacs-lisp\n?\n#+end_src" "<src lang=\"emacs-lisp\">\n?\n</src>")
        ("L" "#+latex: " "<literal style=\"latex\">?</literal>")
        ("h" "#+begin_html\n?\n#+end_html" "<literal style=\"html\">\n?\n</literal>")
        ("H" "#+html: " "<literal style=\"html\">?</literal>")
        ("a" "#+begin_ascii\n?\n#+end_ascii")
        ("A" "#+ascii: ")
        ("i" "#+index: ?" "#+index: ?")
        ("I" "#+include %file ?" "<include file=%file markup=\"?\">")))

;;(defun python-shell-completion-native-try ()
;;  "Return non-nil if can trigger native completion."
;;  (let ((python-shell-completion-native-enable t)
;;        (python-shell-completion-native-output-timeout
;;         python-shell-completion-native-try-output-timeout))
;;    (python-shell-completion-native-get-completions
;;     (get-buffer-process (current-buffer))
;;     nil "")))

;; ORG shortkeys
;; This is background color for code block org-babel 
;;(defface org-block-begin-line
;;  '((t (:height 130 : weight bold :foreground "#FF8800" :background "#4c4c4c")))
;;  "Face used for the line delimiting the begin of source blocks.")

;;(defface org-block-background
;;  '((t :background "#FFFFEA")) ;;#FFFFEA
;;  "Face used for the source block background.")

;;(defface org-block-end-line
;;  '((t (:height 130 : weight bold :foreground "#FF8800" :background "#4c4c4c")))
;;  "Face used for the line delimiting the end of source blocks.")


;; This is for the exporting have without TODO keywords
(setq org-export-with-todo-keywords nil)

(global-set-key "\C-cl" 'org-store-link)
(global-set-key "\C-ca" 'org-agenda)
(global-set-key "\C-cc" 'org-capture)
(global-set-key "\C-cb" 'org-iswitchb)


(custom-set-variables
 ;; custom-set-variables was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 '(custom-safe-themes
   (quote
    ("a24c5b3c12d147da6cef80938dca1223b7c7f70f2f382b26308eba014dc4833a" "43c1a8090ed19ab3c0b1490ce412f78f157d69a29828aa977dae941b994b4147" default)))
 '(org-agenda-files (quote ("~/Documents/Legend/Dagskra.org")))
 '(org-export-backends (quote (ascii beamer html icalendar latex md odt)))
 '(package-selected-packages
   (quote
    (web-mode impatient-mode jquery-doc tern-auto-complete indium xref-js2 ag cask package-build shut-up epl git commander f nvm company company-tern emmet-mode js2-refactor js2-mode yasnippet dash s org-bullets spacemacs-theme org leuven-theme helm-themes ## htmlize zenburn-theme rainbow-delimiters py-autopep8 material-theme magit jedi-direx helm flycheck exec-path-from-shell elpy ein better-defaults))))
(custom-set-faces
 ;; custom-set-faces was added by Custom.
 ;; If you edit it by hand, you could mess it up, so be careful.
 ;; Your init file should contain only one such instance.
 ;; If there is more than one, they won't work right.
 )
;;-------END-------------------------------------------------






;;---------------------------------------------------
;; Helm
;;---------------------------------------------------
;; M-x package-install RET helm RET
(require 'helm-config)
;;(require 'helm-themes)
(global-set-key (kbd "C-x b") 'helm-buffers-list)
(global-set-key (kbd "C-x C-f") 'helm-find-files)
(global-set-key (kbd "M-x") 'helm-M-x)
;;---------------------------------------------------





;;----------------------------------------------------
;; Rainbow-delemiters
;;----------------------------------------------------
;; This is for highlight braket
(show-paren-mode 1)
;; This is for highlight entire expression
;; and highlight bracket
;;(setq show-paren-style 'mixed)

;; M-x package-install RET rainbow-delimiters RET
;; Than add the following code
(require 'rainbow-delimiters)
(add-hook 'prog-mode-hook #'rainbow-delimiters-mode)
;;----------------------------------------------------





;; ---------------------------------------------------
;; Ein
;; ---------------------------------------------------
;;(require 'bindat)
;;(require 'url-parse)
;;(require 'url-cookie)
;;(eval-when-compile (require 'cl-lib))
;;(require 'ein)
;;(setq ein:use-auto-complete t)

;;(defcustom ein:url-or-port '(8888)
;;  "List of default url-or-port values.
;;This will be used for completion. So put your IPython servers.
;;You can connect to servers not in this list \(but you will need
;;to type every time)."
;;  :type '(repeat (choice (integer :tag "Port number" 8888)
;;                         (string :tag "URL" "http://localhost:8888/")))
;;  :group 'ein)
;;

;;(defcustom ein:default-url-or-port nil
;;  "Default URL or port.  This should be your main IPython
;;    Notebook server."
;;  :type '(choice (integer :tag "Port number" 8888)
;;                 (string :tag "URL" "http://localhost:8888/")
;;                 (const :tag "First value of `ein:url-or-port'" nil))
;;  :group 'ein)
;; ---------------------------------------------------





;; ---------------------------------------------------
;; Magit
;; ---------------------------------------------------
(add-to-list 'load-path "~/.emacs.d/site-lisp/magit/lisp")
(require 'magit)

(with-eval-after-load 'info
  (info-initialize)
  (add-to-list 'Info-directory-list
               "~/.emacs.d/site-lisp/magit/Documentation/"))
(setq magit-view-git-manual-method 'man)
(global-set-key (kbd "C-x g") 'magit-status)
;; ---------------------------------------------------




;;---------------------------------------------------------
;; Yasnippet ---Start---
;;---------------------------------------------------------
;;(add-to-list 'load-path "~/.emacs.d/plugins/yasnippet")
(require 'yasnippet)
(yas-global-mode 1)
;;--------END-----------------------------------------------


;; -----------------------------------------------------
;; Change JS
;; -----------------------------------------------------
;;(require 'company)
;;(require 'company-tern)
;;(require 'tern)
;;(require 'js2-mode)
;;(require 'js2-refactor)
;;
;;(add-hook 'js2-mode-hook #'js2-refactor-mode)
;;(global-company-mode t)
;;
;;
;;(add-to-list 'company-backends 'company-tern)
;;(add-hook 'js2-mode-hook (lambda ()
;;                           (tern-mode)
;;                           (company-mode)))
;; -----------------------------------------------------



;; ---------------------------------------------------
;; Indium
;; ---------------------------------------------------
;;(require 'indium)
;;(add-hook 'js-mode-hook #'indium-interaction-mode)
;; ---------------------------------------------------



;; ---------------------------------------------------
;; Javascript IDE
;; ---------------------------------------------------
(require 'company)
(require 'company-tern)
;;(add-to-list 'load-path "~/.emacs.d/vendor/tern/emacs/")
(require 'tern)
(require 'js2-mode)
(require 'js2-refactor)
(require 'jquery-doc)

;;(global-company-mode t)
;;(setq company-global-modes '(not org-mode))
;;(setq global-company-mode '(if (not (org-mode)) (t) ))
(add-hook 'prog-mode-hook 'company-mode)
;; unable tern to export .tern-port file
(setq tern-command (append tern-command '("--no-port-file")))
;; faster code completion
(setq company-dabbrev-downcase 0)
(setq company-idle-delay 0)
(defun tab-indent-or-complete ()
  (interactive)
  (if (minibufferp)
      (minibuffer-complete)
    (if (or (not yas-minor-mode)
            (null (do-yas-expand)))
        (if (check-expansion)
            (company-complete-common)
          (indent-for-tab-command)))))
(global-set-key [backtab] 'tab-indent-or-complete)

;;;; Initialisation
;;(mapc (lambda(p) (require p)) '(js2-mode tern company company-tern jquery-doc js2-refactor))
(jquery-doc-setup)
(add-to-list 'company-backends 'company-tern)

;; associate js with tern and company
(add-hook 'js-mode-hook (lambda () (tern-mode t)(company-mode t)))
;; use js2 as default mode
(add-to-list 'auto-mode-alist (cons (rx ".js" eos) 'js2-mode))

;; adjust defaults
;;(setq company-auto-complete t)
(setq company-idle-delay 0)
(setq company-minimum-prefix-length 1)
(setq company-tooltip-limit 20)
(setq company-tooltip-align-annotations t)

;;; jquery documentation
; NB. update doc database with M-x jquery-doc-fetch-and-generate-data
(defun jquery-doc-at-point ()
  (interactive)
  (jquery-doc (thing-at-point 'word)))
(global-set-key [f2] 'jquery-doc-at-point)

;;;; for orgmode
;;(defun my-org-mode-hook ()
;;  (add-hook 'completion-at-point-functions 'pcomplete-completions-at-point nil t))
;;(add-hook 'org-mode-hook #'my-org-mode-hook)

;; --------------------------------------------------


;; --------------------------------------------------
;; JS linting
;; --------------------------------------------------
;; use space only (no tabs)
;;(custom-set-variables
;;  ;; custom-set-variables was added by Custom.
;;  ;; If you edit it by hand, you could mess it up, so be careful.
;;  ;; Your init file should contain only one such instance.
;;  ;; If there is more than one, they won't work right.
;; '(tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120))))
(setq tab-stop-list (quote (4 8 12 16 20 24 28 32 36 40 44 48 52 56 60 64 68 72 76 80 84 88 92 96 100 104 108 112 116 120)))
(setq-default indent-tabs-mode nil)

(require 'flycheck)

;; turn on flychecking globally
;; (add-hook 'after-init-hook #'global-flycheck-mode)
(add-hook 'js2-mode-hook 'flycheck-mode)

;; disable jshint since we prefer eslint checking
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(javascript-jshint)))

;; use eslint with web-mode for jsx files
(flycheck-add-mode 'javascript-eslint 'web-mode)

;; customize flycheck temp file prefix
(setq-default flycheck-temp-prefix ".flycheck")

;; disable json-jsonlist checking for json files
(setq-default flycheck-disabled-checkers
  (append flycheck-disabled-checkers
    '(json-jsonlist)))

;; Customizing flycheck to use local node_modules eslint if exists
;; use local before default
(defun my/use-eslint-from-node-modules ()
  (let* ((root (locate-dominating-file
                (or (buffer-file-name) default-directory)
                "node_modules"))
         (eslint (and root
                      (expand-file-name "node_modules/eslint/bin/eslint.js"
                                        root))))
    (when (and eslint (file-executable-p eslint))
      (setq-local flycheck-javascript-eslint-executable eslint))))
(add-hook 'flycheck-mode-hook #'my/use-eslint-from-node-modules)

;; Customizing indent
(defun my-web-mode-hook ()
  "Hooks for Web mode. Adjust indents"
  ;;; http://web-mode.org/
  (setq web-mode-markup-indent-offset 2)
  (setq web-mode-css-indent-offset 2)
  (setq web-mode-code-indent-offset 2))
(add-hook 'web-mode-hook  'my-web-mode-hook)

;; Improving the JSX syntax-hightlighting in web-mode
(defadvice web-mode-highlight-part (around tweak-jsx activate)
  (if (equal web-mode-content-type "jsx")
    (let ((web-mode-enable-part-face nil))
      ad-do-it)
    ad-do-it))
;; --------------------------------------------------

;; ---------------------------------------------------
;; Web-mode
;; ---------------------------------------------------
(require 'web-mode)
;; disable the ctrl-j in web mode and use ctrl-j in emmet mode which is expand
(define-key web-mode-map (kbd "C-j") nil)

(add-to-list 'auto-mode-alist '("\\.html?\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.css\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.scss\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.xml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.jsx$" . web-mode))

(add-to-list 'auto-mode-alist '("\\.phtml\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.tpl\\.php\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.[agj]sp\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.as[cp]x\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.erb\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.mustache\\'" . web-mode))
(add-to-list 'auto-mode-alist '("\\.djhtml\\'" . web-mode))

;; ---------------------------------------------------


;; ---------------------------------------------------
;; Emmet-mode
;; ---------------------------------------------------
(require 'emmet-mode)
(add-hook 'sgml-mode-hook 'emmet-mode) ;; Auto-start on any markup modes
(add-hook 'css-mode-hook  'emmet-mode) ;; enable Emmet's css abbreviation.
(setq emmet-move-cursor-between-quotes t)

;; add hook emmet mode to web mode 
(add-hook 'web-mode-hook 'emmet-mode)
;;;; for css
;;(defun xah-syntax-color-hex ()
;;;;  "Syntax color text of the form 「#ff1100」 and 「#abc」 in current buffer.
;;;;URL `http://ergoemacs.org/emacs/emacs_CSS_colors.html'
;;;;Version 2017-03-12"
;;  (interactive)
;;  (font-lock-add-keywords
;;   nil
;;   '(("#[[:xdigit:]]\\{3\\}"
;;      (0 (put-text-property
;;          (match-beginning 0)
;;          (match-end 0)
;;          'face (list :background
;;                      (let* (
;;                             (ms (match-string-no-properties 0))
;;                             (r (substring ms 1 2))
;;                             (g (substring ms 2 3))
;;                             (b (substring ms 3 4)))
;;                        (concat "#" r r g g b b))))))
;;     ("#[[:xdigit:]]\\{6\\}"
;;      (0 (put-text-property
;;          (match-beginning 0)
;;          (match-end 0)
;;          'face (list :background (match-string-no-properties 0)))))))
;;  (font-lock-flush))
;;(add-hook 'css-mode-hook 'xah-syntax-color-hex)
;;(add-hook 'php-mode-hook 'xah-syntax-color-hex)
;;(add-hook 'html-mode-hook 'xah-syntax-color-hex)


;; ---------------------------------------------------
;; simple-httpd
;; ---------------------------------------------------
;;(require 'simple-httpd)
;;(setq httpd-root "http://localhost:8080/skewer")
;; ---------------------------------------------------

;; ---------------------------------------------------
;; Impatient-mode
;; ---------------------------------------------------
;;(require 'impatient-mode)
;; ---------------------------------------------------

;; ---------------------------------------------------
;; Skewer-mode
;; ---------------------------------------------------
;;(require 'skewer-mode)
;;(add-hook 'js2-mode-hook 'skewer-mode)
;;(add-hook 'css-mode-hook 'skewer-css-mode)
;;(add-hook 'html-mode-hook 'skewer-html-mode)
;; ---------------------------------------------------
