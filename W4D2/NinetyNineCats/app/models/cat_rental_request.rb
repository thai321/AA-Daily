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

  private

  def overlapping_requests
    CatRentalRequest
      .where(cat_id: cat_id)
      .where('(? BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date) OR
              (? BETWEEN cat_rental_requests.start_date AND cat_rental_requests.end_date) OR
              (cat_rental_requests.start_date >= ? AND cat_rental_requests.end_date <= ?)',
              self.start_date, self.end_date, self.start_date, self.end_date)
      .where.not(id: self.id)
  end

  def overlapping_approved_requests
    overlapping_requests.where('status = \'APPROVED\'')
  end

  def does_not_overlap_approved_request
    if !overlapping_approved_requests.empty?
      errors[:overlap] << "The request is overlap with an existing approved requested"
    end
  end

end
