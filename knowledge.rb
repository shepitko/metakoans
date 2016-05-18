class Module
  def attribute(attr, &block)
  if attr.is_a? Hash
    name = attr.keys.first 
    default = attr[name]
  else
    name = attr
    default =  nil 
  end
  instance_name = :"@#{name}"
  sym = name.to_sym
  define_method(:"#{name}?"){ !!send(sym) }
  define_method(:"#{name}="){ |v| instance_variable_set(instance_name, v) }
  define_method(sym){ 
    if instance_variable_defined?(instance_name)
      instance_variable_get(instance_name)
    else
      block ? instance_eval(&block) : default
    end
   }
  end
end
