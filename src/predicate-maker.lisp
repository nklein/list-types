;;; predicate-maker.lisp

(in-package #:list-types)

(defpackage #:list-types/predicate-package
  (:use))

(defun make-range-comparison (length-sexp min-elements max-elements)
  (let ((low (unless (or (eql min-elements '*)
                         (eql min-elements 0))
               min-elements))
        (high (unless (eql max-elements '*)
                max-elements)))
    (when (or low high)
      `(<= ,@(when low (list low))
           ,length-sexp
           ,@(when high (list high))))))

(defun make-sequence-predicate-lambda (type min-elements max-elements)
  (let ((comparison (make-range-comparison '(length list)
                                           min-elements
                                           max-elements)))

    `(lambda (list)
       (flet ((validp (m)
                (typep m ',type)))
         ,(if comparison
              `(and ,comparison
                    (every #'validp list))
              `(every #'validp list))))))

(defun make-sequence-of-predicate (type min-elements max-elements)
  (let* ((type (if (eql type '*)
                   t
                   type))
         (name (intern (format nil "SEQUENCE-OF-~S-WITH-LENGTH-~S-~S-P"
                               type min-elements max-elements)
                       (string '#:list-types/predicate-package))))
    (unless (fboundp name)
      (setf (symbol-function name)
            (compile nil (make-sequence-predicate-lambda type
                                                         min-elements
                                                         max-elements))))
    name))

(defmacro ensure-sequence-type (&optional (type '*)
                                          (min-elements '*)
                                          (max-elements '*))
  `(make-sequence-of-predicate ',type
                               ,(if (symbolp min-elements)
                                    `(quote ,min-elements)
                                    min-elements)
                               ,(if (symbolp max-elements)
                                    `(quote ,max-elements)
                                    max-elements)))

(defmacro ensure-sequence-type* (&optional (type '*))
  `(make-sequence-of-predicate ',type 0 '*))

(defmacro ensure-sequence-type+ (&optional (type '*))
  `(make-sequence-of-predicate ',type 1 '*))
