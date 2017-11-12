output "solr_url" {
  value = "${module.hyrax_solr.solr_endpoint}"
}

output "zookeeper_url" {
  value = "${module.hyrax_zookeeper.zookeeper_endpoint}"
}

output "exhibitor_url" {
  value = "${module.hyrax_zookeeper.zookeeper_exhibitor}"
}
