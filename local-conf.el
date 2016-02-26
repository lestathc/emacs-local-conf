;;; local-conf.el --- Load the local emacs configuration file automatically

;; Author: Cong Hui (lestathc@gmail.com)
;; URL: https://github.com/lestathc/emacs-local-conf
;; Version: 0.1

;; This file is not part of GNU Emacs

;; This file is free software; you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation; either version 2, or (at your option)
;; any later version.

;; This file is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.

;; You should have received a copy of the GNU General Public License
;; along with GNU Emacs; see the file COPYING.  If not, write to
;; the Free Software Foundation, Inc., 59 Temple Place - Suite 330,
;; Boston, MA 02111-1307, USA.

;;; Commentary:

;;; Code:

(defgroup local-conf nil
  "Local Conf.")

(defcustom local-conf-files
  '(".el" ".conf.el" ".conf.emacs" ".conf.spacemacs")
  "List of possible dir local configuration files, order matters"
  )


;;; Code for debug:

(defvar -local-conf-debug t)

(defun local-conf--debug-message (msg)
  (progn
    (if (equal -local-conf-debug t)
        (message msg)
      )
    )
  )

(provide 'local-conf)
