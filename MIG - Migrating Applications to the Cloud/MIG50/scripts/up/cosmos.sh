#!/bin/bash
set -eou pipefail
source ./scripts/variables.sh

echo "Creating CosmosDB $(cosmosname) in resource group $(rg)"

# Create a MongoDB API Cosmos DB account with consistent prefix (Local) consistency and multi-master enabled
az cosmosdb create \
    --resource-group $(rg) \
    --name $(cosmosname) \
    --kind MongoDB \
    --locations "eastus"=0 "westus"=1 \
    --default-consistency-level "ConsistentPrefix" \
    --enable-multiple-write-locations true \
    --enable-automatic-failover true


echo create db
# Create a database 
az cosmosdb database create \
    --resource-group $(rg) \
    --name $(cosmosname) \
    --db-name $(dbname)

echo create collection
# Create a collection with a partition key and 1000 RU/s
az cosmosdb collection create \
    --resource-group $(rg) \
    --collection-name $(collection) \
    --name $(cosmosname) \
    --db-name $(dbname) \
    --throughput 1000
