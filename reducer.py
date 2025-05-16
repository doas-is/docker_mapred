#!/usr/bin/env python3
import sys

current_store = None
total_sales = 0.0
total_count = 0

for line in sys.stdin:
    line = line.strip()
    if not line:
        continue
    # Split into exactly 3 fields
    parts = line.split('\t')
    if len(parts) != 3:
        continue  # Skip invalid lines
    store, count_str, amount_str = parts
    try:
        count = int(count_str)
        amount = float(amount_str)
    except ValueError:
        continue  # Skip invalid values

    if current_store == store:
        total_count += count
        total_sales += amount
    else:
        if current_store:
            print(f"{current_store}\t{total_count}\t{total_sales:.2f}")
        current_store = store
        total_count = count
        total_sales = amount

# Output the last store
if current_store:
    print(f"{current_store}\t{total_count}\t{total_sales:.2f}")