require 'rails_helper'

describe AppointmentMailer do
  describe '#appointment_scheduled_notification' do
    let(:doctor)              { create :doctor, specialty: 'Orthopedist' }
    let(:patient)             { create :patient, ailment: 'broken bones' }
    let(:appointment)         { create :appointment, doctor: doctor, patient: patient }
    let(:mail)                { AppointmentMailer.appointment_scheduled_notification(appointment) }
    let(:expected_mail_body)  { "Doctor: #{doctor.name}. Patient: #{patient.name}. Time: #{appointment.formatted_appointment_date}. Address: #{doctor.address}." }

    it 'sends mail to doctor and patient' do
      expect(mail.to).to eq([doctor.email, patient.email])
    end

    it 'sends mail with appropriate subject' do
      expect(mail.subject).to eq("Appointment Scheduled: #{doctor.name} and #{patient.name}")
    end

    it 'renders appropriate mail body' do
      expect(mail.body.encoded).to include(expected_mail_body)
    end
  end
end
