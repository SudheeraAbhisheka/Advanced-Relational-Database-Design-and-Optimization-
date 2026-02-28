Notes
1. An order also stores its own shipping address, since customers might ship to a new address that isn’t saved in their profile. *Every shipping address must have a forign key cutomer id.

2. Each product has a single inventory record.

3. The Product category table acts as a bridge.

4. A product may appear in one or many product_items across different orders.