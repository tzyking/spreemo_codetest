module DoctorsHelper
  def specialties
    specialty_options.keys.freeze
  end

  def specialty_options
    {
      'Orthopedist' => 'Orthopedist',
      'Opthamologist' => 'Opthamologist',
      'Cardiologist' => 'Cardiologist'
    }
  end
end
