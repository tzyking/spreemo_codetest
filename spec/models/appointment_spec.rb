require 'rails_helper'

describe Appointment do
  let(:doctor)                    {  create :doctor, specialty: 'Orthopedist' }
  let(:patient)                   {  create :patient, ailment: 'broken bones' }
  let(:invaild_appointment_date)  {  2.days.from_now }
  let(:appointment)               {  Appointment.new( doctor: doctor, patient: patient, appointment_date: invaild_appointment_date) }
  let(:error)                     {  appointment.errors.messages[:appointment_date].first }

  it 'should be invalid with invalid appointment date' do
    expect(appointment).not_to be_valid
    expect(error).to include('is earlier than 3 days in the future')
  end
end
