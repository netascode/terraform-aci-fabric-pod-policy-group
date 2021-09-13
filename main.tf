resource "aci_rest" "fabricPodPGrp" {
  dn         = "uni/fabric/funcprof/podpgrp-${var.name}"
  class_name = "fabricPodPGrp"
  content = {
    name = var.name
  }
}

resource "aci_rest" "fabricRsSnmpPol" {
  dn         = "${aci_rest.fabricPodPGrp.id}/rssnmpPol"
  class_name = "fabricRsSnmpPol"
  content = {
    tnSnmpPolName = var.snmp_policy
  }
}

resource "aci_rest" "fabricRsTimePol" {
  dn         = "${aci_rest.fabricPodPGrp.id}/rsTimePol"
  class_name = "fabricRsTimePol"
  content = {
    tnDatetimePolName = var.date_time_policy
  }
}
