;; Consumer Identity Contract
;; Manages energy user profiles

(define-data-var admin principal tx-sender)

;; Consumer data structure
(define-map consumers
  { consumer-id: principal }
  {
    name: (string-utf8 100),
    location: (string-utf8 100),
    max-consumption: uint,
    active: bool,
    registration-time: uint
  }
)

;; Check if caller is admin
(define-private (is-admin)
  (is-eq tx-sender (var-get admin))
)

;; Register a new consumer
(define-public (register-consumer (name (string-utf8 100)) (location (string-utf8 100)) (max-consumption uint))
  (let ((consumer-exists (map-get? consumers { consumer-id: tx-sender })))
    (asserts! (is-none consumer-exists) (err u1)) ;; Error if already registered
    (ok (map-set consumers
      { consumer-id: tx-sender }
      {
        name: name,
        location: location,
        max-consumption: max-consumption,
        active: true,
        registration-time: block-height
      }
    ))
  )
)

;; Update consumer profile (only the consumer can update their own profile)
(define-public (update-consumer (name (string-utf8 100)) (location (string-utf8 100)) (max-consumption uint))
  (match (map-get? consumers { consumer-id: tx-sender })
    consumer-data (ok (map-set consumers
                        { consumer-id: tx-sender }
                        {
                          name: name,
                          location: location,
                          max-consumption: max-consumption,
                          active: (get active consumer-data),
                          registration-time: (get registration-time consumer-data)
                        }))
    (err u404) ;; Consumer not found
  )
)

;; Deactivate consumer (admin or self)
(define-public (deactivate-consumer (consumer-id principal))
  (begin
    (asserts! (or (is-admin) (is-eq tx-sender consumer-id)) (err u403))
    (match (map-get? consumers { consumer-id: consumer-id })
      consumer-data (ok (map-set consumers
                          { consumer-id: consumer-id }
                          (merge consumer-data { active: false })))
      (err u404) ;; Consumer not found
    )
  )
)

;; Reactivate consumer (admin only)
(define-public (reactivate-consumer (consumer-id principal))
  (begin
    (asserts! (is-admin) (err u403))
    (match (map-get? consumers { consumer-id: consumer-id })
      consumer-data (ok (map-set consumers
                          { consumer-id: consumer-id }
                          (merge consumer-data { active: true })))
      (err u404) ;; Consumer not found
    )
  )
)

;; Get consumer information (public read)
(define-read-only (get-consumer (consumer-id principal))
  (map-get? consumers { consumer-id: consumer-id })
)

;; Check if consumer is active
(define-read-only (is-active-consumer (consumer-id principal))
  (match (map-get? consumers { consumer-id: consumer-id })
    consumer-data (get active consumer-data)
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
