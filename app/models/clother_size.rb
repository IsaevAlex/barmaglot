class ClotherSize < ApplicationRecord
	has_many :clother_size_elements
	has_many :man_dresses, :through => :clother_size_elements, :source => :clother, :source_type => 'ManDress'
	has_many :woman_dresses, :through => :clother_size_elements, :source => :clother, :source_type => 'WomanDress'
end
