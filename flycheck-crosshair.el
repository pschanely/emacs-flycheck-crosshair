;;; flycheck-crosshair.el --- Support crosshair in flycheck

;; Copyright (C) 2019 Phillip Schanely <pschanely@gmail.com>
;;
;; Author: Phillip Schanely <pschanely@gmail.com>
;; Created: 23 October 2019
;; Version: 1.0
;; Package-Requires: ((flycheck "0.18"))

;;; Commentary:

;; This package adds support for cross to flycheck.  To enable it, add
;; to your init.el:

;; (require 'flycheck-crosshair)

;; You'll want to chain crosshair so that it runs after another python
;; checker, usually a type checker like mypy.  If you're using
;; flycheck-mypy, for example:

;; (flycheck-add-next-checker 'python-mypy 'python-crosshair)

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
   (error   line-start (file-name) ":" line ":error:"   (message) line-end))
  :modes python-mode
  :predicate flycheck-buffer-saved-p)


(add-to-list 'flycheck-checkers 'python-crosshair t)


(provide 'flycheck-crosshair)
;;; flycheck-crosshair.el ends here
