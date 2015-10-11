;;;; list-types.asd

(asdf:defsystem #:list-types
  :description "LIST-TYPES is various DEFTYPEs useful for dealing with lists."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151010"
  :license "UNLICENSE"
  :depends-on (#:alexandria)
  :in-order-to ((asdf:test-op (asdf:load-op :list-types-tests)))
  :perform (asdf:test-op (o c)
             (uiop:symbol-call :list-types-tests :run-all-tests))
  :components
  ((:static-file "README.md")
   (:module "src"
    :components ((:file "package")
                 (:file "predicate-maker" :depends-on ("package"))
                 (:file "sequences" :depends-on ("package"
                                                 "predicate-maker"))
                 (:file "lists" :depends-on ("package"
                                             "predicate-maker"
                                             "sequences"))))))

(asdf:defsystem #:list-types-tests
  :description "Tests for the LIST-TYPES package."
  :author "Patrick Stein <pat@nklein.com>"
  :version "0.1.20151009"
  :license "UNLICENSE"
  :depends-on (#:list-types #:nst)
  :components
  ((:module "test"
    :components ((:file "package")
                 (:file "criterion" :depends-on ("package"))
                 (:file "sequences" :depends-on ("package"
                                                 "criterion"))
                 (:file "lists" :depends-on ("package"
                                             "criterion"))
                 (:file "run" :depends-on ("package"
                                           "lists"
                                           "sequences"))))))
