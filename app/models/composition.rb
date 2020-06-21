class Composition < ApplicationRecord
    belongs_to       :echogram
    has_one          :species
end
