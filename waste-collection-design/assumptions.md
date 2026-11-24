# Design assumptions and decisions

## Business assumptions

- A property may have no owner.
- Each authority is responsible for at least one street.
- Each authority signs at least one contract.
- A waste type in a contract may have no matching contract bin.
- A waste type may not appear in any contract.
- Not every bin type is included in a contract.
- Each collection report is one collection run for one waste type under one contract on one date, so `contract_num`, `waste_type_id` and `collection_date` together identify a collection.
- `collection_frequency` depends on the contract and the waste type, based on the report format.

## Surrogate keys

In the logical model I replaced some composite keys with single-column surrogate keys. In each case a UNIQUE constraint keeps the original business rule.

| Surrogate key | Replaces | Why |
|---|---|---|
| `bin_type_id` | `waste_type_id` + `bin_size` | Simpler queries, and avoids carrying a two-column foreign key into other tables |
| `contract_waste_id` | `contract_num` + `waste_type_id` | CONTRACT_BIN and COLLECTION_RUN can reference "this waste type under this contract" with one foreign key |
| `collection_run_id` | `contract_waste_id` + `collection_date` | COLLECTION_BIN references a run with one foreign key instead of three columns |
