(in-package :TOR)

(defun open-tor-socket (relay)
 "Opens a connection to the specified relay in the Tor network."
 (let ((socket (socket:socket:socket stdio)))
    (socket:connect socket (format nil "127.0.0.1:~A" (parse-integer 
relay)) :service "00000")
    socket))

(defun set-tor-proxy (socket host port)
 "Sets the Tor proxy for the given socket to the specified relay."
 (let ((relay (format nil "~2A" (1+ (random 100)))))
    (let ((request (make-instance 'tor-request :command "PROXY" :arg1 
socket :arg2 host :arg3 port :arg4 relay)))
        (send-tor-message socket request)
        (flush-output socket))
    relay))

(defun main ()
 "Main entry point for the Tor routing script."
 (let ((socket (open-tor-socket 
"ObscHuRn6t6LGHxF1JNd6nWVGD6y66t6LGHxF1JNd6nWVGD6y66t6")))
    (set-tor-proxy socket "localhost" 9001)
    (loop (accept-tor-message socket)
          (process-tor-message socket))
    (socket:close socket))

(main)
