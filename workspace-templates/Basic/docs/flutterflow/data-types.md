# FlutterFlow Data Definitions

This document defines the Enums and Data Types (Structs) used within the FlutterFlow application to handle complex JSON data from Supabase and internal state management.

---

## 📋 Enums

### productBarcodeType
Used in `ProductBarcodeItem.barcodeType`.
- `UNIT`: Individual item scan.
- `BOX`: Bulk/Case scan.

### inventoryActionType
Maps directly to the `inventory_action_type` database enum.
- `STOCK_IN`: Adding stock to inventory.
- `STOCK_OUT`: Removing stock (Sales/Usage).
- `WASTAGE`: Damaged or expired products.
- `MANUAL`: Manual adjustments/corrections.
- `REVERSAL`: Undo of a previous scan.

### scanerModeType
Used to control the UI state of the scanner.
- `STOCK_IN`: Scanner set to receive goods.
- `STOCK_OUT`: Scanner set to ship goods.
- `WASTAGE`: Scanner set to log waste.
- `INIT`: Default/initial state.

### mixStatus
Defines the current readiness state of a mix based on its ingredients.
- `EMPTY`: No ingredients added to the mix recipe.
- `BLOCKED`: At least one ingredient has zero packs possible.
- `LOW_STOCK`: At least one ingredient is below its minimum threshold.
- `READY`: All ingredients have sufficient stock.

### mixIngredientStatus
Defines the stock readiness state for a specific ingredient inside a mix recipe.
- `INSUFFICIENT`: Stock is lower than required for even 1 pack.
- `LOW_STOCK`: Stock is above 1 pack but below the minimum threshold.
- `OK`: Sufficient stock available.

### userRole
Defines user permissions within the app.
- `ADMIN`: Full access to settings and logs.
- `USER`: Standard warehouse operation access.

### tagEntityType
Used to categorize tags for different entities.
- `MIX`: Tags applicable to mix groups.
- `PRODUCT`: Tags applicable to raw products.
- `OTHER`: General purpose tags.

---

## 🏗️ Data Types (Structs)

### 1. LogMetadata
Used as the structure for the `inventory_logs.metadata` JSONB column. This struct captures the context of any inventory change.

| Field | Type | Description |
|-------|------|-------------|
| `reason` | String | Short reason/category (e.g., "Physical Audit", "Wrong Scan") |
| `notes` | String | Detailed user comment or technical error log |
| `user_name` | String | Full name of the user performing the action |
| `product_name` | String | Name of the product (for visual audit) |
| `previous_weight` | Double | The `products.total_weight` value before the change |
| `new_weight` | Double | The `products.total_weight` value after the change |
| `correction_type` | String | Category for manual logs: `adjustment`, `error`, `audit` |
| `source_page` | String | The name of the FlutterFlow page where the log was triggered |

**JSON Example:**
```json
{
  "reason": "Physical Audit",
  "notes": "Found extra bag behind the shelf",
  "user_name": "Ivan Chornyi",
  "product_name": "Strawberry Bears",
  "previous_weight": 40.0,
  "new_weight": 45.0,
  "correction_type": "audit",
  "source_page": "ManualCorrectionSheet"
}
```

---

### 2. ProductBarcodeItem
Used for processing the results of a barcode scan. This struct contains both product details and barcode-specific metadata.

| Field | Type | Description |
|-------|------|-------------|
| `exists` | Boolean | True if the barcode is found in the database |
| `errorMessage` | String | Reason for failure (e.g., "Barcode not recognized") |
| `productId` | String | UUID of the associated product |
| `name` | String | Name of the product (e.g., "Red Cherries") |
| `brand` | String | Brand of the product |
| `imageUrl` | Image Path | URL to the product image |
| `totalStockLb` | Double | Current total stock in the warehouse |
| `minWeightThreshold` | Double | Alert threshold for low stock |
| `barcodeId` | String | UUID of the specific barcode entry |
| `barcode` | String | The physical barcode string |
| `barcodeType` | Enum | `productBarcodeType` (values: `UNIT`, `BOX`) |
| `packagingLabel` | String | e.g., "5 LB Bag", "50 LB Case" |
| `weightValue` | Double | Weight represented by one scan of this barcode |
| `createdAt` | DateTime | Timestamp of barcode creation |

**JSON Example:**
```json
{
  "exists": true,
  "errorMessage": "",
  "productId": "8875635a-...",
  "name": "Strawberry Bears",
  "brand": "Bits Candy",
  "imageUrl": "https://...",
  "totalStockLb": 125.5,
  "minWeightThreshold": 20.0,
  "barcodeId": "9982431b-...",
  "barcode": "123456789",
  "barcodeType": "UNIT",
  "packagingLabel": "5 LB Bag",
  "weightValue": 5.0,
  "createdAt": "2026-04-23T10:00:00Z"
}
```

---

### 3. userProfile
Stored in **App State** to persist user session data and role-based permissions locally.

| Field | Type | Description |
|-------|------|-------------|
| `id` | String | UUID of the user (from Supabase) |
| `email` | String | User's email address |
| `full_name` | String | User's display name |
| `role` | Enum | `userRole` (values: `ADMIN`, `USER`) |
| `is_active` | Boolean | Account status |
| `last_synced` | DateTime | Last time profile data was fetched from DB |
| `saved` | Boolean | Local flag to confirm state persistence |

**JSON Example:**
```json
{
  "id": "7782431c-...",
  "email": "ivan@bits.candy",
  "full_name": "Ivan Chornyi",
  "role": "ADMIN",
  "is_active": true,
  "last_synced": "2026-04-23T12:00:00Z",
  "saved": true
}
```

---

### 4. mixIngredient
Used to parse the nested `ingredients` JSON array returned by the `v_mixes_full` view. Represents a single ingredient's status within a specific mix.

| Field | Type | Description |
|-------|------|-------------|
| `product_id` | String | UUID of the raw ingredient |
| `product_name` | String | Name of the ingredient |
| `stock_weight` | Double | Current stock weight in warehouse |
| `required_per_pack` | Double | Weight required for one pack/tub of this mix |
| `weight_possible` | Double | Total pounds of this mix possible using this ingredient's stock |
| `status` | Enum | `mixIngredientStatus` (values: `INSUFFICIENT`, `LOW_STOCK`, `OK`) |
| `sort_priority` | Integer | Sorting key for UI (1 = INSUFFICIENT, 2 = LOW_STOCK, 3 = OK) |

**JSON Example:**
```json
{
  "product_id": "uuid",
  "product_name": "Red Cherries",
  "stock_weight": 2.5,
  "required_per_pack": 1.5,
  "weight_possible": 36.6,
  "status": "LOW_STOCK",
  "sort_priority": 2
}
```

---

### 5. keyValue
A universal Data Type used for various dynamic key-value pairs across the application, such as populating the stock filter chips list.

| Field | Type | Description |
|-------|------|-------------|
| `key` | String | The identifier or label |
| `stringValue` | String | A text value associated with the key |
| `dubleValue` | Double | A numerical value (named `dubleValue` as per original implementation) |
| `boolValue` | Boolean | A boolean flag associated with the key |

**JSON Example:**
```json
{
  "key": "key",
  "stringValue": "value",
  "dubleValue": 22.22,
  "boolValue": true
}
```

---

### 6. restockProductItem
Used for selective PDF export in the Restock tab. This allows the user to toggle which individual products should appear in the final generated report.

| Field | Type | Description |
|-------|------|-------------|
| `name` | String | Name of the product |
| `brand` | String | Brand name |
| `totalWeight` | Double | Current total stock weight (LB) |
| `minThreshold` | Double | Minimum weight threshold for alert (LB) |
| `photoUrl` | String | URL to the product image asset |
| `isSelected` | Boolean | Toggle flag for inclusion in the PDF export |

**JSON Example:**
```json
{
  "name": "Sour Green Apples",
  "brand": "Vidal",
  "totalWeight": 15.0,
  "minThreshold": 10.0,
  "photoUrl": "https://...",
  "isSelected": true
}
```

---

### 7. restockBrandGroup
A wrapper used to group `restockProductItem` objects by their brand. This structure is used in Page State to manage the hierarchical selection UI in the Restock tab.

| Field | Type | Description |
|-------|------|-------------|
| `brandName` | String | Name of the brand category |
| `isSelected` | Boolean | Master toggle for all products in this group |
| `isExpanded` | Boolean | UI state for expanding/collapsing the group list |
| `products` | List<`restockProductItem`> | Collection of products belonging to this brand |

**JSON Example:**
```json
{
  "brandName": "Vidal",
  "isSelected": true,
  "isExpanded": true,
  "products": [
    { "name": "Sour Green Apples", "brand": "Vidal", "totalWeight": 15.0, "minThreshold": 10.0, "photoUrl": "https://...", "isSelected": true },
    { "name": "Peach Hearts", "brand": "Vidal", "totalWeight": 15.0, "minThreshold": 10.0, "photoUrl": "https://...", "isSelected": false }
  ]
}
```

---

### 8. productMixAssociation
Used to parse the nested `mixes` JSON array returned by the `v_products_with_mixes` view. Represents a single mix group associated with an ingredient.

| Field | Type | Description |
|-------|------|-------------|
| `mix_group_id` | String | ID of the mix group (from `mix_groups.id`) |
| `mix_name` | String | Display name of the mix (e.g., "Rainbow Gummy Mix") |
| `sku_code` | String | Unique SKU code of the mix (e.g., "MIX-RGB-01") |
| `image_url` | String | URL of the mix image asset |
| `weight_required` | Double | Weight of raw material needed for 1 unit of mix |

**JSON Example:**
```json
{
  "mix_group_id": "a9a8a7a6-5432-10fe-dcba-0987654321fe",
  "mix_name": "Cherry Cola Mix",
  "sku_code": "MIX-CHCO-02",
  "image_url": "https://ijmhtgzhdlpwyfporxdt.supabase.co/storage/v1/object/public/inventory/mixes/cherry_cola_mix.png",
  "weight_required": 1.75
}
```

---

### 9. MixDeductionItem
Used to manage the state of ingredients and their deduction weights locally in the bottom sheet before submitting them as a batch.

| Field | Type | Description |
|-------|------|-------------|
| `product_id` | String | UUID of the raw ingredient |
| `weight` | Double | Adjusted weight quantity to deduct (defaults to `weight_required`) |

**JSON Example:**
```json
{
  "product_id": "a9a8a7a6-5432-10fe-dcba-0987654321fe",
  "weight": 1.75
}
```

---

## 🛠️ Implementation Note
When adding these to FlutterFlow:
1. Go to **Data Types** tab.
2. Create a new Data Type with the name above.
3. Add fields matching the types and names exactly.
4. For JSONB columns in Supabase, use `DataType -> Map` or `DataType -> JSON` casting where appropriate.

