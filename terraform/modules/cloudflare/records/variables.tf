variable "zone_name" {
  type = string
}

variable "inputs" {
  type = object({
    name    = string
    type    = string
    ttl     = number
    records = optional(list(string), [])
    proxied = optional(bool, false)
    data    = optional(list(map(string)), [])
  })
}
