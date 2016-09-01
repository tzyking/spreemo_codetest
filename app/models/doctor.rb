class Doctor < ActiveRecord::Base
  include PersonConcern
  validates :specialty, presence: true, inclusion: { in: ApplicationController.helpers.specialties,
                                                   message: "is not a vaild specialty"}
  has_many :appointments
  has_many :patients, :through => :appointments

  def name
    "Dr. #{super}"
  end
end
