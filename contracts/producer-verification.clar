;; Producer Verification Contract
;; Validates and manages energy generators in the grid

(define-data-var admin principal tx-sender)

;; Producer status: 0 = pending, 1 = verified, 2 = suspended
(define-map producers
  { producer-id: principal }
  {
    name: (string-utf8 100),
    location: (string-utf8 100),
    capacity: uint,
    status: uint,
    registration-time: uint
  }
)

;; Check if caller is admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin))
)

;; Register a new producer (anyone can register)
(define-public (register-producer (name (string-utf8 100)) (location (string-utf8 100)) (capacity uint))
  (let ((producer-exists (map-get? producers { producer-id: tx-sender })))
    (asserts! (is-none producer-exists) (err u1)) ;; Error if already registered
    (ok (map-set producers
      { producer-id: tx-sender }
      {
        name: name,
        location: location,
        capacity: capacity,
        status: u0, ;; Default to pending
        registration-time: block-height
      }
    ))
  )
)

;; Verify a producer (admin only)
(define-public (verify-producer (producer-id principal))
  (begin
    (asserts! (is-admin) (err u403)) ;; Only admin can verify
    (match (map-get? producers { producer-id: producer-id })
      producer-data (ok (map-set producers
                          { producer-id: producer-id }
                          (merge producer-data { status: u1 })))
      (err u404) ;; Producer not found
    )
  )
)

;; Suspend a producer (admin only)
(define-public (suspend-producer (producer-id principal))
  (begin
    (asserts! (is-admin) (err u403)) ;; Only admin can suspend
    (match (map-get? producers { producer-id: producer-id })
      producer-data (ok (map-set producers
                          { producer-id: producer-id }
                          (merge producer-data { status: u2 })))
      (err u404) ;; Producer not found
    )
  )
)

;; Get producer information (public read)
(define-read-only (get-producer (producer-id principal))
  (map-get? producers { producer-id: producer-id })
)

;; Check if producer is verified
(define-read-only (is-verified-producer (producer-id principal))
  (match (map-get? producers { producer-id: producer-id })
    producer-data (is-eq (get status producer-data) u1)
    false
  )
)

;; Transfer admin rights (admin only)
(define-public (transfer-admin (new-admin principal))
  (begin
    (asserts! (is-admin) (err u403))
    (ok (var-set admin new-admin))
  )
)
