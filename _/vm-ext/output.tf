output "vm" {
  value = module.vm
  sensitive = true
}

output "script" {
  value = data.template_file.iis
}