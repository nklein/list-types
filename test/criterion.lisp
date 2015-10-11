;;;; criterion.lisp

(in-package #:list-types-tests)

(nst:def-criterion (typep (type) (item))
  (if (typep item type)
      (nst:make-success-report)
      (nst:make-failure-report :format "~S was not of expected type ~S"
                               :args (list item type))))
