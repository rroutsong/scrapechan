class Indeximg < CouchRest::ExtendedDocument
  use_database CouchRest.new.database!('imgs')

  property :img
  property :tags

  timestamps!
end
