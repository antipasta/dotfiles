;;; $DOOMDIR/config.el -*- lexical-binding: t; -*-

;; Place your private configuration here! Remember, you do not need to run 'doom
;; sync' after modifying this file!


;; Some functionality uses this to identify you, e.g. GPG configuration, email
;; clients, file templates and snippets.
(setq user-full-name "Joe Papperello"
      user-mail-address "joe@doe.com")

;; Doom exposes five (optional) variables for controlling fonts in Doom. Here
;; are the three important ones:
;;
;; + `doom-font'
;; + `doom-variable-pitch-font'
;; + `doom-big-font' -- used for `doom-big-font-mode'; use this for
;;   presentations or streaming.
;;
;; They all accept either a font-spec, font string ("Input Mono-12"), or xlfd
;; font string. You generally only need these two:
;; (setq doom-font (font-spec :family "monospace" :size 12 :weight 'semi-light)
;;       doom-variable-pitch-font (font-spec :family "sans" :size 13))

;; There are two ways to load a theme. Both assume the theme is installed and
;; available. You can either set `doom-theme' or manually load a theme with the
;; `load-theme' function. This is the default:
(setq doom-theme 'doom-one)

;; If you use `org' and don't want your org files in the default location below,
;; change `org-directory'. It must be set before org loads!
(setq org-directory "~/org/")
;(setq org-roam-directory "~/orgroam/")
(setq org-roam-directory "~/org/roam/")
(setq org-roam-dailies-directory "daily/")

(setq org-roam-dailies-capture-templates
      '(("d" "default" entry
         #'org-roam-capture--get-point
         "* %?"
         :file-name "daily/%<%Y-%m-%d>"
         :head "#+title: %<%Y-%m-%d>\n\n#+roam_tags: journal\n\n")))

;; This determines the style of line numbers in effect. If set to `nil', line
;; numbers are disabled. For relative line numbers, set this to `relative'.
(setq display-line-numbers-type t)


;; Here are some additional functions/macros that could help you configure Doom:
;;
;; - `load!' for loading external *.el files relative to this one
;; - `use-package!' for configuring packages
;; - `after!' for running code after a package has loaded
;; - `add-load-path!' for adding directories to the `load-path', relative to
;;   this file. Emacs searches the `load-path' when you load packages with
;;   `require' or `use-package'.
;; - `map!' for binding new keys
;;
;; To get information about any of these functions/macros, move the cursor over
;; the highlighted symbol at press 'K' (non-evil users must press 'C-c c k').
;; This will open documentation for it, including demos of how they are used.
;;
;; You can also try 'gd' (or 'C-c c d') to jump to their definition and see how
;; they are implemented.


;; THIS IS WHERE I START ADDING STUFF:


; lets me use ; instead of : to enter vim command mode
(evil-define-key 'motion 'global
  ";" #'evil-ex)

(evil-define-key 'normal org-mode-map
  ";" #'evil-ex)


; no idea?
(define-key evil-normal-state-map "?" 'evil-search-backward)


; <leader>x instead of alt-M x to get to emacs command mode
(map! :leader
      :desc "Execute Extended command" "x" #'execute-extended-command)


; some journaling shortcuts i stole from someplace
(map! :leader
      (:prefix-map ("j" . "journal")
       :desc "Capture new journal entry" "n" #'org-roam-dailies-capture-today
       :desc "Go to today's journal entry" "t" #'org-roam-dailies-find-today
       :desc "Go to yesterday's journal entry" "y" #'org-roam-dailies-find-yesterday
       :desc "Go to tomorrow's journal entry" "o" #'org-roam-dailies-find-tomorrow
       :desc "Go to previous journal entry" "j" #'org-roam-dailies-find-previous-note
       :desc "Go to next journal entry" "k" #'org-roam-dailies-find-next-note
       :desc "Go to today and yesterday's entries" "T" 'my-org-roam-dailies-split-today
       :desc "Find date" "f" #'org-roam-dailies-find-date))

(setq doom-leader-key ",")

; set closed time on todo close
(setq org-log-done 'time)

; external keyboard alt key as meta
(cond (IS-MAC
       (setq
             mac-right-option-modifier 'meta)))

(define-key  evil-normal-state-map (kbd "C-k") '+workspace/switch-right)
(define-key  evil-normal-state-map (kbd "C-j") '+workspace/switch-left)

(map! "C-k" #'+workspace/switch-right)
(map! "C-j" #'+workspace/switch-left)


(defun myblah-org-roam-dailies-today ()
   (let ((split-width-threshold 0)
         (split-height-threshold nil))
     (org-roam-dailies-capture-today)))

(defun my-org-roam-dailies-split-today ()
  "Split today function"
  (interactive)
  (+workspace/new)
  (+workspace/rename "today")
  (org-roam-dailies-find-today)
  (split-window-vertically)
  (other-window 1)
  (org-roam-dailies-find-previous-note 1)
  (goto-line 5)
  (fit-window-to-buffer)
  (previous-window-any-frame))


; maximize on startup
(add-to-list 'initial-frame-alist '(fullscreen . maximized))

; custom todo states (not working)
(after! org
(setq org-todo-keywords
      '((sequence "TODO" "[ ]" "NEXT" "DOING" "WAITING" "DONE" "PROJ" "|" "DONE" "[X]"))))
