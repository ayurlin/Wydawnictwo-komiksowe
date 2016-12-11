class Hash
  def add_method_access
    self.stringify_keys!
    class << self

      def respond_to?(name, include_private = false)
        if has_key?(name.to_s)
          true
        elsif name.to_s =~ /=$/
          true
        else
          super
        end
      end

      def method_missing(name, *args)
        if has_key?(name.to_s)
          self[name.to_s]
        elsif args.size == 1 && name.to_s =~ /(.*)=$/
          return self[Regexp.last_match[1].to_s] = args.first
        else
          super
        end
      end

      def [](key)
        if key.is_a?(Symbol)
          super(key.to_s)
        else
          super
        end
      end

      def []=(key, value)
        __redefine_method(key.to_s) if __method?(key.to_s) && !__already_overridden?(key)

        if key.is_a?(Symbol)
          super(key.to_s, value)
        else
          super(key, value)
        end
      end
    end

    def __already_overridden?(name)
      __method?("__#{name}")
    end

    def __method?(name)
      methods.map(&:to_s).include?(name)
    end

    def __redefine_method(method_name)
      eigenclass = class << self; self; end
      eigenclass.__send__(:alias_method, "__#{method_name}", method_name)
      eigenclass.__send__(:define_method, method_name, -> { self[method_name] })
    end

    self.each do |key, value|
      __redefine_method(key.to_s) if __method?(key.to_s)
    end

    return self
  end
end

