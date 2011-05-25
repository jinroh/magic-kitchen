class List < Array
  cattr_accessor :delimiter
  self.delimiter = ','
  
  def initialize(*args)
    add(*args)
  end
  
  def self.from(string)
    glue = delimiter.ends_with?(" ") ? delimiter : "#{delimiter} "
    string = string.join(glue) if string.respond_to?(:join)

    new.tap do |list|
      string = string.to_s.dup

      string.gsub!(/(\A|#{delimiter})\s*"(.*?)"\s*(#{delimiter}\s*|\z)/) { list << $2; $3 }
      string.gsub!(/(\A|#{delimiter})\s*'(.*?)'\s*(#{delimiter}\s*|\z)/) { list << $2; $3 }

      list.add(string.split(delimiter))
      list.send(:clean!)
    end.uniq
  end
  
  def add(*names)
    extract_and_apply_options!(names)
    concat(names)
    clean!
    self
  end
  
  def remove(*names)
    extract_and_apply_options!(names)
    delete_if { |name| names.include?(name) }
    self
  end
  
  def to_s
    list.map do |name|
      name.include?(delimiter) ? "\"#{name}\"" : name
    end.join(delimiter.ends_with?(" ") ? delimiter : "#{delimiter} ")
  end
  
  protected
  
  def clean!
    reject!(&:blank?)
    map!(&:strip)
    uniq!
  end
  
  def extract_and_apply_options!(args)
    options = args.last.is_a?(Hash) ? args.pop : {}
    options.assert_valid_keys :parse
    
    if options[:parse]
      args.map! { |a| self.class.from(a) }
    end

    args.flatten!
  end
end