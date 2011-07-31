if File.exist?(file_name = "#{::Rails.root.to_s}/config/config.yml")
  APP_CONFIG = YAML.load_file(file_name)[::Rails.env]
else
  APP_CONFIG = {}
end