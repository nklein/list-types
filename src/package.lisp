;;;; package.lisp

(defpackage #:list-types
  (:use #:cl)
  (:import-from #:alexandria
                #:proper-list
                #:circular-list
                #:proper-sequence)
  (:export #:proper-list
           #:circular-list
           #:proper-sequence)
  (:export #:ensure-sequence-type
           #:ensure-sequence-type*
           #:ensure-sequence-type+)
  (:export #:sequence-of
           #:sequence-of*
           #:sequence-of+)
  (:export #:list-of
           #:list-of*
           #:list-of+)
  (:documentation "This package provides DEFTYPEs useful for
specifying types of lists."))
