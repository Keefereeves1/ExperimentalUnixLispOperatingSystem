;;; chat.lisp

;;;; Utility Functions

(defun send-message (socket message)
  "Send a message over the socket."
  (format socket "~A~%" message)
  (force-output socket))

(defun receive-message (socket)
  "Receive a message from the socket."
  (read-line socket))

;;;; Server-Side Code

(defvar *server-port* 12345)
(defvar *clients* (make-hash-table))

(defun start-chat-server ()
  "Start the chat server."
  (format t "Starting chat server on port ~A~%" *server-port)
  (let ((server-socket (socket-listen "localhost" *server-port)))
    (loop
      (format t "Waiting for connections...~%")
      (let ((client-socket (socket-accept server-socket)))
        (format t "Accepted connection from ~A~%" (socket-peer 
client-socket))
        (let ((client-thread (sb-thread:make-thread
                              (lambda ()
                                (handle-client-connection client-socket)
                                (socket-close client-socket))))))
        (setf (gethash client-thread *clients*) client-socket)))))

(defun handle-client-connection (client-socket)
  "Handle communication with a connected client."
  (let ((client-address (socket-peer client-socket)))
    (format t "Client ~A connected.~%" client-address)
    (loop
      (handler-case
          (let ((message (receive-message client-socket)))
            (if (string= message ":quit")
                (progn
                  (format t "Client ~A disconnected.~%" client-address)
                  (return)))
            (format t "Received from ~A: ~A~%" client-address message)
            (broadcast-message message client-socket)))
        (error (condition)
          (format t "Error from client ~A: ~A~%" client-address 
condition)
          (return))))))

(defun broadcast-message (message sender)
  "Broadcast a message to all connected clients except the sender."
  (format t "Broadcasting message: ~A~%" message)
  (maphash
   (lambda (thread socket)
     (unless (eq socket sender)
       (sb-thread:with-mutex (*standard-output-lock*)
         (send-message socket message))))
   *clients*))

;;;; Client-Side Code

(defun start-chat-client ()
  "Start a chat client."
  (format t "Enter the server address: ")
  (let* ((server-host (read-line *query-io*))
         (client-socket (socket-connect server-host *server-port*)))
    (format t "Connected to ~A~%" server-host)
    (sb-thread:make-thread #'handle-user-input :arguments (list 
client-socket))
    (loop
      (let ((message (receive-message client-socket)))
        (format t "Received: ~A~%" message))))))

(defun handle-user-input (client-socket)
  "Handle user input and send messages to the server."
  (loop
    (format t "> ")
    (let ((input (read-line *query-io*)))
      (send-message client-socket input))))

;;;; Main Entry Point

(defun main ()
  "Main entry point for the chat application."
  (format t "Welcome to Lisp Chat!~%")
  (format t "1. Start server~%2. Connect to server~%3. Quit~%")
  (format t "Enter your choice: ")
  (let ((choice (read)))
    (case choice
      (1 (start-chat-server))
      (2 (start-chat-client))
      (3 (format t "Goodbye!~%")
         (socket-close (socket-connect "localhost" *server-port*))
         (sb-ext:quit))
      (otherwise (format t "Invalid choice.~%")))))

;;; Entry Point

(main)

