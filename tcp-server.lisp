(defun start-server (port)
  (let ((socket (socket:socket :type :stream
                               :protocol :tcp)))
    (socket:socket-bind socket #(127 0 0 1) port)
    (socket:socket-listen socket 5)
    (format t "Server listening on port ~A~%" port)
    (loop
      (let ((client (socket:socket-accept socket)))
        (format t "Client connected: ~A~%" (socket:socket-peer-address 
client))
        (mp:process-run-function "Client" client #'handle-client)
        (socket:socket-close client)))))

(defun handle-client (client)
  (let ((stream (socket:socket-stream client)))
    (format stream "Welcome to the Lisp TCP Server!~%")
    (finish-output stream)
    (loop
      (let ((message (read-line stream nil)))
        (if (null message)
            (return)
            (format t "Received from client: ~A~%" message)
            (format stream "You said: ~A~%" message)
            (finish-output stream))))))

(start-server 12345)

