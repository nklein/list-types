;;; sequences.lisp

(in-package #:list-types-tests)


(nst:def-test-group sequence-of-tests ()
  (nst:def-test vector-of-anything (typep (sequence-of))
    #(:a :b :c 1 2 3))

  (nst:def-test vector-of-symbols (typep (sequence-of symbol))
    #(:a :b :c))

  (nst:def-test vector-of-three-symbols (typep (sequence-of symbol 3 3))
    #(:a :b :c))

  (nst:def-test vector-of-too-many-symbols (:not (typep (sequence-of symbol 3 3)))
    #(:a :b :c :extra))

  (nst:def-test vector-of-not-all-symbols (:not (typep (sequence-of symbol)))
    #(:a :b :c 1 2 3))

  (nst:def-test list-of-three-symbols (typep (sequence-of symbol 3 3))
    '(:a :b :c))

  (nst:def-test list-of-at-least-two-symbols (typep (sequence-of symbol 2 *))
    '(:a :b :c))

  (nst:def-test not-list-of-at-least-two-symbols
      (:not (typep (sequence-of symbol 2 *)))
    '(:a))

  (nst:def-test sequence-of-sequences
      (typep (sequence-of (sequence-of symbol)))
    '(#(:a :b :c) (:x :y :z))))


(nst:def-test-group sequence-of*-tests ()
  (nst:def-test more-than-one (typep (sequence-of* symbol))
    #(:a :b :c))

  (nst:def-test none (typep (sequence-of* symbol))
    #()))

(nst:def-test-group sequence-of+-tests ()
  (nst:def-test more-than-one (typep (sequence-of+ symbol))
    #(:a :b :c))

  (nst:def-test none (:not (typep (sequence-of+ symbol)))
    #()))
