(defun start-client (server-host server-port)
  (let ((socket (socket:socket :type :stream
                               :protocol :tcp)))
    (socket:socket-connect socket server-host server-port)
    (let ((stream (socket:socket-stream socket)))
      (loop
        (format t "Enter a message (or type 'exit' to quit): ")
        (force-output)
        (let ((message (read-line)))
          (format stream "~A~%" message)
          (finish-output stream)
          (when (string= message "exit")
            (format t "Exiting client.~%")
            (return))))))))

(start-client "127.0.0.1" 12345)


