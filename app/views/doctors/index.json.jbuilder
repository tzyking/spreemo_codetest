json.array!(@doctors) do |doctor|
  json.extract! doctor, :id, :email, :first_name, :last_name, :street, :city, :state, :zip, :specialty
  json.url doctor_url(doctor, format: :json)
end
