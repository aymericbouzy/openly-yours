json.array!(@users_letters) do |users_letter|
  json.extract! users_letter, :id
  json.url users_letter_url(users_letter, format: :json)
end
