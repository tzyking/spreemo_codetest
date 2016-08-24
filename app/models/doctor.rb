class Doctor < ActiveRecord::Base
  include PersonConcern
  validates :specialty, presence: true, inclusion: { in: ApplicationController.helpers.specialties,
                                                   message: "is not a vaild specialty"}
  def name
    "Dr. #{super}"
  end
end
