class DnsServerHost < ApplicationRecord
    self.table_name = "dns_servers_hosts"

    belongs_to :dns_server
    belongs_to :host

    validates_uniqueness_of :host_id, scope: :dns_server_id

    def self.filter_by_hosts(hosts)
        self
        .where(host_id: hosts)
        .map { |dns| dns.dns_server_id }
        .tally
        .select { |k, v| v == hosts.size }
        .map { |k, v| k }
    end
end
