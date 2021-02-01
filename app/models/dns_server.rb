class DnsServer < ApplicationRecord
    has_and_belongs_to_many :hosts    

    validates_uniqueness_of :ip_address
    validates_presence_of :ip_address
end
