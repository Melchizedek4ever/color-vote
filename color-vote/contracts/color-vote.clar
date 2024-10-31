
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
(define-constant ERR_BAD_REQUEST (err u400))
(define-constant ERR_FORBIDDEN (err u403))

(define-constant COLORS (list "F97316" "D1C0A8" "2563EB" "65A30D"))
(define-constant MAX_SCORE u5)


;; data vars
;;
(define-data-var nb-of-voters uint u0)

(define-data-var scores (list 4 uint) (list u0 u0 u0 u0))
;; data maps
;;
(define-map votes principal bool)

(map-insert votes tx-sender true)
;; public functions
;;
(define-public (vote (orange uint) (beige uint) (sky uint) (lime uint))
  (let ((values (list orange beige sky lime)))
    (asserts! (is-none (map-get? votes tx-sender)) ERR_FORBIDDEN)
    (asserts! (fold is-valid values true) ERR_BAD_REQUEST)

    (var-set scores (map + (var-get scores) values))
    (var-set nb-of-voters (+ (var-get nb-of-voters) u1))
    (ok (map-insert votes tx-sender true))
  )
)
;; read only functions
;;
(define-read-only (get-nb-of-voters) (var-get nb-of-voters))
;; private functions
;;
(define-private (is-valid (v uint) (valid bool)) (and valid (<= v MAX_SCORE)))

