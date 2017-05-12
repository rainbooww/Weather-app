class HomeController < ApplicationController
  def index
    @states = %w(HI AK CA OR WA ID UT NV AZ NM CO WY MT ND SD NB KS OK TX LA AR MO IA MN WI IL IN MI OH KY TN MS AL GA FL SC NC VA WV DE MD PA NY NJ CT RI MA VT NH ME DC).sort!
    response = HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Raleigh.json")
    if params[:city] != nil
      params[:city].gsub!(" ", "_")
    end

    if params[:state] != "" && params[:city] != ""
      if params[:state] != nil && params[:city] != nil
        response =
        HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/#{params[:state]}/#{params[:city]}.json")
      end
    else
        response =
        HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Raleigh.json")
    end

      @location = response['current_observation']['display_location']['full']
      @temp_f = response['current_observation']['temp_f']
      @temp_c = response['current_observation']['temp_c']
      @weather_icon = response['current_observation']['icon_url']
      @weather_words = response['current_observation']['weather']
      @forecast_link= response['current_observation']['forecast_url']
      @feels_like_f = response['current_observation']['feels_like_f']
      @feels_like_c = response['current_observation']['feels_like_c']
  end

  def test
    #store api in a variable
    response =
    HTTParty.get("http://api.wunderground.com/api/#{ENV['wunderground_api_key']}/geolookup/conditions/q/NC/Raleigh.json")

    @location = response['current_observation']['display_location']['full']
    @temp_f = response['current_observation']['temp_f']
    @temp_c = response['current_observation']['temp_c']
    @weather_icon = response['current_observation']['icon_url']
    @weather_words = response['current_observation']['weather']
    @forecast_link= response['current_observation']['forecast_url']
    @feels_like_f = response['current_observation']['feels_like_f']
    @feels_like_c = response['current_observation']['feels_like_c']
  end

end
