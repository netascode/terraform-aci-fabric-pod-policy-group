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

  name = "POD1"
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
