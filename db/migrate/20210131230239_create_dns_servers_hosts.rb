class CreateDnsServersHosts < ActiveRecord::Migration[6.1]
  def change
    create_table :dns_servers_hosts, id: false do |t|
      t.belongs_to :dns_server
      t.belongs_to :host

      t.timestamps
    end
  end
end
