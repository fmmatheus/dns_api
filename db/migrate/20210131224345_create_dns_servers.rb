class CreateDnsServers < ActiveRecord::Migration[6.1]
  def change
    create_table :dns_servers do |t|
      t.string :ip_address

      t.timestamps
    end
  end
end
