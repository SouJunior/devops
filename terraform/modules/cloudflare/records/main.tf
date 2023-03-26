data "cloudflare_zone" "zone" {
  name = var.zone_name
}

resource "cloudflare_record" "record" {
  for_each = { for v in var.inputs.records : format("%s/%s", var.inputs.name, v) => merge(var.inputs, { record = v }) }

  zone_id = data.cloudflare_zone.zone.zone_id
  name    = each.value.name
  value   = each.value.record
  proxied = each.value.proxied
  type    = each.value.type
  ttl     = each.value.ttl

  dynamic "data" {
    for_each = lookup(each.value, "data", {})

    content {
      service  = try(data.value.service, null)
      proto    = try(data.value.proto, null)
      name     = try(data.value.name, null)
      priority = try(data.value.priority, null)
      weight   = try(data.value.weight, null)
      port     = try(data.value.port, null)
      target   = try(data.value.target, null)
    }
  }
}
