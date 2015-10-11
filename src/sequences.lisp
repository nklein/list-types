;;; sequences.lisp

(in-package #:list-types)

(deftype sequence-of (&optional (type '*) (length '*))
  `(and sequence
        (satisfies ,(make-sequence-of-predicate type length))))

(deftype sequence-of* (&optional (type '*))
  `(sequence-of ,type (integer 0 *)))

(deftype sequence-of+ (&optional (type '*))
  `(sequence-of ,type (integer 1 *)))
