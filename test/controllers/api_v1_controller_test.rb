require 'test_helper'

class ApiV1ControllerTest < ActionDispatch::IntegrationTest
    test 'successful creates dns_server' do
        assert_difference ['DnsServer.count', 'Host.count', 'DnsServerHost.count'] do
            post '/dns_records', { params: request_body}
        end

        assert_response 201
        refute_nil response.parsed_body['id']
    end

    test 'fails to create dns_server with null params' do
        assert_no_difference 'DnsServer.count' do
            post '/dns_records', { params: nil }
        end
        
        assert_response 422
        assert_match 'param is missing or the value is empty', response.body
    end

    test 'multiple calls do not duplicate registries' do
        assert_difference ['DnsServer.count', 'Host.count', 'DnsServerHost.count'] do
            post '/dns_records', { params: request_body}
        end

        assert_no_difference ['DnsServer.count', 'Host.count', 'DnsServerHost.count'] do
            post '/dns_records', { params: request_body}
        end
    end

    private

    def request_body
        {
            "dns_records": { 
                "ip": "1.1.1.1", 
                "hostnames_attributes": [
                    { "hostname": "lorem.com" }
                ]
            }
        }
    end
end


