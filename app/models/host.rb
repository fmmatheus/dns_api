class Host < ApplicationRecord
    has_and_belogs_to_many :dns_server
end
