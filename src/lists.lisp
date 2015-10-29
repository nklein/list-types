;;; lists.lisp

(in-package #:list-types)

(deftype list-of (&optional (type '*)
                            (min-elements '*)
                            (max-elements '*))
  `(and proper-list
        (sequence-of ,type ,min-elements ,max-elements)))

(deftype list-of* (&optional (type '*))
  `(list-of ,type 0 *))

(deftype list-of+ (&optional (type '*))
  `(list-of ,type 1 *))
