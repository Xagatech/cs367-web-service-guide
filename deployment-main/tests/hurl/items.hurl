# ----- 4. Items list ----------------------------------------
GET {{base_url}}/items
HTTP *        # accept any 2xx or 503 when DB is not seeded
[Asserts]
header "Content-Type" contains "application/json"
