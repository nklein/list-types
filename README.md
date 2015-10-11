LIST-TYPES
==========

I often find myself wanting to declare a type as a list of integers or
a list of symbols or some such thing.  My natural inclination is to do
this:

    (deftype list-of (&optional (type '*))
      `(or null
           (cons ,type (list-of ,type))))

However, the Common Lisp spec requires that all type declaration
expansions terminate.  As such, one has to hop through various hoops
to use a `SATISFIES` clause in a `DEFTYPE` to do that.  This package
wraps that technique and defines the types:

    (sequence-of &optional (type '*) (length-type '*))
    (sequence-of* &optional (type '*))
    (sequence-of+ &optional (type '*))

    (list-of &optional (type '*) (length-type '*))
    (list-of* &optional (type '*))
    (list-of+ &optional (type '*))

Additionally, this package also exports the `ALEXANDRIA` types for
`PROPER-LIST` and `CIRCULAR-LIST`.

The `LENGTH-TYPE` can be either a non-negative integer or a
specification of an integer type.  With the type-names which end with
asterisk (`*`), the `LENGTH-TYPE` is taken to be `(INTEGER 0 *)`.
With the type-names which end with plus (`+`), the `LENGTH-TYPE` is
taken to be `(INTEGER 1 *)`.

There is no attempt to ensure that a specified `LENGTH-TYPE` is valid.

Note: there is currently no support for `CIRCULAR-LIST-OF`.

Unfortunately
-------------

Unfortunately, this is not sufficient unless your code gets recompiled
every time.  If you have a block of code like this:

    (defun foo (bar)
      (check-type bar (list-of+ integer))
      ...)

This will work when you compile and load it.  It will not work when
you just load it because at compile time, the expansion of `list-of+`
created a predicate that will not be there if you just load the
compiled `check-type` into a clean image.

The ugly workaround for this is to use one of the macros before the check-type:

    (ensure-sequence-type &optional (type '*) (length-type '*))
    (ensure-sequence-type* &optional (type '*))
    (ensure-sequence-type+ &optional (type '*))

So, your code will look like one of the following:

    (ensure-sequence-type+ integer)
    (defun foo (bar)
      (check-type bar (list-of+ integer))
      ...)

    ;;; or...

    (defun foo (bar)
      (ensure-sequence-type+ integer)
      (check-type bar (list-of+ integer))
      ...)
