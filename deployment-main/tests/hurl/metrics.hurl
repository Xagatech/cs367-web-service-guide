# ----- 5. Metrics endpoint ----------------------------------
GET {{base_url}}/metrics
HTTP 200
[Asserts]
body contains "http_requests_total"
