# == Schema Information
#
# Table name: cat_rental_requests
#
#  id         :integer          not null, primary key
#  cat_id     :integer          not null
#  start_date :date             not null
#  end_date   :date             not null
#  status     :string           default("PENDING")
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class CatRentalRequest < ApplicationRecord
  validates :cat_id, :start_date, :end_date, presence: true
  validates :status, inclusion: ['PENDING', 'APPROVED', 'DENIED']
  validate :does_not_overlap_approved_request

  belongs_to :cat

  def overlapping_requests
    CatRentalRequest
      .select('*')
      .where('(? BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date) OR
              (? BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date) OR
              (cat_rental_requests.start_date >= ? AND cat_rental_requests.end_date <= ?)',
              self.start_date, self.end_date, self.start_date, self.end_date)
      .where.not(id: self.id)
  end

  def overlapping_approved_requests
    self.overlapping_requests.select { |request| request.status == 'APPROVED' }
  end

  def does_not_overlap_approved_request
    byebug
    self.overlapping_approved_requests.none? { |request| CatRentalRequest.exists?(request) }
  end
end


# c2 = CatRentalRequest.new(cat_id: 2, start_date: Date.new(2017,8,8), end_date: Date.new(2017,8,15))
