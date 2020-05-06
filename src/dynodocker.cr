require "yaml"
require "ecr"
require "option_parser"

module Dynodocker

  VERSION = "0.2.11"

  init = false
  console = false
  template = "Dockerfile.dyn"
  output = ""

  OptionParser.parse do |parser|
    parser.banner = "Usage: dynodocker [arguments]"
    parser.on("-init", "--init", "Initialize settings and template.") { init = true }
    parser.on("-c", "--console", "Output to console") { console = true }
    parser.on("-o OUTPUT", "--to=OUTPUT", "Specifies file to write output to.") { |output| }
   #parser.on("-t TEMPLATE", "--to=TEMPLATE", "Specifies the template to process.") { |template| }
    parser.on("-h", "--help", "dynodocker #{VERSION} help") { puts parser }
  end

  ## TODO check for existing settings.yml if not recommend running
  ## TODO dynodocker init
  if File.exists?("settings.yml") == false
    puts "dynodocker #{VERSION}"
    puts "No settings.yml found"
    puts "Please initialize settings with dynodocker -init"
    exit
  end
  

  ## TODO init creates settings.yml with one setting "source"
  ## TODO init creates Dockerfile.dyn with setting from source defined
  ## TODO init adds :: include notation comment to output
  if init == true
  
    File.write("settings.yml", "source: define_image_here")

    template_skeleton = "FROM <%= settings[\"source\"] %> as upstream\n\n"
    template_skeleton += "# ::include_filename prefix with ::"
    template_skeleton += "\n"

    File.write("Dockerfile.dyn", template_skeleton)

  end

  # load fixed settings
  yml_content = File.read("settings.yml")
  settings = YAML.parse(yml_content)

  ## TODO parameterize template from commandline

  # if template == ""
  #   puts "dynodocker #{VERSION}"
  #   puts "No template defined."
  #   puts "Please set the template via -t template_file"
  #   exit    
  # end


  # render the template
  result = ECR.render("Dockerfile.dyn") 
  #result = ECR.render(:template)
  
  # split results for additional processing
  content = result.to_s.split("\n")
  updated_content = ""
  # iterate content for inspection
  content.each do |f|
    # check for include file prefix
    if (f.includes?("::"))
      # strip prefix and read file contents
      if f == "# ::include_filename prefix with ::"
      else
        f = File.read(f.gsub("::", ""))
      end
    end
    updated_content += (f + "\n")
  end

  ## TODO OUTPUT to stdout
  if console != ""
    puts updated_content
  end
  ## TODO OUTPUT to file
  if output != ""
    File.write(output, updated_content)
  end


end
