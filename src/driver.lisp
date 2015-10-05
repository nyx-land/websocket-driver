(in-package :cl-user)
(defpackage websocket-driver
  (:nicknames :wsd)
  (:use :cl)
  (:import-from :websocket-driver.ws.base
                #:ws
                #:socket
                #:additional-headers
                #:accept-protocols
                #:protocol
                #:version
                #:ready-state

                #:start-connection
                #:send
                #:send-text
                #:send-binary
                #:send-ping
                #:close-connection)
  (:import-from #:event-emitter
                #:listeners
                #:listener-count
                #:add-listener
                #:on
                #:once
                #:remove-listener
                #:remove-all-listeners
                #:emit)
  (:export #:websocket-p

           ;; from ws
           #:ws
           #:socket
           #:additional-headers
           #:accept-protocols
           #:protocol
           #:version
           #:ready-state

           #:start-connection
           #:send
           #:send-text
           #:send-binary
           #:send-ping
           #:close-connection

           ;; from event-emitter
           #:listeners
           #:listener-count
           #:add-listener
           #:on
           #:once
           #:remove-listener
           #:remove-all-listeners
           #:emit))
(in-package :websocket-driver)

(defun websocket-p (env)
  (let ((headers (getf env :headers)))
    (and (eq (getf env :request-method) :get)
         (string-equal (gethash "connection" headers "") "upgrade")
         (string-equal (gethash "upgrade" headers "") "websocket")
         (eql (gethash "sec-websocket-version" headers) 13))))
