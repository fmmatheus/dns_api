class Host < ApplicationRecord
    has_and_belongs_to_many :dns_server
    
    validates_uniqueness_of :name
    validates_presence_of :name
end
