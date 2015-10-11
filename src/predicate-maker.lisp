;;; predicate-maker.lisp

(in-package #:list-types)

(defpackage #:list-types/predicate-package
  (:use))

(defun make-sequence-predicate-lambda (type length-type)
  `(lambda (list)
     (flet ((validp (m)
              (typep m ',type)))
       ,(if (eql length-type '*)
            `(every #'validp list)
            `(and (typep (length list) ',length-type)
                  (every #'validp list))))))

(defun make-sequence-of-predicate (type length)
  (let* ((type (if (eql type '*)
                   t
                   type))
         (length-type (cond
                        ((integerp length)
                         `(integer ,length ,length))
                        ((eql length '*)
                         t)
                        (t
                         length)))
         (name (intern (format nil "SEQUENCE-OF-~S-WITH-LENGTH-~S-P"
                               type length-type)
                       (string '#:list-types/predicate-package))))
    (unless (fboundp name)
      (setf (symbol-function name)
            (compile nil (make-sequence-predicate-lambda type length-type))))
    name))

(defmacro ensure-sequence-type (&optional (type '*) (length '*))
  `(make-sequence-of-predicate ',type ',length))

(defmacro ensure-sequence-type* (&optional (type '*))
  `(make-sequence-of-predicate ',type '(integer 0 *)))

(defmacro ensure-sequence-type+ (&optional (type '*))
  `(make-sequence-of-predicate ',type '(integer 1 *)))
