resource "shoreline_notebook" "elasticsearch_instability_and_cluster_failures" {
  name       = "elasticsearch_instability_and_cluster_failures"
  data       = file("${path.module}/data/elasticsearch_instability_and_cluster_failures.json")
  depends_on = [shoreline_action.invoke_update_elasticsearch_node_count]
}

resource "shoreline_file" "update_elasticsearch_node_count" {
  name             = "update_elasticsearch_node_count"
  input_file       = "${path.module}/data/update_elasticsearch_node_count.sh"
  md5              = filemd5("${path.module}/data/update_elasticsearch_node_count.sh")
  description      = "Consider adjusting the cluster configuration to improve performance and stability, such as changing the number of nodes, shards, or replicas, or adjusting the allocation of resources."
  destination_path = "/tmp/update_elasticsearch_node_count.sh"
  resource_query   = "host"
  enabled          = true
}

resource "shoreline_action" "invoke_update_elasticsearch_node_count" {
  name        = "invoke_update_elasticsearch_node_count"
  description = "Consider adjusting the cluster configuration to improve performance and stability, such as changing the number of nodes, shards, or replicas, or adjusting the allocation of resources."
  command     = "`chmod +x /tmp/update_elasticsearch_node_count.sh && /tmp/update_elasticsearch_node_count.sh`"
  params      = ["NEW_NODE_COUNT"]
  file_deps   = ["update_elasticsearch_node_count"]
  enabled     = true
  depends_on  = [shoreline_file.update_elasticsearch_node_count]
}

