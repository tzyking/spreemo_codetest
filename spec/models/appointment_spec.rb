require 'rails_helper'

describe Appointment do
  let(:doctor)      {  create :doctor, specialty: 'Orthopedist' }
  let(:patient)     {  create :patient, ailment: 'broken bones' }
  let(:appointment) {  Appointment.new( doctor: doctor, patient: patient, appointment_date: appointment_date) }
  let(:error)       {  appointment.errors.messages[:appointment_date].first }

  describe 'create appointment with invalid appointment date' do
    let(:appointment_date)  {  2.days.from_now }

    it 'should be invalid with error' do
      expect(appointment).not_to be_valid
      expect(error).to include('is earlier than 3 days in the future')
    end
  end

  describe 'create appointment with occupied appointment date for patient' do
    let(:appointment_date)  {  10.days.from_now  }
    before(:each) do
      Appointment.delete_all
      create :appointment, patient: patient, appointment_date: appointment_date
    end

    it 'should be invalid with error' do
      expect(appointment).not_to be_valid
      expect(error).to include("is unavailable for the patient")
    end
  end

  describe 'create appointment with occupied appointment date for doctor' do
    let(:appointment_date)  {  10.days.from_now  }
    before(:each) do
      Appointment.delete_all
      create :appointment, doctor: doctor, appointment_date: appointment_date
    end

    it 'should be invalid with error' do
      expect(appointment).not_to be_valid
      expect(error).to include("is unavailable for the doctor")
    end
  end
end
