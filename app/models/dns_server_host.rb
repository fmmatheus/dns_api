class DnsServerHost < ApplicationRecord
    self.table_name = "dns_servers_hosts"

    validates_uniqueness_of :host_id, scope: :dns_server_id
end
