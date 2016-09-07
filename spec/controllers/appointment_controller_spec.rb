require 'rails_helper'

describe AppointmentsController do
  let(:doctor)  { create :doctor, first_name: 'Brandy', last_name: 'Schroeder', specialty: 'Orthopedist' }
  let(:patient) { create :patient, ailment: 'broken bones' }

  let(:valid_attributes) {
    {
      patient_id: patient.id,
      doctor_id: doctor.id,
      "appointment_date(1i)"=> "2016",
      "appointment_date(2i)"=>"9",
      "appointment_date(3i)"=>"11",
      "appointment_date(4i)"=>"09",
      "appointment_date(5i)"=>"00"
    }
  }

  let(:invalid_attributes) {
    {
      patient_id: patient.id,
      doctor_id: doctor.id,
      "appointment_date(1i)"=> "2016",
      "appointment_date(2i)"=>"8",
      "appointment_date(3i)"=>"11",
      "appointment_date(4i)"=>"09",
      "appointment_date(5i)"=>"00"
    }
  }
  let(:valid_session)  { {} }

  before(:each) do
    create :doctor, first_name: 'Jim', last_name: 'Cool', specialty: 'Orthopedist'
    create :doctor, first_name: 'Tom', last_name: 'Ford', specialty: 'Orthopedist'
  end

  describe 'GET #new' do
    it 'assigns requested patient to @appointment' do
      appointment = Appointment.new
      appointment.patient = patient
      get :new, { :patient_id => patient.id }, valid_session
      expect(assigns(:appointment) == appointment)
    end

    it 'assigns doctors to @doctor_opitons' do
      get :new, { :patient_id => patient.id }, valid_session
      expect(assigns(:doctor_options).keys).to eq(['Dr. Jim Cool', 'Dr. Tom Ford'])
    end
  end

  describe 'POST #create' do
    before(:each) do
      Appointment.delete_all
    end

    context 'with valid params' do
      it 'create a new appointment' do
        expect {
          post :create, {:appointment => valid_attributes}, valid_session
        }.to change(Appointment, :count).by(1)
      end

      it "assigns a newly created appointment as @appointment" do
        post :create, {:appointment => valid_attributes}, valid_session
        expect(assigns(:appointment)).to be_a(Appointment)
        expect(assigns(:appointment)).to be_persisted
      end

      it "re-renders to the 'show' template" do
        post :create, {:appointment => valid_attributes}, valid_session
        expect(response).to render_template("show")
      end
    end

    context 'with invalid appointment_date' do
      it "re-renders to the 'new' template" do
        post :create, {:appointment => invalid_attributes}, valid_session
        expect(response).to render_template("new")
      end

      it "assigns doctors to @doctor_opitons" do
        post :create, {:appointment => invalid_attributes}, valid_session
        expect(assigns(:doctor_options).keys).to eq(['Dr. Jim Cool', 'Dr. Tom Ford', 'Dr. Brandy Schroeder'])
      end
    end
  end
end
