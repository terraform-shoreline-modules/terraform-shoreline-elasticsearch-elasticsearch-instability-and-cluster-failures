bash

#!/bin/bash



# Set the Elasticsearch node count

NODE_COUNT=${NEW_NODE_COUNT}



# Stop the Elasticsearch service

sudo systemctl stop elasticsearch



# Update the Elasticsearch configuration file

sudo sed -i "s/#node\.max\_count\:/node\.max\_count\: $NODE_COUNT/g" /etc/elasticsearch/elasticsearch.yml



# Start the Elasticsearch service

sudo systemctl start elasticsearch



# Verify that the node count has been updated

curl -X GET "localhost:9200/_cat/nodes?v"