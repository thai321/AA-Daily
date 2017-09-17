# == Schema Information
#
# Table name: benches
#
#  id          :integer          not null, primary key
#  description :string
#  lat         :float
#  lng         :float
#  created_at  :datetime         not null
#  updated_at  :datetime         not null
#

class Bench < ApplicationRecord
  validates :description, :lat, :lng, presence: true

end
