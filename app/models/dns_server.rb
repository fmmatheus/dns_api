class DnsServer < ApplicationRecord
    has_and_belogs_to_many :hosts
end
