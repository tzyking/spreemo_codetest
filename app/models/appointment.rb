class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  class AppointmentDateValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      if value.past?
        record.errors[attribute] <<
          (options[:message] || "is not a valid appointment date")
      end
    end
  end

  validates :appointment_date, presence: true, appointment_date: true
end
