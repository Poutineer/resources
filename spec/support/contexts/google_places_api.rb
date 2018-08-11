RSpec.shared_context("Google Places API") do
  let(:google_places_client) do
    instance_double(GooglePlaces::Client)
  end

  let(:a_google_place) do
    instance_double(GooglePlaces::Spot, a_google_place_attributes)
  end

  let(:a_google_place_attributes) do
    {
      :name => "Test",
      :place_id => "1234567890",
      :types => ["restaurant", "food", "point_of_interest", "establishment"],
      :formatted_phone_number => "(416) 599-2873",
      :formatted_address => "218 Adelaide St W, Toronto, ON M5H 1W7, Canada",
      :rating => 5.0,
      :website => "http://smokespoutinerie.com/",
      :opening_hours => {
        "periods" => [
          {"open" => {"day" => 0, "time" => "1100"}, "close" => {"day" => 1, "time" => "0000"}},
          {"open" => {"day" => 1, "time" => "1100"}, "close" => {"day" => 2, "time" => "0000"}},
          {"open" => {"day" => 2, "time" => "1100"}, "close" => {"day" => 3, "time" => "0000"}},
          {"open" => {"day" => 3, "time" => "1100"}, "close" => {"day" => 4, "time" => "0300"}},
          {"open" => {"day" => 4, "time" => "1100"}, "close" => {"day" => 5, "time" => "0300"}},
          {"open" => {"day" => 5, "time" => "1100"}, "close" => {"day" => 6, "time" => "0400"}},
          {"open" => {"day" => 6, "time" => "1100"}, "close" => {"day" => 0, "time" => "0400"}}
        ]
      },
      :photos => 3.times.map do
        instance_double(GooglePlaces::Photo, :fetch_url => "https://lh3.googleusercontent.com/p/AF1QipP2zr_6z7J6FxzJpCvmWXrPxp3-0DViRTehY-su=s1600-w512")
      end
    }
  end

  before(:each) do
    stub_const("GOOGLE_PLACES_CLIENT", google_places_client)
    allow(google_places_client).to(receive(:spot).with(a_kind_of(String))).and_return(a_google_place)
  end
end
