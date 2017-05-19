class ClotherSizeElement < ApplicationRecord
	belongs_to :clother_size
    belongs_to :clother, :polymorphic => true
end
