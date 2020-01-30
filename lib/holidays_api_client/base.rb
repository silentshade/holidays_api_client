module HolidaysApiClient
  module Base
    def self.included(klass)
      klass.extend ClassMethods
    end

    module ClassMethods
      def call(**args)
        inst = args.empty? ? new : new(**args)
        inst.send(:call)
      end
    end
  end
end
