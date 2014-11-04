module CoRE
  module CoAP
    module Registry
      REGISTRY_PATH = File.join(File.dirname(__FILE__), 'registry').freeze

      def self.load_yaml(registry)
        registry = "#{registry}.yml"
        YAML.load_file(File.join(REGISTRY_PATH, registry))
      end

      CONTENT_FORMATS = load_yaml(:content_formats).freeze
      CONTENT_FORMATS_INVERTED = CONTENT_FORMATS.invert.freeze

      def self.convert_content_format(cf)
        if cf.is_a? String
          CONTENT_FORMATS_INVERTED[cf] || without_charset(cf)
        else
          CONTENT_FORMATS[cf]
        end
      end

      private

      def self.without_charset(cf)
        cf = cf.split(';').first
        CONTENT_FORMATS_INVERTED.select { |k| k =~ /^#{cf}/ }.first[1]
      rescue NoMethodError
        nil
      end
    end
  end
end
