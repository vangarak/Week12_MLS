#!/bin/sh
# Container startup: optionally seed the DB with test data, then run the server.
#
# Seeding uses `npm run populate`, which WIPES all collections and reinserts the
# seed data. It runs on every container start unless you set SEED_DB=false.
# Set SEED_DB=false in your env file once you have data you want to keep.

if [ "${SEED_DB:-true}" = "true" ]; then
  echo "SEED_DB=true -> seeding database with test data (this wipes existing data)..."
  npm run populate || echo "WARNING: database seeding failed; starting server anyway."
else
  echo "SEED_DB=${SEED_DB} -> skipping database seed."
fi

# exec so node becomes PID 1 and receives signals (graceful shutdown)
exec node main.js
