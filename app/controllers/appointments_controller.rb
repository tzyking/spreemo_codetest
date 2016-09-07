class AppointmentsController < ApplicationController
  def show
    @appointment = Appointment.find(params[:id])
  end

  def new
    @appointment = Appointment.new
    @appointment.patient = Patient.find(new_appointment_params[:patient_id])

    set_doctor_options(@appointment.patient.ailment)
  end

  def create
    @appointment = Appointment.new
    @appointment.patient_id = create_appointment_params[:patient_id]
    @appointment.doctor_id = create_appointment_params[:doctor_id]
    @appointment.appointment_date = appointment_date_time

    respond_to do |format|
      if @appointment.save
        AppointmentMailer.appointment_scheduled_notification(@appointment).deliver_now
        format.html { render :show, notice: 'appointment was successfully created.' }
      else
        set_doctor_options(@appointment.patient.ailment)
        format.html { render :new }
      end
    end
  end

  def set_doctor_options(patient_ailment)
    @doctor_options = Hash.new
    specialty = ailment_specialty_pairs[patient_ailment]
    Doctor.where(specialty: specialty).map { |doctor| @doctor_options[doctor.name] = doctor.id }
  end

  def new_appointment_params
    params.permit(:patient_id)
  end

  def create_appointment_params
    params.require(:appointment).permit(:patient_id, :doctor_id, :appointment_date);
  end

  def appointment_date_time
    year = create_appointment_params['appointment_date(1i)'].to_i
    month = create_appointment_params['appointment_date(2i)'].to_i
    mday = create_appointment_params['appointment_date(3i)'].to_i
    hour = create_appointment_params['appointment_date(4i)'].to_i
    minute = create_appointment_params['appointment_date(5i)'].to_i
    DateTime.new(year, month, mday, hour, minute)
  end

  private
    def ailment_specialty_pairs
      {
        'broken bones' => 'Orthopedist',
        'eye trouble' => 'Opthamologist',
        'heart disease' => 'Cardiologist'
      }
    end
end
