current_dir = File.dirname(__FILE__)
log_level                :info
log_location             STDOUT
node_name                "charleslynch"
client_key               "#{current_dir}/charleslynch.pem"
validation_client_name   "charleslynch-validator"
validation_key           "#{current_dir}/charlesly ch-validator.pem"
chef_server_url          "https://api.opscode.com/organizations/charleslynch"
cache_type               'BasicFile'
cache_options( :path => "#{ENV['HOME']}/.chef/checksums" )
cookbook_path            ["#{current_dir}/../chef-repo"]
