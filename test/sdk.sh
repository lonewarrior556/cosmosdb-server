#/usr/bin/env bash
set -euo pipefail

readonly port="$((RANDOM + 3000))"
trap 'kill -9 $pid' EXIT
./bin/cosmosdb-server.js -p "$port" &
pid=$!

cd test/azure-cosmos-js
yarn
yarn build
ACCOUNT_HOST="https://localhost:$port" yarn test
