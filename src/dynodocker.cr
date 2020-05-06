require "yaml"
require "ecr"

module Dynodocker
  VERSION = "0.2.1"

  # load fixed settings
  yml_content = File.read("settings.yml")
  settings = YAML.parse(yml_content)

  # render the template
  result = ECR.render("Dockerfile.erb") 
  
  # split results for additional processing
  content = result.to_s.split("\n")

  # iterate content for inspection
  content.each do |f|
    # check for include file prefix
    if (f.includes?("::"))
      # strip prefix and read file contents
      f = File.read(f.gsub("::", ""))
    end
    puts f
  end

end
