output "dn" {
  value       = aci_rest.fabricPodPGrp.id
  description = "Distinguished name of `fabricPodPGrp` object."
}

output "name" {
  value       = aci_rest.fabricPodPGrp.content.name
  description = "Pod policy group name."
}
