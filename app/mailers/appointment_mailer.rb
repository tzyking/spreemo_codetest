class AppointmentMailer < ActionMailer::Base

  default from: $DEFAULT_SENDER

  def appointment_scheduled_notification(appointment)
    recipients = [appointment.doctor.email, appointment.patient.email]
    doctor_name = appointment.doctor.name
    doctor_address = appointment.doctor.address
    patient_name = appointment.patient.name
    formatted_appointment_date = appointment.formatted_appointment_date

    @email_content = "Doctor: #{doctor_name}. Patient: #{patient_name}. Time: #{formatted_appointment_date}. Address: #{doctor_address}."

    mail(
        :to => recipients,
        :subject => "Appointment Scheduled: #{doctor_name} and #{patient_name}"
      )
  end
end
