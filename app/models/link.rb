module Nerb
  class Link
    include DataMapper::Resource

    property :id, Integer, :serial => true
    property :path, String

    belongs_to :page

    validates_present :page_id
    validates_is_unique :path

    class << self
      def locate(path)
        self.first :path => self.sanitize_path(path)
      end

      def sanitize_path(path)
        path.gsub(/ /, "").gsub(/^\//, "")
      end
    end

    def path=(new_path)
      new_path = Nerb::Link.sanitize_path(new_path)

      attribute_set(:path, new_path)
    end
  end
end