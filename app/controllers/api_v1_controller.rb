class ApiV1Controller < ApplicationController
    def create
        @dns_server = DnsServer.find_or_create_by!(ip_address: request_params["ip"])
        
        request_params["hostnames_attributes"].each do |hostname|
            host = Host.find_or_create_by!(name: hostname["hostname"])
            
            DnsServerHost.find_or_create_by!(
                host_id: host.id, 
                dns_server_id: @dns_server.id
            )
        end

        json_response create_response(@dns_server), 201
    end

    private

    def request_params
        params.require(:dns_records).permit(:ip, hostnames_attributes: [:hostname])
    end

    def create_response(dns_server)
        { id: dns_server.id }
    end
end