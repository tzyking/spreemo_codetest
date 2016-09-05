FactoryGirl.define do
  factory :appointment do
    doctor
    patient
    appointment_date { Time.at((100.days.from_now.to_f - 3.days.from_now.to_f)*rand + 3.days.from_now.to_f) }
  end
end
