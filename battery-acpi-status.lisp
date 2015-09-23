;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;
;; battery-acpi-status
;; Copyright (C) 2015 Richard Bäck
;;
;; This program is free software: you can redistribute it and/or modify
;; it under the terms of the GNU General Public License as published by
;; the Free Software Foundation, either version 3 of the License, or
;; (at your option) any later version.

;; This program is distributed in the hope that it will be useful,
;; but WITHOUT ANY WARRANTY; without even the implied warranty of
;; MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
;; GNU General Public License for more details.
;;
;; You should have received a copy of the GNU General Public License
;; along with this program.  If not, see <http://www.gnu.org/licenses/>.
;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;;

(in-package #:battery-acpi-status)

(export '(get-battery-status))

(dolist (a '((#\b get-battery-status)))
  (pushnew a *screen-mode-line-formatters* :test 'equal))

(defun get-battery-status (&rest args)
  "Returns the battery status as string."
  (declare (ignore args))
  (let ((shell-ret (trivial-shell:shell-command "acpi -b")))
    (if (cl-ppcre:scan "Battery" shell-ret)
        (progn
          (setf shell-ret (subseq shell-ret 11))
          (remove #\,
                  (subseq shell-ret 0 (- (length shell-ret) 1))))
        "No battery present")))


