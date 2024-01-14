(defpackage :process
  (:use :cl)
  (:export :add-process :remove-process :list-processes 
:make-process))

(in-package :process)

(defclass process ()
  ((name :initarg :name :reader name)
   (state :initarg :state :accessor state)
   (priority :initarg :priority :accessor priority)
   (resources :initarg :resources :accessor resources)
   (output :initarg :output :accessor output)
   (error-output :initarg :error-output :accessor error-output)
   (status :initarg :status :accessor status)
   (id :initarg :id :accessor id)))

(defun get-process-id ()
  ;; Implement the logic to get the current process ID
  )

(defvar *initial-state* ;; Define the initial state for a 
process
  )

(defun make-process (name priority resources)
  (let* ((pid (get-process-id))
         (new-pid (1+ pid))
         (new-process (make-instance 'process :name name :state 
*initial-state*
                                     :priority priority 
:resources resources :id new-pid)))
  ;; Add additional logic as needed
  new-process)
(defpackage 
:process
  (:use :cl)
  (:export :add-process :remove-process :list-processes))
(in-package 
#:process)
(defclass process ()
 ((name :initarg :name :reader name)
   (state :initarg :state :accessor state)
   (priority :initarg :priority :accessor priority)
   (resources :initarg :resources :accessor resources)
   (output :initarg :output :accessor output)
   (error-output :initarg :error-output :accessor error-output)
   (status :initarg :status :accessor status)
   (id :initarg :id :accessor id)))
(defun make-process (name priority resources)
 (let* ((pid (get-process-id))
         (new-pid (1+ pid))
         (new-process (make-instance 'process :name name :state INITIAL 
:priority priority :resources resources :id new-pid)))
    (set-process-id new-pid)
    new-process)
 )
(defvar *process-list* nil)

(defun add-process (process)
 (setf *process-list* (cons process *process-list*))
 (format t "~a added to process list." (name process))
 (setf (status process) 'RUNNABLE)
 (run-process process)
 (values))

(defun remove-process (process)
 (setf *process-list* (remove process *process-list*))
 (format t "~a removed from process list." (name process))
 (setf (status process) 'TERMINATED)
 (format t "~a status: ~a" (name process) (status process))
 (values))

(defun list-processes ()
 (format t "~%Processes:" *process-list*)
 (dolist (process *process-list*)
    (format t "~a: ~s ~s" (name process) (status process) (id process)))
 (values))
(defun get-process-id ()
 (let ((pid (getenv "PID")))
    (if pid
        (parse-int pid)
        (error "No PID found")))
 )

(defun run-process (process)
 (setf (status process) 'RUNNING)
 (call-next-method)
 (values))

(defun terminate-process (process)
 (setf (status process) 'TERMINATING)
 (call-next-method)
 (values))
(defun spawn-process (name priority resources &key (output "process.out"))
 (let ((new-process (make-process name priority resources)))
    (add-process new-process)
    (format t "~a spawned with ID ~d~%." (name new-process) (id 
new-process))
    (values)))
(in-package #:process)
(defclass process-daemon ()
 ((name :initarg :name :reader name)
   (pid :initarg :pid :accessor pid)
   (process-list :initarg :process-list :accessor process-list)
   (output-file :initarg :output-file :accessor output-file)
   (started-p :initarg :started-p :accessor started-p)
   (stop-requested-p :initarg :stop-requested-p :accessor 
stop-requested-p)
   (daemon-alive-p :initarg :daemon-alive-p :accessor daemon-alive-p)
   (error-handler :initarg :error-handler :accessor error-handler)
   (error-log-stream :initarg :error-log-stream :accessor 
error-log-stream)
   (start-error-handler :initarg :start-error-handler :accessor 
start-error-handler)
   (stop-error-handler :initarg :stop-error-handler :accessor 
stop-error-handler))
 (start-daemon)
 (stop-daemon)
 (start-processes)
 (stop-processes)
 (run-daemon)
 (terminate-daemon))
