# resource "local_file" "iis" {
#     content = <<-CONTENT
#       Install-WindowsFeature -name Web-Server -IncludeManagementTools
#       Remove-Item -Path 'C:\inetpub\wwwroot\iisstart.htm'
#       Add-Content -Path 'C:\inetpub\wwwroot\iisstart.htm' -Value "$env:computername"
#     CONTENT
#     filename = var.iis_script_filename
# }