# Chef recipe to deploy Node.js app on Windows

# Ensure Node.js is installed
package 'nodejs' do
  action :install
end

# Create app directory
directory 'C:/cd_app' do
  recursive true
  action :create
end

# Copy app folder from workspace to deployment directory
remote_directory 'C:/cd_app' do
  source 'app'
  files_backup 0
  action :create
end

# Stop any existing Node.js process and start the app
powershell_script 'Start Node.js app' do
  code <<-EOH
    Stop-Process -Name node -ErrorAction SilentlyContinue
    Start-Process -FilePath "node" -ArgumentList "C:/cd_app/server.js"
  EOH
end