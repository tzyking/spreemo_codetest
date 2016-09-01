class Patient < ActiveRecord::Base
  include PersonConcern
  validates :ailment, presence: true, inclusion: { in: ApplicationController.helpers.ailments,
                                                   message: "is not a vaild ailment"}
  has_many :appointments
  has_many :doctors, :through => :appointments
end
