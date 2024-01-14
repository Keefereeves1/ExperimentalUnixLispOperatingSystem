;; Load the foreign library using a relative path
(cffi:load-foreign-library "./lib/libinterdimensional.so")

;; Assuming InterdimensionalPoint is a C struct, define it in Lisp
(cffi:defcstruct interdimensional-point
  (x :double)
  (y :double)
  (z :double)
  (t :double)
  (dimension-name :pointer)) ; Assuming a string, handled as a pointer

;; Define foreign functions
(cffi:defcfun ("initInterdimensionalPoint" init-interdimensional-point) 
:void
  (point :pointer)
  (x :double)
  (y :double)
  (z :double)
  (t :double)
  (name :string))

;; Example function usage in Lisp
(defun create-and-init-point (x y z t name)
  (let ((point (cffi:foreign-alloc 'interdimensional-point)))
    (init-interdimensional-point point x y z t name)
    point))

