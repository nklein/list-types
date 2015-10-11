;;; lists.lisp

(in-package #:list-types)

(deftype list-of (&optional (type '*) (length '*))
  `(and proper-list
        (sequence-of ,type ,length)))

(deftype list-of* (&optional (type '*))
  `(list-of ,type (integer 0 *)))

(deftype list-of+ (&optional (type '*))
  `(list-of ,type (integer 1 *)))
