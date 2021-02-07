# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)

# Create Hosts
host_1 = Host.create(id: 1, name: 'lorem.com')
host_2 = Host.create(id: 2, name: 'ipsum.com')
host_3 = Host.create(id: 3, name: 'dolor.com')
host_4 = Host.create(id: 4, name: 'amet.com')
host_5 = Host.create(id: 5, name: 'sit.com')

# Create DNS_Servers
DnsServer.create(id: 1, ip_address: '1.1.1.1', hosts: [host_1, host_2, host_3, host_4])
DnsServer.create(id: 2, ip_address: '2.2.2.2', hosts: [host_2])
DnsServer.create(id: 3, ip_address: '3.3.3.3', hosts: [host_2, host_3, host_4])
DnsServer.create(id: 4, ip_address: '4.4.4.4', hosts: [host_2, host_3, host_4, host_5])
DnsServer.create(id: 5, ip_address: '5.5.5.5', hosts: [host_3, host_5])
