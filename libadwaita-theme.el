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
    (window-bg-light . "#fafafb")
    (window-bg-dark . "#222226")
    (window-fg-light . "#333338")
    (window-fg-dark . "#ffffff")
    (view-bg-light . "#ffffff")
    (view-bg-dark . "#1d1d20") ;; Same as libadwaita-dark from [libadwaita-dark.xml]
    (view-fg-light . "#333338")
    (view-fg-dark . "#ffffff")
    (sidebar-bg-light . "#ebebed")
    (sidebar-bg-dark . "#2e2e32")
    (sidebar-fg-light . "#333338")
    (sidebar-fg-dark . "#ffffff")
    (sidebar-backdrop-light . "#f2f2f4")
    (sidebar-backdrop-dark . "#28282c")
    (secondary-sidebar-bg-light . "#f3f3f5")
    (secondary-sidebar-bg-dark . "#28282c")
    (secondary-sidebar-fg-light . "#333338")
    (secondary-sidebar-fg-dark . "#ffffff")
    (secondary-sidebar-backdrop-light . "#f6f6fa")
    (secondary-sidebar-backdrop-dark . "#252529")
    (headerbar-bg-light . "#ffffff")
    (headerbar-bg-dark . "#2e2e32")
    (headerbar-fg-light . "#333338")  
    (headerbar-fg-dark . "#ffffff")
    (headerbar-backdrop-light . "#fafafb") ; same as window-bg
    (headerbar-backdrop-dark . "#222226")  ; same as window-bg
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
    (libadwaita-dark . "#1d1d20")
    (libadwaita-dark-alt . "#242428")
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

(defvar la/light '((background light)))
(defvar la/dark '((background dark)))


(let-alist libadwaita-colors
  (la/defface la/accent-background
    `((,la/light
       :background ,(la/mix (la/accent-bg-color) .view-bg-light 0.30))
      (,la/dark
       :background ,(la/mix (la/accent-bg-color) .view-bg-dark 0.30))))
  
  (la/defface la/accent-ui-underline
    `((t
       :underline (:color ,(la/accent-color) :position t))))
  
  (la/defface la/accent-foreground
    `((,la/light
       :foreground ,(la/light-accent-fg-color))
      (,la/dark
       :foreground ,(la/dark-accent-fg-color))))
  
  (la/defface la/accent-wavy-underline
    `((,la/light
       :underline (:color ,(la/light-accent-fg-color) :style wave))
      (,la/dark
       :underline (:color ,(la/dark-accent-fg-color) :style wave))))
  
  (custom-theme-set-faces
   'libadwaita
   `(default
     ((,la/light
       :background ,.view-bg-light
       :foreground ,.view-fg-light)
      (,la/dark
       :background ,.view-bg-dark
       :foreground ,.view-fg-dark)))
   `(window-divider
     ((,la/light
       :foreground ,(la/mix .view-fg-light .view-bg-light 0.15))
      (,la/dark
       :foreground ,(la/mix .view-fg-dark .view-bg-dark 0.15))))
   `(window-divider-last-pixel
     ((,la/light
       :foreground ,.window-bg-light)
      (,la/dark
       :foreground ,.window-bg-dark)))
   `(window-divider-first-pixel
     ((t
       :inherit window-divider-last-pixel)))
   `(fringe
     ((,la/light
       :background ,.window-bg-light)
      (,la/dark
       :background ,.window-bg-dark)))
   `(margin
     ((t
       :inherit fringe)))
   `(scroll-bar
     ((,la/light
       :background ,.window-bg-light)
      (,la/dark
       :background ,.window-bg-dark)))
   `(mode-line
     ((,la/light
       :background ,.headerbar-bg-light
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.headerbar-fg-light
       :inherit   variable-pitch
       :overline ,(la/mix .window-fg-light .window-bg-light 0.15))
      (,la/dark
       :background ,.headerbar-bg-dark
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.headerbar-fg-dark
       :inherit variable-pitch
       :overline ,(la/mix .window-fg-dark .window-bg-dark 0.15))))
   `(mode-line-active
     ((t
       :inherit (mode-line la/accent-ui-underline))))
   `(mode-line-inactive
     ((,la/light
       :background ,.headerbar-backdrop-light
       :foreground ,(la/mix .headerbar-fg-light
                            .headerbar-backdrop-light 0.55)
       :inherit mode-line)
      (,la/dark
       :background ,.headerbar-backdrop-dark
       :foreground ,(la/mix .headerbar-fg-dark
                            .headerbar-backdrop-dark 0.55)
      :inherit mode-line)))
   `(mode-line-highlight
     ((t
       :foreground ,.light-8))) ;; TODO
   `(mode-line-buffer-id
     ((t
       :weight bold)))
   `(mode-line-emphasis
     ((t
       :weight bold)))
   `(header-line
     ((,la/light
       :background ,.secondary-sidebar-bg-light
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.secondary-sidebar-fg-light
       :inherit variable-pitch
       :underline (:position t :color ,(la/mix .window-fg-light
                                               .window-bg-light 0.15)))
      (,la/dark
       :background ,.secondary-sidebar-bg-dark
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.secondary-sidebar-fg-dark
       :inherit variable-pitch
       :underline (:position t :color ,(la/mix .window-fg-dark
                                               .window-bg-dark 0.15)))))
   `(header-line-active
     ((t
       :inherit header-line)))
   `(header-line-inactive
     ((,la/light
       :background ,.secondary-sidebar-backdrop-light
       :foreground ,(la/mix .secondary-sidebar-fg-light
                            .secondary-sidebar-backdrop-light 0.15)
       :inherit header-line)
      (,la/dark
       :background ,.secondary-sidebar-backdrop-dark
       :foreground ,(la/mix .secondary-sidebar-fg-dark
                            .secondary-sidebar-backdrop-dark 0.15)
       :inherit header-line)))
   `(header-line-highlight
     ((t
       :inherit mode-line-highlight)))
   `(tab-bar
     ((,la/light
       :background ,.window-bg-light
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.window-fg-light
       :inherit variable-pitch
       :underline (:color ,.window-bg-light :position t))
      (,la/dark
       :background ,.window-bg-dark
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.window-fg-dark
       :inherit variable-pitch
       :underline (:color ,.window-bg-dark :position t))))
   `(tab-bar-tab-inactive
     ((t
       :inherit (tab-bar))))
   `(tab-bar-tab
     ((,la/light
       :background ,(la/darken .window-bg-light 0.08)
       :foreground ,.window-fg-light
       :inherit tab-bar)
      (,la/dark
       :background ,(la/brighten .window-bg-dark 0.10)
       :inherit tab-bar)))
   `(tab-bar-tab-highlight
     ((,la/light
       :background ,(la/darken .window-bg-light 0.12) ;;arbitrary
       :foreground ,.window-fg-light
       :inherit tab-bar-tab)
      (,la/dark
       :inherit tab-bar-tab
       :background ,(la/brighten .window-bg-dark 0.15))))
   `(tab-line
     ((,la/light
       :background ,.window-bg-light
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.window-fg-light
       :inherit variable-pitch
       :underline (:position t :color ,(la/mix .window-fg-light
                                               ;;was 0.15. 0.05 looks good
                                               .window-bg-light 0.05)))
      (,la/dark
       :background ,.window-bg-dark
       :box (:line-width (4 . 4) :style flat-button)
       :foreground ,.window-fg-dark
       :inherit variable-pitch
       :underline (:color ,(la/mix .window-fg-dark .window-bg-dark 0.05)
                          :position t))))
   `(tab-line-inactive
     ((,la/light
       :background ,.window-backdrop-light
       :foreground ,(la/mix .window-fg-light
                            .window-bg-light
                            0.55)
       :inherit tab-line)
      (,la/dark
       :background ,.window-backdrop-dark
       :foreground ,(la/mix .window-fg-dark
                            .window-bg-dark 0.55)
       :inherit tab-line)))
   `(tab-line-tab-current ; Current tab in selected windows
     ((,la/light
       :background ,(la/darken .window-bg-light 0.08)
       :inherit tab-line)
      (,la/dark
       :background ,(la/brighten .window-bg-dark 0.10)
       :inherit tab-line)))
   `(tab-line-tab  ; Current tab in non-selected (inactive) windows
     ((,la/light
       :background ,(la/darken .window-bg-light 0.04)
       :inherit tab-line-current) ;; Inventato
      (,la/dark
      :background ,(la/brighten .window-bg-dark 0.06)
      :inherit tab-line-current))) ;; Inventato
   `(tab-line-tab-inactive ; Non-selected tabs in all windows
     ((t
       :inherit tab-line-inactive))) ;same as tab-line-inactive.
   `(tab-line-tab-inactive-alternate
     ((,la/light
       :background ,(la/darken .window-bg-light 0.05)
       :inherit tab-line-tab-inactive) ; by heart
      (,la/dark
       :background ,(la/brighten .window-bg-dark 0.05)
       :inherit tab-line-tab-inactive)))
   `(tab-line-highlight
     ((,la/light
       :background ,(la/darken .window-bg-light 0.10))
      (,la/dark
       :background ,(la/brighten .window-bg-dark 0.15))))
   `(tab-line-tab-modified
     ((t))) 
   ;;Font-lock
   `(font-lock-builtin-face
     ((t
       :foreground ,.blue-4)))
   `(font-lock-comment-face
     ((t
       :foreground ,.shade-1)))
   `(font-lock-constant-face
     ((,la/light
       :foreground ,.violet-4)
      (,la/dark
       :foreground ,.violet-2)))
   `(font-lock-function-call-face
     ((,la/light
       :foreground ,.blue-4)  
      (,la/dark
       :foreground ,.blue-2)))
   `(font-lock-function-name-face
     ((t)))
   `(font-lock-keyword-face
     ((,la/light
       :foreground ,.orange-5 :weight bold)
      (,la/dark
       :foreground ,.orange-4 :weight bold)))
   `(font-lock-number-face
     ((,la/light
       :foreground ,.violet-4)
      (,la/dark
       :foreground ,.violet-2
       )))
   `(font-lock-preprocessor-face ;;CHECK
     ((,la/light
       :foreground ,.teal-5)
      (,la/dark
       :foreground ,.teal-3)))
   `(font-lock-string-face
     ((,la/light
       :foreground ,.teal-5)
      (,la/dark
       :foreground ,.teal-2)))
   `(font-lock-type-face
     ((,la/light
       :foreground ,.teal-5 :weight bold)
      (,la/dark
       :foreground ,.teal-2 :weight bold)))
   `(font-lock-variable-name-face
     ((t
       :inherit 'default)))
   `(highlight
     ((t
       :box (:line-width (1 . 1))
       :weight bold )))
   `(hl-line
     ((,la/light
       :background ,.light-3
       :extend t)
      (,la/dark
       :background ,.libadwaita-dark-alt
       :extend t)))
   `(isearch
     ((t
       :background ,.blue-3
       :foreground ,.light-1)))
   `(lazy-highlight
     ((t
       :background ,.yellow-1
       :distant-foreground "black")))
   `(shadow
     ((,la/light
       :foreground ,.light-7)
      (,la/dark
       :foreground ,.dark-1)))
   ;; Line-number
   `(line-number
     ((t
       :inherit (shadow default))))
   ;;TODO maybe inherit from line-number-major-tick?
   `(line-number-current-line 
     ((t
       :inherit (hl-line line-number)
       :weight bold)))
   `(line-number-major-tick
     ((,la/light 
       :foreground ,.shade-1)
      (,la/dark
       :foreground ,.light-7)))
   `(line-number-minor-tick
     ((,la/light
       :foreground ,.light-5)
      (,la/dark
       :foreground ,.dark-3)))
   `(link
     ((,la/light
       :foreground ,.blue-3
       :underline t)
      (,la/dark
       :foreground ,.blue-2
       :underline t)))
   `(link-visited ;;color-mix(in srgb, var(--accent-color) 80%, var(--view-fg-color)
     ((t
       :inherit link :foreground ,.purple-4)))
   `(minibuffer-prompt
     ((t
       :inherit (la/accent-foreground default)
       :weight bold)))
   `(compilation-mode-line-fail
     ((t
       :inherit compilation-error
       :weight bold)))
   `(cursor
     ((,la/light
       :background ,.shade-1)
      (,la/dark
       :background ,.light-5)))
   `(diff-added
     ((,la/light
       :foreground ,.teal-4)
      (,la/dark
       :foreground ,.teal-3)))
   `(diff-changed
     ((,la/light
       :foreground ,.orange-4)
      (,la/dark
       :foreground ,.orange-3)))
   `(diff-removed
     ((t 
       :foreground ,.red-1)))
   `(diff-error
     ((t
       :inherit error)))
   `(diff-file-header
     ((t
       :weight bold)))
   `(diff-header
     ((t
       :foreground ,.violet-4)))
   `(diff-hunk-header
     ((t
       :foreground ,.yellow-6)))
   `(diff-indicator-added
     ((t
       :inherit diff-added)))
   `(diff-indicator-changed
     ((t
       :inherit diff-changed)))
   `(diff-indicator-removed
     ((t
       :inherit diff-removed)))
   `(diff-refine-added
     ((t
       :weight bold)))
   `(diff-refine-changed
     ((t
       :weight bold)))
   `(diff-refine-removed
     ((t
       :inherit diff-refine-changed :weight bold)))
   `(elisp-shorthand-font-lock-face
     ((t
       :inherit font-lock-keyword-face)))
   `(error
     ((t
       :foreground ,.red-4 :weight bold)))
   `(flymake-error
     ((t
       :underline (:color ,.red-4 :style wave :position nil))))
   `(flymake-warning
     ((t
       :underline (:color ,.yellow-4 :style wave :position nil))))
   `(flymake-note
     ((t
       :inherit la/accent-wavy-underline)))
   `(flymake-note-echo
     ((t
       :inherit la/accent-foreground
       :weight bold)))
   `(flymake-note-echo-at-eol
     ((t
       :inherit (flymake-end-of-line-diagnostics-face flymake-note-echo))))
   `(flymake-note-fringe
     ((t
       :inherit flymake-note-echo)))
   `(match
     ((,la/light
       :background ,.yellow-2
       :distant-foreground ,.shade-4)
      (,la/dark
       :background "#897827"
       :distant-foreground ,.dark-5)))
   `(speedbar-file-face
     ((t
       :inherit default)))

   `(speedbar-directory-face
     ((t
       :inherit (speedbar-file-face la/accent-foreground)
       :weight bold)))
   `(speedbar-selected-face
     ((t
       :inherit highlight))) ;; TODO

   `(speedbar-button-face
     ((t
       :foreground ,.gray-3))) ;; TODO
   ;;ANSI
   `(ansi-color-black
     ((t
       :background ,.ansi-black
       :foreground ,.ansi-black)))
   `(ansi-color-blue
     ((t
       :background ,.ansi-blue
       :foreground ,.ansi-blue)))
   `(ansi-color-bright-black
     ((t
       :background ,.ansi-bright-black
       :foreground ,.ansi-bright-black)))
   `(ansi-color-bright-blue
     ((t
       :background ,.ansi-bright-blue
       :foreground ,.ansi-bright-blue)))
   `(ansi-color-bright-cyan
     ((t
       :background ,.ansi-bright-cyan
       :foreground ,.ansi-bright-cyan)))
   `(ansi-color-bright-green
     ((t
       :background ,.ansi-bright-green
       :foreground ,.ansi-bright-green)))
   `(ansi-color-bright-magenta
     ((t
       :background ,.ansi-bright-magenta
       :foreground ,.ansi-bright-magenta)))
   `(ansi-color-bright-red
     ((t
       :background ,.ansi-bright-red
       :foreground ,.ansi-bright-red)))
   `(ansi-color-bright-yellow
     ((t
       :background ,.ansi-bright-yellow
       :foreground ,.ansi-bright-yellow)))
   `(ansi-color-cyan
     ((t
       :background ,.ansi-cyan
       :foreground ,.ansi-cyan)))
   `(ansi-color-green
     ((t
       :background ,.ansi-green
       :foreground ,.ansi-green)))
   `(ansi-color-magenta
     ((t :background ,.ansi-magenta
         :foreground ,.ansi-magenta)))
   `(ansi-color-red
     ((t :background ,.ansi-red
         :foreground ,.ansi-red)))
   `(ansi-color-white
     ((t :background ,.ansi-white
         :foreground ,.ansi-white)))
   `(ansi-color-yellow
     ((t :background ,.ansi-yellow
         :foreground ,.ansi-yellow)))
   `(orderless-match-face-0
     ((t
       :foreground "#8939A4")))
   `(orderless-match-face-1
     ((t
       :inherit orderless-match-face-0)))
   `(orderless-match-face-2
     ((t
       :inherit orderless-match-face-0)))
   `(orderless-match-face-3
     ((t
       :inherit orderless-match-face-2)))
   `(org-mode-line-clock-overrun
     ((t
       :inherit error)))
   `(region
     ((t
       :inherit la/accent-background
       :extend t)))
   `(show-parent-match
     ((t
       :weight bold)))
   `(breadcrumb-imenu-leaf-face
     ((t
       :inherit la/accent-foreground
       :weight bold)))
   `(trailing-whitespace
     ((t
       :foreground ,.light-7)))
   `(vertical-border
     ((,la/light
       :background ,.light-1
       :foreground ,.light-1)
      (,la/dark
       :background "#000000"
       :foreground "#000000")))
   `(elisp-symbol-at-mouse
     ((t
       :background unspecified)))
   `(markdown-header-face
     ((t
       :foreground ,.teal-5
       :weight bold)))
   `(markdown-list-face
     ((,la/light
       :foreground ,.orange-5
       :weight bold)
      (,la/dark
       :foreground ,.orange-4
       :weight bold)))
   `(diff-hl-change
     ((t
       :inherit diff-changed)))
   `(diff-hl-delete
     ((t
       :inherit diff-removed)))
   `(diff-hl-insert
     ((t
       :inherit diff-added)))))

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

;; Local Variables:
;; read-symbol-shorthands: (("la/" . "libadwaita-"))
;; End:
