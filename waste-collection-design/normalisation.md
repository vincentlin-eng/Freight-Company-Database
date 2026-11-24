# Normalisation: collection report (UNF → 3NF)

The starting point is a waste collection report. Each report covers one collection run for one waste type under one contract on one date, and lists every bin collected on that run.

Primary key attributes are listed first in each relation.

## UNF

COLLECTION_RUN (contract_num, waste_type_id, waste_type_description, collection_frequency, collection_date, truck_vin, truck_rego, truck_make, truck_model, truck_year, (bin_rfid, bin_collected_kgs, bin_overweight))

The bin details repeat for every bin on the run.

## 1NF

Move the repeating bin group into its own relation.

- COLLECTION_RUN (**contract_num, waste_type_id, collection_date**, waste_type_description, collection_frequency, truck_vin, truck_rego, truck_make, truck_model, truck_year)
- COLLECTION_BIN (**bin_rfid, contract_num, waste_type_id, collection_date**, bin_collected_kgs, bin_overweight)

**Partial dependencies** (depend on only part of the key):

- waste_type_id → waste_type_description
- contract_num, waste_type_id → collection_frequency

## 2NF

- COLLECTION_RUN (**contract_num, waste_type_id, collection_date**, truck_vin, truck_rego, truck_make, truck_model, truck_year)
- COLLECTION_BIN (**bin_rfid, contract_num, waste_type_id, collection_date**, bin_collected_kgs, bin_overweight)
- CONTRACT_WASTE (**contract_num, waste_type_id**, collection_frequency)
- WASTE_TYPE (**waste_type_id**, waste_type_description)

**Transitive dependency** (a non-key attribute depends on another non-key attribute):

- truck_vin → truck_rego, truck_make, truck_model, truck_year

## 3NF

- COLLECTION_RUN (**contract_num, waste_type_id, collection_date**, truck_vin)
- TRUCK (**truck_vin**, truck_rego, truck_make, truck_model, truck_year)
- COLLECTION_BIN (**bin_rfid, contract_num, waste_type_id, collection_date**, bin_collected_kgs, bin_overweight)
- CONTRACT_WASTE (**contract_num, waste_type_id**, collection_frequency)
- WASTE_TYPE (**waste_type_id**, waste_type_description)

**Full dependencies:**

- contract_num, waste_type_id, collection_date → truck_vin
- truck_vin → truck_rego, truck_make, truck_model, truck_year
- bin_rfid, contract_num, waste_type_id, collection_date → bin_collected_kgs, bin_overweight
- contract_num, waste_type_id → collection_frequency
- waste_type_id → waste_type_description

## Attribute synthesis

No two 3NF relations have the same primary key, so none need to be combined. These five relations were then merged into the logical model (`logical_model.png`).
