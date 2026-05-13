# ----- 1. Liveness probe ------------------------------------
GET {{base_url}}/livez
HTTP 200
[Asserts]
jsonpath "$.status" == "alive"
