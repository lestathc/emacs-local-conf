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

(defgroup local-conf
  nil
  "Local Conf.")

(defcustom local-conf-files
  '(".el" ".conf.el" ".conf.emacs" ".conf.spacemacs")
  "List of possible dir local configuration files, order matters"
  )

(defcustom local-conf-load-parent
  nil
  "Whether load the parent config if no any local configuration found.")

(defcustom local-conf-load-once
  t
  "Whether load same config file only once.")

(defun local-conf--find-conf-from-dir (dirname)
  (local-conf--debug-message
   (concat "Try to find configuration under: " dirname))
  (let ((tmplist local-conf-files)
        (found nil))
    (progn
      (while (and (car tmplist)
                  (not found))
        (let ((conffile (concat dirname (car tmplist))))
          (progn
            (local-conf--debug-message (concat "Check file: " conffile))
            (if (file-readable-p conffile)
                (setq found conffile))
            )
          )
        (setq tmplist (cdr tmplist))
        )
      (if found
          (progn
            (local-conf--debug-message (concat "Found file: " found))
            found
            )
        (progn
          (local-conf--debug-message "Try to find in parent folder")
          (if (and local-conf-load-parent
                   (not (equal dirname "/")))
              (local-conf--find-conf-from-dir (file-name-directory (directory-file-name dirname)))
            )
          )
        )
      )
    )
  )

(defun local-conf--find-conf-from-file (filename)
  (local-conf--find-conf-from-dir (file-name-directory filename))
  )

(defun local-conf-open-local-conf-for-file (filename)
  "Open the local conf file for given file name."
  (interactive "fOpen local conf for:")
  (if filename
      (let ((conffile (local-conf--find-conf-from-file filename)))
        (if conffile
            (find-file conffile)
          (message "Unable to find any conf file.")
          )
        )
    )
  )

(defun local-conf-open-buffer-local-conf (ignore)
  "Open the local conf file for current buffer."
  (interactive "i")
  (local-conf-open-local-conf-for-file buffer-file-name)
  )

;; (setq -local-conf-debug t)
;; (local-conf--find-conf-from-file buffer-file-name)

;; >>>>>>>> Debug <<<<<<<<

(defvar -local-conf-debug nil)

(defun local-conf--debug-message (msg)
  (if -local-conf-debug
      (message msg)
    )
  )

(provide 'local-conf)
