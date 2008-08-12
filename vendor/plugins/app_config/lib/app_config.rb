require 'erb'
require 'yaml'

class AppConfig
  
  def initialize(file = nil)
    @sections = {}
    @params = {}
    use_file!(file) if file
  end
  
  def use_file!(file)
    begin
      hash = YAML::load(ERB.new(IO.read(file)).result)       
      @sections.merge!(hash) {|key, old_val, new_val| (old_val || new_val).merge new_val }
      @params.merge!(@sections['common'])
    rescue; end    
  end
  
  def use_section!(section)
    @params.merge!(@sections[section.to_s]) if @sections.key?(section.to_s)
  end
  
  def method_missing(param)
    param = param.to_s
    if @params.key?(param)
      @params[param]
    else
      raise "Invalid AppConfig Parameter " + param
    end
  end
  
end