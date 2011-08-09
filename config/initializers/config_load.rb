unless defined?(APP_CONFIG)
  if File.exist?(file_name = File.expand_path("../config.yml", __FILE__))
    APP_CONFIG = YAML.load_file(file_name)[::Rails.env]
  else
    APP_CONFIG = {}
  end
end