# Common utility stuff.

module Monkeybars::Inflector
  # Change a method name from Java to Ruby style.
  def rubyize
    ruby_name = self.to_s.underscore

    case ruby_name
    when /^get_/
      return ruby_name.gsub(/^get_/, '')
    when /^is_/
      return ruby_name.gsub(/^is_/, '') + '?'
    else
      return ruby_name
    end
  end
end

class Module
  # Make a Java-style method name into an alias of its Ruby-style one.
  # For example, alias_java_method :getSomeProperty would define some_property as an alias of getSomeProperty.
  def alias_java_method(symbol)
    self.send(:alias_method, symbol, symbol.to_s.rubyize.to_sym)
  end
end