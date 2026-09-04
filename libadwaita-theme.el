;; -*- lexical-binding: t; -*-
(deftheme libadwaita
  "Created 2024-12-20.")

(defun la/mix (color1 color2 alpha)
  ;; Maybe rounding error
  (let* ((color1 (color-name-to-rgb color1))
         (color2 (color-name-to-rgb color2))
         (result (color-blend color1 color2 alpha)))
    (pcase-let ((`(,r ,g ,b) result))
      (color-rgb-to-hex r g b 2))))

(defun la/darken (color alpha)
  (la/mix color "#000000" (- 1 alpha)))

(defun la/brighten (color alpha)
  (la/mix color "#ffffff" (- 1 alpha)))

;; Colors are shamelessly copied from here
;; https://gitlab.gnome.org/GNOME/gtksourceview/-/raw/master/data/styles/Adwaita-dark.xml?ref_type=heads
;; https://gitlab.gnome.org/GNOME/gtksourceview/-/blob/master/data/styles/Adwaita.xml?ref_type=heads

;; Other references
;;adwaita-dark.el
;; https://developer.gnome.org/hig/reference/palette.html
;; https://gnome.pages.gitlab.gnome.org/libadwaita/doc/main/css-variables.html

(defvar la/-faces nil)

(defmacro la/defface (face spec &optional doc)
  ""
  (declare (doc-string 3)(indent defun))
  `(let ((spec-fun (lambda () (face-spec-set ',face ,spec))))
     (funcall spec-fun)
     (set-face-documentation ',face ,doc)
     (setf (alist-get ',face la/-faces) spec-fun)
     ',face))

(defun la/refresh-accent-faces ()
  (pcase-dolist (`(,_face . ,spec-fun) la/-faces)
    (funcall spec-fun)))

(defcustom la/accent-color 'blue
  ""
  :type '(choice (const :tag "Blue" blue)
                 (const :tag "Teal" teal)
                 (const :tag "Green" green)
                 (const :tag "Yellow" yellow)
                 (const :tag "Orange" orange)
                 (const :tag "Red" red)
                 (const :tag "Pink" pink)
                 (const :tag "Purple" purple)
                 (const :tag "Slate" slate))
  :set (lambda (sym value)
         (set-default sym value)
         (la/refresh-accent-faces))
  :local nil)

(defvar la/accent-bg-colors
  '((blue   . "#3584e4")
    (teal   . "#2190a4")
    (green  . "#3a944a")
    (yellow . "#c88800")
    (orange . "#ed5b00")
    (red    . "#e62d42")
    (pink   . "#d56199")
    (purple . "#9141ac")
    (slate  . "#6f8396"))
  "")

(defvar la/light-accent-fg-colors
  '((blue   . "#0461be")
    (teal   . "#007184")
    (green  . "#15772e")
    (yellow . "#905300")
    (orange . "#b62200")
    (red    . "#c00023")
    (pink   . "#a2326c")
    (purple . "#8939a4")
    (slate  . "#526678"))
  "")

(defvar la/dark-accent-fg-colors
  '((blue   . "#81d0ff")
    (teal   . "#7bdff4")
    (green  . "#8de698")
    (yellow . "#ffc057")
    (orange . "#ff9c5b")
    (red    . "#ff888c")
    (pink   . "#ffa0d8")
    (purple . "#fba7ff")
    (slate  . "#bbd1e5"))
  "")

(defun la/accent-bg-color ()
  (alist-get la/accent-color la/accent-bg-colors
             "#3584e4"))

(defalias 'la/accent-color #'la/accent-bg-color)

(defun la/light-accent-fg-color ()
  (alist-get la/accent-color la/light-accent-fg-colors
             "#0461be"))

(defun la/dark-accent-fg-color ()
  (alist-get la/accent-color la/dark-accent-fg-colors
             "#81d0ff"))

(defconst libadwaita-colors
  '(
    (blue-1 . "#99C1F1")
    (blue-2 . "#62A0EA")
    (blue-3 . "#3584E4")
    (blue-4 . "#1C71D8")
    (blue-5 . "#1A5FB4")
    (blue-6 . "#1B497E")
    (blue-7 . "#193D66")
    (brown-1 . "#CDAB8F")
    (brown-2 . "#B5835A")
    (brown-3 . "#986A44")
    (brown-4 . "#865E3C")
    (brown-5 . "#63452C")
    (chameleon-3 . "#4E9A06")
    ;; These are dark_* from Adwaita-dark.xml
    (dark-1 . "#777777")
    (dark-2 . "#5E5E5E")
    (dark-3 . "#505050")
    (dark-4 . "#3D3D3D")
    (dark-5 . "#242424")
    (dark-6 . "#121212")
    (dark-7 . "#000000")
    (green-1 . "#8FF0A4")
    (green-2 . "#57E389")
    (green-3 . "#33D17A")
    (green-4 . "#2EC27E")
    (green-5 . "#26A269")
    (green-6 . "#1F7F56")
    (green-7 . "#1C6849")
    (light-1 . "#FFFFFF")
    (light-2 . "#FCFCFC")
    (light-3 . "#F6F5F4")
    (light-4 . "#F1F1F1")
    (light-5 . "#DEDDDA")
    (light-6 . "#C0BFBC")
    (light-7 . "#B0AFAC")
    (light-8 . "#9A9996")
    (orange-1 . "#FFBE6F")
    (orange-2 . "#FFA348")
    (orange-3 . "#FF7800") ;;dark
    (orange-4 . "#E66100") ;;light
    (orange-5 . "#C64600")
    (purple-1 . "#DC8ADD")
    (purple-2 . "#C061CB")
    (purple-3 . "#9141AC")
    (purple-4 . "#813D9C")
    (purple-5 . "#613583")
    (red-1 . "#F66151")
    (red-2 . "#ED333B")
    (red-3 . "#E01B24")
    (red-4 . "#C01C28")
    (red-5 . "#A51D2D")
    ;; These are dark_* from Adwaita.xml
    (shade-1 . "#77767B")
    (shade-2 . "#5E5C64")
    (shade-3 . "#504E55")
    (shade-4 . "#3D3846")
    (shade-5 . "#241F31")
    (shade-6 . "#000000")
    (teal-1 . "#93DDC2")
    (teal-2 . "#5BC8AF")
    (teal-3 . "#33B2A4")
    (teal-4 . "#26A1A2")
    (teal-5 . "#218787")
    (violet-2 . "#7D8AC7")
    (violet-3 . "#6362C8")
    (violet-4 . "#4E57BA")
    (yellow-1 . "#F9F06B")
    (yellow-2 . "#F8E45C")
    (yellow-3 . "#F6D32D")
    (yellow-4 . "#F5C211")
    (yellow-5 . "#E5A50A")
    (yellow-6 . "#D38B09")
    (libadwaita-dark . "#1E1E1E")
    (libadwaita-dark-alt . "#202020")
    (ansi-black . "#1E1E1E")
    (ansi-blue . "#12488B")
    (ansi-bright-black . "#5D5D5D")
    (ansi-bright-blue . "#2A7BDE")
    (ansi-bright-cyan . "#33C7DE")
    (ansi-bright-green . "#33D17A")
    (ansi-bright-magenta . "#C061CB")
    (ansi-bright-red . "#F66151")
    (ansi-bright-yellow . "#E9AD0C")
    (ansi-cyan . "#2AA1B3")
    (ansi-green . "#26A269")
    (ansi-magenta . "#A347BA")
    (ansi-red . "#C01C28")
    (ansi-white . "#CFCFCF")
    (ansi-yellow . "#A2734C")))

(defvar abcz-light '((background light)))
(defvar abcz-dark '((background dark)))

(let-alist libadwaita-colors
  (custom-theme-set-faces
   'libadwaita
    
   ;;ANSI
   `(ansi-color-black
     ((t :background ,.ansi-black :foreground ,.ansi-black)))
   `(ansi-color-blue
     ((t (:background ,.ansi-blue :foreground ,.ansi-blue))))
   `(ansi-color-bright-black
     ((t (:background ,.ansi-bright-black :foreground ,.ansi-bright-black))))
   `(ansi-color-bright-blue
     ((t (:background ,.ansi-bright-blue :foreground ,.ansi-bright-blue))))
   `(ansi-color-bright-cyan
     ((t (:background ,.ansi-bright-cyan :foreground ,.ansi-bright-cyan))))
   `(ansi-color-bright-green
     ((t (:background ,.ansi-bright-green :foreground ,.ansi-bright-green))))
   `(ansi-color-bright-magenta
     ((t (:background ,.ansi-bright-magenta :foreground ,.ansi-bright-magenta))))
   `(ansi-color-bright-red
     )
   `(ansi-color-bright-yellow
     ((t (:background ,.ansi-bright-yellow :foreground ,.ansi-bright-yellow))))
   `(ansi-color-cyan
     ((t (:background ,.ansi-cyan :foreground ,.ansi-cyan))))
   `(ansi-color-green
     ((t (:background ,.ansi-green :foreground ,.ansi-green))))
   `(ansi-color-magenta
     ((t (:background ,.ansi-magenta :foreground ,.ansi-magenta))))
   `(ansi-color-red
     ((t (:background ,.ansi-red :foreground ,.ansi-red))))
   `(ansi-color-white
     ((t (:background ,.ansi-white :foreground ,.ansi-white))))
   `(ansi-color-yellow
     ((t (:background ,.ansi-yellow :foreground ,.ansi-yellow))))
   `(compilation-mode-line-fail
     ((t (:inherit compilation-error :weight bold))))
   `(default
     ((,abcz-light :background ,.light-1 :foreground ,.shade-3)
      (,abcz-dark  :background ,.libadwaita-dark :foreground ,.light-5)))
   `(fringe
     ((,abcz-light :background "#F6F5F4")
      (,abcz-dark :background "#353535"))) 
   
   `(margin ;; Must be same as scrollbar in size and color
     ((t :inherit fringe)))
   `(cursor
     ((,abcz-light :background ,.shade-1)
      (,abcz-dark :background ,.light-5)))
   `(diff-added
     ((,abcz-light :foreground ,.teal-4)
      (,abcz-dark :foreground ,.teal-3)))
   `(diff-changed
     ((,abcz-light :foreground ,.orange-4)
      (,abcz-dark :foreground ,.orange-3)))
   `(diff-removed
     ((t (:foreground ,.red-1))))
   `(diff-error
     ((t (:inherit error))))
   `(diff-file-header
     ((t (:weight bold))))
   `(diff-header
     ((t (:foreground ,.violet-4))))
   `(diff-hunk-header
     ((t (:foreground ,.yellow-6))))
   `(diff-indicator-added
     ((t (:inherit diff-added))))
   `(diff-indicator-changed
     ((t (:inherit diff-changed))))
   `(diff-indicator-removed
     ((t (:inherit diff-removed))))
   `(diff-refine-added
     ((t (:weight bold))))
   `(diff-refine-changed
     ((t (:weight bold))))
   `(diff-refine-removed
     ((t (:inherit diff-refine-changed :weight bold))))
   `(elisp-shorthand-font-lock-face
     ((t (:inherit font-lock-keyword-face))))
   `(error
     ((t (:foreground ,.red-4 :weight bold))))
   `(flymake-error
     ((t (:underline (:color ,.red-4 :style wave :position nil)))))
   `(flymake-warning
     ((t (:underline (:color ,.yellow-4 :style wave :position nil)))))
   `(flymake-note
     ((t (:underline (:color ,.blue-3 :style wave :position nil)))))
   `(flymake-note-echo
     ((t :foreground ,.blue-3 :weight bold)))
   `(flymake-note-echo-at-eol
     ((t :inherit (flymake-end-of-line-diagnostics-face flymake-note-echo))))
   `(flymake-note-fringe
     ((t :inherit flymake-note-echo)))
   `(match
     ((,abcz-light :background ,.yellow-2 :distant-foreground ,.shade-4)
      (,abcz-dark :background "#897827" :distant-foreground ,.dark-5)))
   ;;Font-lock
   `(font-lock-builtin-face
     ((t (:foreground ,.blue-4))))
   `(font-lock-comment-face
     ((t (:foreground ,.shade-1))))
   `(font-lock-constant-face
     ((,abcz-light (:foreground ,.violet-4))
      (,abcz-dark (:foreground ,.violet-2))))
   `(font-lock-function-call-face
     ((,abcz-light (:foreground ,.blue-4))
      (,abcz-dark (:foreground ,.blue-2))))
   `(font-lock-function-name-face
     ((t :inherit default)))
   `(font-lock-keyword-face
     ((,abcz-light (:foreground ,.orange-5 :weight bold))
      (,abcz-dark (:foreground ,.orange-4 :weight bold))))
   `(font-lock-number-face
     ((,abcz-light (:foreground ,.violet-4))
      (,abcz-dark (:foreground ,.violet-2))))
   `(font-lock-preprocessor-face ;;CHECK
     ((,.abcz-light (:foreground ,.teal-5))
      (,.abcz-dark (:foreground ,.teal-3))))
   `(font-lock-string-face
     ((,abcz-light (:foreground ,.teal-5))
      (,abcz-dark (:foreground ,.teal-2))))
   `(font-lock-type-face
     ((,abcz-light (:foreground ,.teal-5 :weight bold))
      (,abcz-dark (:foreground ,.teal-2 :weight bold))))
   `(font-lock-variable-name-face
     ((t :inherit 'default)))
   
   `(highlight
     ((,abcz-light (:background ,.light-3))
      (,abcz-dark (:background ,.libadwaita-dark-alt))))
   `(hl-line
     ((t (:inherit (highlight) :extend t))))
   `(isearch
     ((t (:background ,.blue-3 :foreground ,.light-1))))
   `(lazy-highlight
     ((t (:background ,.yellow-1 :distant-foreground "black"))))
   `(shadow
     ((,abcz-light (:foreground ,.light-7))
      (,abcz-dark (:foreground ,.dark-1))))
   ;; Line-number
   `(line-number
     ((t (:inherit (shadow default)))))
   `(line-number-current-line ;;TODO maybe inherit from line-number-major-tick?
     ((t (:inherit (hl-line line-number) :weight bold))))
   `(line-number-major-tick
     ((,abcz-light (:foreground ,.shade-1))
      (,abcz-dark (:foreground ,.light-7))))
   `(line-number-minor-tick
     ((,abcz-light (:foreground ,.light-5))
      (,abcz-dark (:foreground ,.dark-3))))
   
   `(link
     ((,abcz-light (:foreground ,.blue-3 :underline t))
      (,abcz-dark (:foreground ,.blue-2 :underline t))))
   `(link-visited
     ((t (:inherit link :foreground ,.purple-4))))
   `(minibuffer-prompt
     ((t (:inherit default :weight bold))))


   ;;Header line and mode line
   `(mode-line
     ((,abcz-light (:box (:line-width (4 . 4) :style flat-button) :inherit variable-pitch :background ,.light-4))
      (,abcz-dark (:box (:line-width (4 . 4) :style flat-button) :inherit variable-pitch :background ,.dark-4))))
   `(mode-line-active
     ((t (:inherit mode-line))))
   `(mode-line-buffer-id
     ((t (:weight bold))))
   `(mode-line-emphasis
     ((t (:weight bold))))
   `(mode-line-highlight
     ((t (:foreground ,.light-8))))
   `(mode-line-inactive
     ((,abcz-light (:inherit mode-line :background ,.light-2 :foreground ,.light-8))
      (,abcz-dark (:inherit mode-line :background ,.dark-2 :foreground ,.dark-1))))
   `(header-line
     ((t (:inherit mode-line))))
   `(header-line-active
     ((t (:inherit header-line))))
   `(header-line-highlight
     ((t :inherit mode-line-highlight)))
   `(header-line-inactive
     ((t (:inherit mode-line-inactive))))



   
   `(orderless-match-face-0
     ((t (:foreground "#8939A4"))))
   `(orderless-match-face-1
     ((t (:inherit orderless-match-face-0))))
   `(orderless-match-face-2
     ((t (:inherit orderless-match-face-0))))
   `(orderless-match-face-3
     ((t (:inherit orderless-match-face-2))))
   `(org-mode-line-clock-overrun
     ((t (:inherit error))))
   `(region
     ((t (:extend t :background "#DEC6E6"))))
   `(show-parent-match
     ((t (:weight bold))))
   `(tab-line-tab
     ((t)))
   `(tab-line-tab-active
     ((t)))
   `(tab-line-tab-inactive
     ((t)))
   `(trailing-whitespace
     ((t (:foreground ,.light-7))))
   `(vertical-border
     ((,abcz-light :background ,.light-1 :foreground ,.light-1)
      (,abcz-dark :background "#000000" :foreground "#000000")))
   `(elisp-symbol-at-mouse
     ((t :background unspecified)))
   `(markdown-header-face
     ((t (:foreground ,.teal-5 :weight bold))))
   `(markdown-list-face
     ((,abcz-light (:foreground ,.orange-5 :weight bold))
      (,abcz-dark (:foreground ,.orange-4 :weight bold))))
   `(diff-hl-change
     ((t (:inherit diff-changed))))
   `(diff-hl-delete
     ((t :inherit diff-removed)))
   `(diff-hl-insert
     ((t :inherit diff-added)))))

;;;###autoload
(when load-file-name
  (add-to-list
   'custom-theme-load-path
   (file-name-as-directory
    (if (string=
         (file-truename (file-name-directory load-file-name))
         (file-truename (file-name-as-directory user-lisp-directory)))
        ;; as of today, user-lisp's autoloads are not generated
        ;; in the same dir as its source files
        (expand-file-name "libadwaita-theme" user-lisp-directory)
      (file-name-directory load-file-name)))))

(provide-theme 'libadwaita)
(provide 'libadwaita-theme)
;;; libadwaita-theme.el ends here
