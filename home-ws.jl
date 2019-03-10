;;; home-ws.jl --- Jump to "home" workspace when other workspaces become empty.
;; Copyright 1999 by Dave Pearson <davep@davep.org>
;; $Revision: 1.1 $

;; home-ws.jl is free software distributed under the terms of the GNU
;; General Public Licence, version 2. For details see the file COPYING.

;;; Commentary:
;;
;; home-ws.jl is a very simple sawmill package that makes sawmill
;; automaticly switch to your "home" workspace when the last window in your
;; current workspace is removed.
;;
;; To enable this feature simply drop this file into your `load-path' and
;; add this:
;;
;; (require 'home-ws)
;;
;; to your ~/.sawmillrc file.

;;; Code:

;; Customise options.

(defgroup home-ws "Home workspace")

(defcustom home-ws-workspace 0
  "Location of your home workspace"
  :group home-ws
  :type  number
  :range (0 . nil))

;; Main code.

(defun home-ws-handler ()
  "`destroy-notify-hook' handler."
  (when (zerop (length (workspace-windows current-workspace)))
    (select-workspace-from-first home-ws-workspace)))

(unless (in-hook-p 'destroy-notify-hook home-ws-handler)
  (add-hook 'destroy-notify-hook home-ws-handler))

(provide 'home-ws)

;;; home-ws.jl ends here
