;;; sequences.lisp

(in-package #:list-types)

(deftype sequence-of (&optional (type '*)
                                (min-elements '*)
                                (max-elements '*))
  `(and sequence
        (satisfies ,(make-sequence-of-predicate type
                                                min-elements
                                                max-elements))))

(deftype sequence-of* (&optional (type '*))
  `(sequence-of ,type 0 *))

(deftype sequence-of+ (&optional (type '*))
  `(sequence-of ,type 1 *))
