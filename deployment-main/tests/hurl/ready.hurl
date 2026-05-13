# ----- 2. Readiness probe -----------------------------------
GET {{base_url}}/readyz
HTTP 200
[Asserts]
jsonpath "$.status" == "ready"
