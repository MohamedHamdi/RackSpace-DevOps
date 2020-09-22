resource "aws_route53_zone" "zone-1" {
  name = "approach1.net"
}


resource "aws_route53_record" "approach1-record-1" {
  zone_id = aws_route53_zone.zone-1.zone_id
  name    = "live.approach1.net"
  type    = "A"
  set_identifier = "live"

  weighted_routing_policy {
    weight = 200
  }

  alias {
    name                   = aws_elb.elb.dns_name
    zone_id                = aws_elb.elb.zone_id
    evaluate_target_health = true
  }
}

resource "aws_route53_record" "approach1-record-2" {
  zone_id = aws_route53_zone.zone-1.zone_id
  name    = "approach1.net"
  allow_overwrite = true
  ttl             = 60
  type            = "NS"

  records = [
    aws_route53_zone.zone-1.name_servers[0],
    aws_route53_zone.zone-1.name_servers[1],
    aws_route53_zone.zone-1.name_servers[2],
    aws_route53_zone.zone-1.name_servers[3],
  ]
}


resource "aws_route53_record" "approach1-record-3" {
  zone_id         = aws_route53_zone.zone-1.zone_id
  name            = "approach1.net"
  type            = "SOA"
  ttl             = 60
  allow_overwrite = true
  
  records = [
    format("%s. awsdns-hostmaster.amazon.com. 1 7200 900 1209600 86400", aws_route53_zone.zone-1.name_servers[0])
  ]
}