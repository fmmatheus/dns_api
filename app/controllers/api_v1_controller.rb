class ApiV1Controller < ApplicationController
    after_action { pagy_headers_merge(@pagy) if @pagy }

    def show
        dns_servers_hosts = DnsServerHost.all
        dns_servers_hosts_included = filter(dns_servers_hosts, :included)
        dns_servers_hosts_excluded = filter(dns_servers_hosts, :excluded)

        dns_servers = DnsServer.where(id: dns_servers_hosts_included[:dns_servers] - dns_servers_hosts_excluded[:dns_servers])

        @pagy, @dns_servers = pagy(dns_servers, items: 10, page: page_params["page"])

        json_response show_response(@dns_servers, dns_servers_hosts_included[:hosts]), 200
    end

    def create
        @dns_server = DnsServer.find_or_create_by!(ip_address: create_dns_record_params["ip"])
        
        create_dns_record_params["hostnames_attributes"].each do |hostname|
            host = Host.find_or_create_by!(name: hostname["hostname"])
            
            DnsServerHost.find_or_create_by!(
                host_id: host.id, 
                dns_server_id: @dns_server.id
            )
        end

        json_response create_response(@dns_server), 201
    end

    private

    def create_dns_record_params
        params.require(:dns_records).permit(:ip, hostnames_attributes: [:hostname])
    end

    def page_params
        params.require(:page)
    end

    def filter_params
        params.permit(:included, :excluded)
    end

    def map_dns_servers(dns_servers, included_hosts)
        dns_servers
        .map { |record| map_hosts(dns_servers, record, included_hosts) }
        .flatten
        .compact
        .select { |record| record[:count] != 0 }
        .uniq
    end

    def map_hosts(dns_servers, dns, included_hosts)
        dns.hosts.map { |host| host_response(dns_servers, host) unless included_hosts.include?(host.id) && filter_params[:included] }
    end

    def count_hostname(dns_servers, host_id)
        dns_servers.joins(:hosts).where('hosts.id = ?', host_id).count
    end

    def filter(dns_servers_hosts, type)
        if filter_params[type]
            hosts = Host.where(name: JSON.parse(params[type])).pluck(:id)
            dns_servers = dns_servers_hosts.filter_by_hosts(hosts)
            
            { hosts: hosts, dns_servers: dns_servers }
        else
            { 
                hosts: type == :included ? dns_servers_hosts.map { |dns| dns.host_id }.uniq : [], 
                dns_servers: type == :included ? dns_servers_hosts.map { |dns| dns.dns_server_id }.uniq : [] 
            }
        end
    end

    def create_response(dns_server)
        { 
            id: dns_server.id 
        }
    end

    def show_response(dns_servers, included_hosts)
        { 
            total_records: dns_servers.count,
            records: dns_servers.map { |record| dns_response(record)},
            related_hostnames: map_dns_servers(dns_servers, included_hosts)
        }
    end

    def dns_response(record)
        { 
            id: record.id, 
            ip_address: record.ip_address 
        }
    end

    def host_response(dns_servers, host)
        { 
            hostname: host.name, 
            count: count_hostname(dns_servers, host.id) 
        }
    end
end