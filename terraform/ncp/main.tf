resource "ncloud_vpc" "ncloud-vpc1" {
  name            = "ncloud-vpc1"
  ipv4_cidr_block = "10.0.0.0/16"
}

# Public Subnet
resource "ncloud_subnet" "subnet_public" {
  name           = "ncloud-vpc1-public"
  vpc_no         = ncloud_vpc.ncloud-vpc1.vpc_no
  subnet         = cidrsubnet(ncloud_vpc.ncloud-vpc1.ipv4_cidr_block, 8, 0) // "10.0.0.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.network_acl_public.id
  subnet_type    = "PUBLIC" // PUBLIC(Public)
}

# Private Subnet
resource "ncloud_subnet" "subnet_private" {
  name           = "ncloud-vpc1-private"
  vpc_no         = ncloud_vpc.ncloud-vpc1.vpc_no
  subnet         = cidrsubnet(ncloud_vpc.ncloud-vpc1.ipv4_cidr_block, 8, 1) // "10.0.1.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.network_acl_private.id
  subnet_type    = "PRIVATE" // PRIVATE(Private)
}

# NAT Gateway Subnet
resource "ncloud_subnet" "subnet_NAT" {
  name           = "ncloud-vpc1-nat"
  vpc_no         = ncloud_vpc.ncloud-vpc1.vpc_no
  subnet         = cidrsubnet(ncloud_vpc.ncloud-vpc1.ipv4_cidr_block, 8, 2) // "10.0.2.0/24"
  zone           = "KR-2"
  network_acl_no = ncloud_network_acl.network_acl_public.id
  subnet_type    = "PUBLIC"
  usage_type     = "NATGW"
}

# Public IP
resource "ncloud_public_ip" "public_ip_01" {
  server_instance_no = ncloud_server.frontend-server.id
  description        = "for frontend server"
}

resource "ncloud_public_ip" "public_ip_02" {
  server_instance_no = ncloud_server.jenkins-server.id
  description        = "for Jenkins server"
}

# Network ACL
resource "ncloud_network_acl" "network_acl_public" {
  vpc_no = ncloud_vpc.ncloud-vpc1.id
  name   = "ncloud-vpc1-public-acl"
}

resource "ncloud_network_acl" "network_acl_private" {
  vpc_no = ncloud_vpc.ncloud-vpc1.id
  name   = "ncloud-vpc1-private-acl"
}

# Server
# for Front-end (bastion) server
resource "ncloud_server" "frontend-server" {
  subnet_no                 = ncloud_subnet.subnet_public.id
  name                      = "frontend-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  server_product_code       = "SVR.VSVR.STAND.C002.M008.NET.SSD.B050.G002"
}
# for Back-end (WAS) server
resource "ncloud_server" "backend-server" {
  subnet_no                 = ncloud_subnet.subnet_private.id
  name                      = "backend-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  server_product_code       = "SVR.VSVR.STAND.C002.M008.NET.SSD.B050.G002"
}
# for Jenkins server
resource "ncloud_server" "jenkins-server" {
  subnet_no                 = ncloud_subnet.subnet_public.id
  name                      = "jenkins-server"
  server_image_product_code = "SW.VSVR.OS.LNX64.CNTOS.0703.B050"
  # server_image_product_code = "SW.VSVR.OS.LNX64.UBNTU.SVR2004.B050"
  server_product_code = "SVR.VSVR.STAND.C002.M008.NET.SSD.B050.G002"
}

# NAT Gateway
resource "ncloud_nat_gateway" "nat-gateway-01" {
  vpc_no    = ncloud_vpc.ncloud-vpc1.id
  subnet_no = ncloud_subnet.subnet_NAT.id
  zone      = "KR-2"
  name      = "nat-gateway-01"
}

# Route
resource "ncloud_route" "nat_route_table" {
  route_table_no         = ncloud_vpc.ncloud-vpc1.default_private_route_table_no
  destination_cidr_block = "0.0.0.0/0"
  target_type            = "NATGW" // NATGW (NAT Gateway) | VPCPEERING (VPC Peering) | VGW (Virtual Private Gateway).
  target_name            = ncloud_nat_gateway.nat-gateway-01.name
  target_no              = ncloud_nat_gateway.nat-gateway-01.id
}
