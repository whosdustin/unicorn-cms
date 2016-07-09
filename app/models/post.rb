class Post
  include Mongoid::Document
	include Mongoid::Slug
	include Mongoid::Timestamps

	field :title, type: String
	field :content, type: String
	field :like, type: Integer,:default => 0

	slug :title
end
