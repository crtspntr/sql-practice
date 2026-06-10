# 02 - Database Design

Understand how databases are structured and why design decisions matter. This section explores normalization, relationships, and constraints using the Sakila database as a reference.

## 📋 Topics Covered

### 1. **normalization-examples.sql**
- First Normal Form (1NF) - Atomic values, no repeating groups
- Second Normal Form (2NF) - Partial dependency removal
- Third Normal Form (3NF) - Transitive dependency removal
- Boyce-Codd Normal Form (BCNF) - Stricter requirements
- Denormalization trade-offs

**Sakila Examples**:
- One-to-many relationships (Store → Inventory)
- Many-to-many junction tables (film_actor, film_category)
- Proper use of foreign keys

### 2. **constraints-and-relationships.sql**
- PRIMARY KEY - Unique row identification
- FOREIGN KEY - Referential integrity
- UNIQUE constraints
- CHECK constraints
- DEFAULT values
- NOT NULL constraints

**Sakila Examples**:
- How customer.store_id references store.store_id
- How rental.inventory_id ensures data consistency
- Cascading updates and deletes

### 3. **sample-schemas/**
Reference schema definitions and ER diagrams
- Sakila schema breakdown
- Table relationships and cardinality
- Index strategies

## 🎯 Key Concepts

### Database Normalization
Normalization reduces redundancy and improves data integrity by organizing tables according to mathematical principles.

**Benefits**:
- Eliminates data anomalies
- Reduces storage space
- Improves query performance
- Maintains referential integrity

### Relationships in Sakila

**One-to-Many**: Store → Inventory (1 store has many inventory items)

**Many-to-Many**: Film ↔ Actor (Many films have many actors)
- Implemented via junction table `film_actor`

**One-to-One**: Address → Customer (rare in Sakila, but conceptually simple)

### Foreign Keys
Ensure that references between tables are valid:
```sql
ALTER TABLE rental
ADD CONSTRAINT fk_rental_inventory
FOREIGN KEY (inventory_id) REFERENCES inventory(inventory_id);
```

## 📊 Sakila Schema Highlights

| Table | Primary Purpose | Key Relationships |
|-------|-----------------|-------------------|
| film | Movie catalog | References: language, category |
| actor | Actor directory | References: film (via film_actor) |
| customer | Rental customers | References: address, store |
| rental | Rental transactions | References: inventory, customer, staff |
| payment | Payment records | References: rental, customer, staff |
| inventory | Film copies per store | References: film, store |
| store | Store locations | References: address, staff |

## 💡 Design Principles

1. **Organize by entity** - Separate concerns into different tables
2. **Use proper data types** - INT for IDs, VARCHAR for names, DATE for dates
3. **Enforce constraints** - Use NOT NULL, UNIQUE, FOREIGN KEY
4. **Plan for scalability** - Consider how tables will grow
5. **Document relationships** - Clear connection between tables

## ✅ Completion Checklist

- [ ] Understand normalization levels (1NF → 3NF)
- [ ] Recognize Sakila's normalized structure
- [ ] Identify one-to-many and many-to-many relationships
- [ ] Write queries that respect foreign key relationships
- [ ] Understand trade-offs between normalization and denormalization

---

**Status**: In Progress  
**Last Updated**: June 10, 2026
