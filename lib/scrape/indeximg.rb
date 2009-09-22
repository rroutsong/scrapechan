class Indeximg
  include DataMapper::Resource

  property :id, Serial
  property :img, String
  property :tags, String
  property :created_at, DateTime

end
