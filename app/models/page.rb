module Nerb
  class Page
    include DataMapper::Resource

    property :id, Integer, :serial => true
    property :title, String
    property :body, Text
    property :created_at, DateTime
  
    validates_present :title
  
    has n, :links
  end
end