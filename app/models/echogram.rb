class Echogram < ApplicationRecord
    belongs_to   :user
    has_many     :compositions
    has_one      :haul
end
