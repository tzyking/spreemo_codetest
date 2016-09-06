class Appointment < ActiveRecord::Base
  belongs_to :doctor
  belongs_to :patient

  class AppointmentDateValidator < ActiveModel::EachValidator
    def validate_each(record, attribute, value)
      # Check if appointment date is earlier than 3 days in the future.
      if value < 3.days.from_now
        record.errors[attribute] <<
          (options[:message] || "is earlier than 3 days in the future")
      end

      # Check if appointment date is already booked for patient.
      if Appointment.exists?(patient_id: record.patient_id, appointment_date: record.appointment_date)
        record.errors[attribute] <<
          (options[:message] || "is occupied on patient's calendar")
      end

      # Check if appointment date is already booked for doctor.
      if Appointment.exists?(doctor_id: record.doctor_id, appointment_date: record.appointment_date)
        record.errors[attribute] <<
          (options[:message] || "is unavailable for the doctor")
      end
    end
  end

  validates :appointment_date, presence: true, appointment_date: true

  def formatted_appointment_date
    if appointment_date
      appointment_date.strftime("%m/%d/%Y %I:%M%p")
    end
  end
end
