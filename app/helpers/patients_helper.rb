module PatientsHelper
  def ailments
    ailment_options.keys.freeze
  end

  def ailment_options
    {
      'broken bones' => 'broken bones',
      'eye trouble' => 'eye trouble',
      'heart disease' => 'heart disease'
    }
  end
end
