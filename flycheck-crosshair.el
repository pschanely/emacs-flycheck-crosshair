;;; flycheck-crosshair.el --- Support crosshair in flycheck

;; Copyright (C) 2019 Phillip Schanely <pschanely@gmail.com>
;;
;; Author: Phillip Schanely <pschanely@gmail.com>
;; Created: 23 October 2019
;; Version: 1.0
;; Package-Requires: ((flycheck "0.18"))

;;; Commentary:

;; This package adds CrossHair support for flycheck.

;; There isn't a MELPA package for this yet.
;; To install, you can put this file in a place that your Emacs will
;; look for packages.

;; (or you can even copy the lines below between "require" and "provide",
;; paste them into your initialization file, and call it a day!)

;; Where is your initialization file?
;; It's likely in ~/.emacs.el, ~/.emacs, or ~/.emacs.d/init.el

;; After doing that, add these additional lines to your initialization file:

;; (require 'flycheck-crosshair)
;; (add-hook 'python-mode-hook 'flycheck-mode)

;; Additionally, you'll likely want to chain crosshair so that it runs after
;; another python checker, usually a type checker like mypy.  If you're using
;; flycheck-mypy, for example, add this line:

;; (flycheck-add-next-checker 'python-mypy 'python-crosshair)

;; Then you should be all set.

;;; License:

;; This file is not part of GNU Emacs.
;; However, it is distributed under the same license.

;; GNU Emacs is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 3, or (at your option)
;; any later version.

;; GNU Emacs is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to the
;; Free Software Foundation, Inc., 51 Franklin Street, Fifth Floor,
;; Boston, MA 02110-1301, USA.

;;; Code:


(require 'flycheck)

(flycheck-define-checker python-crosshair
  "Crosshair verifier."
  :command ("crosshair" "check" source-original)
  :error-patterns
  ((info    line-start (file-name) ":" line ":info:"    (message) line-end)
   (warning line-start (file-name) ":" line ":warning:" (message) line-end)
   (error   line-start (file-name) ":" line ":error:"   (message) line-end)
   ; Above are older formats; newer formats below: (TODO remove above by EO2021)
   (info    line-start (file-name) ":" line ": info: "    (message) line-end)
   (warning line-start (file-name) ":" line ": warning: " (message) line-end)
   (error   line-start (file-name) ":" line ": error: "   (message) line-end))
  :modes python-mode)


(add-to-list 'flycheck-checkers 'python-crosshair t)


(provide 'flycheck-crosshair)
;;; flycheck-crosshair.el ends here
