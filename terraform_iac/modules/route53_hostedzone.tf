resource "aws_route53_zone" "profileapp" {
  name    = "profile.devopsfetish.xyz"  # Replace with your desired domain name
  comment = "Public hosted zone for devopsfetish.xyz"

  tags = {
    Environment = "dev"
    Project     = "profileapp"
  }
}

# Output the name servers assigned to the hosted zone
output "name_servers" {
  value = aws_route53_zone.profileapp.name_servers
}