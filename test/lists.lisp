;;; lists.lisp

(in-package #:list-types-tests)


(nst:def-test-group list-of-tests ()
  (nst:def-test list-of-anything (typep (list-of))
    '(:a :b :c 1 2 3))

  (nst:def-test list-of-symbols (typep (list-of symbol))
    '(:a :b :c))

  (nst:def-test list-of-three-symbols (typep (list-of symbol 3))
    '(:a :b :c))

  (nst:def-test list-of-too-many-symbols (:not (typep (list-of symbol 3)))
    '(:a :b :c :extra))

  (nst:def-test list-of-not-all-symbols (:not (typep (list-of symbol)))
    '(:a :b :c 1 2 3))

  (nst:def-test list-of-at-least-two-symbols (typep (list-of symbol
                                                             (integer 2 *)))
    '(:a :b :c))

  (nst:def-test not-list-of-at-least-two-symbols
      (:not (typep (list-of symbol (integer 2 *))))
    '(:a))

  (nst:def-test list-of-lists (typep (list-of (list-of symbol)))
    '((:a :b :c) (:x :y :z))))


(nst:def-test-group list-of*-tests ()
  (nst:def-test more-than-one (typep (list-of* symbol))
    '(:a :b :c))

  (nst:def-test none (typep (list-of* symbol))
    nil))

(nst:def-test-group list-of+-tests ()
  (nst:def-test more-than-one (typep (list-of+ symbol))
    '(:a :b :c))

  (nst:def-test none (:not (typep (list-of+ symbol)))
    nil))
