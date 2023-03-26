locals {
  inputs = yamldecode(file("inputs.yaml"))
}

module "record" {
  source   = "../../../modules/cloudflare/records"
  for_each = { for k, v in local.inputs : k => { inputs = merge(v, { name = k }) } }

  zone_name = basename(path.cwd)
  inputs    = each.value.inputs
}
