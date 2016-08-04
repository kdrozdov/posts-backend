FactoryGirl.define do
  factory :post do
    title { Faker::Lorem.words(2).join(' ') }
    body { Faker::Lorem.words(5).join(' ') }
    image do
      Rack::Test::UploadedFile.new(
        Rails.root.join('spec', 'fixtures', '1.gif')
      )
    end
    user
  end
end
