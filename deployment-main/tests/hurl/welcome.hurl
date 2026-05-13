# ----- 3. Welcome message -----------------------------------
GET {{base_url}}/
HTTP 200
[Asserts]
jsonpath "$.message" exists
jsonpath "$.time" exists
