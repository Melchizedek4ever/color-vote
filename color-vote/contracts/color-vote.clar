
;; title: color-vote
;; version:
;; summary:
;; description:

;; traits
;;

;; token definitions
;; 

;; constants
;;

;; data vars
;;
(define-data-var nb-of-voters uint u0)
;; data maps
;;
(define-map votes principal boolean)

(map-insert votes tx-sender true)
;; public functions
;;
(define-public (vote)
  (begin
    
    (ok (var-set nb-of-voters (+ (var-get nb-of-voters) u1)))
  )
)
;; read only functions
;;
(define-read-only (get-nb-of-voters) (var-get nb-of-voters))
;; private functions
;;
(define-private (ok-or-err2 (check bool))
  (begin
    (asserts! check (err u1))
    
    (ok true)
  )
)
