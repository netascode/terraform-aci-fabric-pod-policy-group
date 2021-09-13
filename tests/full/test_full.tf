terraform {
  required_providers {
    test = {
      source = "terraform.io/builtin/test"
    }

    aci = {
      source  = "netascode/aci"
      version = ">=0.2.0"
    }
  }
}

module "main" {
  source = "../.."

  name             = "POD1"
  snmp_policy      = "SNMP1"
  date_time_policy = "DATE1"
}

data "aci_rest" "fabricPodPGrp" {
  dn = "uni/fabric/funcprof/podpgrp-${module.main.name}"

  depends_on = [module.main]
}

resource "test_assertions" "fabricPodPGrp" {
  component = "fabricPodPGrp"

  equal "name" {
    description = "name"
    got         = data.aci_rest.fabricPodPGrp.content.name
    want        = module.main.name
  }
}

data "aci_rest" "fabricRsSnmpPol" {
  dn = "${data.aci_rest.fabricPodPGrp.id}/rssnmpPol"

  depends_on = [module.main]
}

resource "test_assertions" "fabricRsSnmpPol" {
  component = "fabricRsSnmpPol"

  equal "tnSnmpPolName" {
    description = "tnSnmpPolName"
    got         = data.aci_rest.fabricRsSnmpPol.content.tnSnmpPolName
    want        = "SNMP1"
  }
}

data "aci_rest" "fabricRsTimePol" {
  dn = "${data.aci_rest.fabricPodPGrp.id}/rsTimePol"

  depends_on = [module.main]
}

resource "test_assertions" "fabricRsTimePol" {
  component = "fabricRsTimePol"

  equal "tnDatetimePolName" {
    description = "tnDatetimePolName"
    got         = data.aci_rest.fabricRsTimePol.content.tnDatetimePolName
    want        = "DATE1"
  }
}
