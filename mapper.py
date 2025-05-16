#!/usr/bin/env python3
import sys

for line in sys.stdin:
    fields = line.strip().split('\t')
    if len(fields) != 6:
        continue  # Skip malformed lines
    store = fields[2]
    try:
        amount = float(fields[4])
    except ValueError:
        continue  # Skip invalid amounts
    # Emit: store, count (1), amount
    print(f"{store}\t1\t{amount}")