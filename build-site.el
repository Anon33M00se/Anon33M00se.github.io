;;
;; Bring in the package system (elpa/melpa), make sure that is not
;; messing with our normal (user) package dir but is doing so in the
;; local .packages directory, and then bring in htmlize (mostly for
;; syntax highlighting in code blocks).
;;

(require 'package)
(setq package-user-dir (expand-file-name "./.packages"))
(setq package-archives '(("melpa" . "https://melpa.org/packages/"   )
			 ("elpa"  . "https://elpa.gnu.org/packages" )))

;; Init the package system
(package-initialize)
(unless package-archive-contents
  (package-refresh-contents))

;; Install dependencies
(package-install 'htmlize)

;;
;; Load the publishing system
;;
(require 'ox-publish)

(setq org-html-validation-link             nil ;; don't show a "Validate" link at the bottom of the page
      org-html-head-include-scripts        nil ;; don't put default org-html export scripts in place
      org-html-doctype                 "html5"
      org-html-html5-fancy                   t
      org-html-head-include-default-style  nil ;; skip the default style sheet
      org-html-head "<link rel=\"stylesheet\" href=\"https://cdn.simplecss.org/simple.min.css\"/>\n<link rel=\"stylesheet\" type=\"text/css\" href=\"customizations.css\" />\n<meta name=\"viewport\" content=\"width=device-width, initial-scale=0.25\">")

(setq org-publish-project-alist
  (list
   (list "stuff"
     :recursive t
     :base-directory "./content"
     :base-extension "org"
     :publishing-directory "./public"
     :publishing-function 'org-html-publish-to-html
     :with-author nil
     :with-title nil
     :with-creator t
     :with-toc nil
     :section-numbers nil
     :time-stamp-file t)))
;;   (list "static"
;;     :recursive t
;;     :base-directory "./static"
;;     :publishing-directory "./public"
;;     :publishing-function 'org-html-publish-to-html
;;     :with-author nil
;;     :with-title nil
;;     :with-creator t
;;     :with-toc nil
;;     :section-numbers nil
;;     :time-stamp-file t)))

(org-publish-all t)
     

(message "Build complete!")

