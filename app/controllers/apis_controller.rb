require 'twilio-ruby'

class ApisController < ApplicationController
#  before_action :set_api, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def report
    # API call: /api/:device_id/:state/:lat/:long/:time/
    alert(params[:device_id], params[:state], params[:lat], params[:lng], params[:time])
    
    #render :nothing => true, :status => 200, :content_type => 'text/html'
    render text: 'ok'
    return
  end

  def go
    #
    # Test coordinates
    # Mars building: 43.6598912, -79.3886251
    # 43.658010 -79.377507
    # 
    lat = '43.6598912'
    lng = '-79.3886251'

    lat_str = ( (lat.to_f + 90.to_f) * 1000000.to_f ).to_i
    lng_str = ( (lng.to_f + 180.to_f) * 1000000.to_f ).to_i

    #
    # Calls:
    # http://joyride-hackathon.herokuapp.com/api/1/1/133659891/100641375/1425777628
    # /api/<:device_id>/<:state>/<:lat>/<:long>/<:time>/
    #
    #url = "http://joyride-hackathon.herokuapp.com/api/1/2/#{lat}/#{lng}/#{Time.now.to_i}"
    #url = "http://localhost:3000/api/1/2/#{lat}/#{lng}/#{Time.now.to_i}"
    #response = HTTParty.get(url) unless Rails.env.development?

    #render text: "url:  #{url}"#{}" <br />response: #{response.body}"
    #return

    alert(1, 2, lat_str, lng_str, Time.now.to_i)

    render text: 'ok'
    return
  end

  def clean
    Coord.destroy_all(state: 'alert')

    render text: 'good'
    return
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def api_params
      params[:api]
    end

    def alert(device_id, state_code, lat_str, lng_str, time)
      if Device.exists?(device_id)
        @device = Device.find(device_id)
        if [1,2].map{|i| i.to_s }.include?(state_code.to_s)
          case state_code.to_s
            when 1.to_s
              state = 'journey'
            when 2.to_s
              state = 'alert'
          end

          # store the stuff
          lat = (lat_str.to_f / 1000000.to_f) - 90
          lng = (lng_str.to_f / 1000000.to_f) - 180

          epoch = time

          c = Coord.new(device: @device, state: state, lat: lat, lng: lng, epoch: epoch)
          c.save

          # if this was an alert, send a email or text
          unless @device.user.text_notification.blank?
            # send a message to Twilio (with a google map link?)
            to_number = Rails.env.production? ? '+14164001810' : '+14168418601'

            #https://www.google.ca/maps/search/43.6598912,+-79.3886251/@43.6598912,-79.3886251,17z/data=!3m1!4b1?hl=en
            #https://www.google.ca/maps/search/#{lat},+#{lng}/@#{lat},#{lng},17z/data=!3m1!4b1?hl=en
            url = "https://www.google.ca/maps/search/#{lat},+#{lng}/@#{lat},#{lng},17z/data=!3m1!4b1?hl=en"
            #url = Googl.shorten("https://www.google.ca/maps/search/#{lat},+#{lng}/@#{lat},#{lng},17z/data=!3m1!4b1?hl=en")

            $twilio_client.account.messages.create(
                :from => $twilio_phone_number,
                :to => to_number,
                :body => "Your Joyride has detected unexpected movement. #{Time.now.strftime("%I:%M %P")} \n #{url}"
              )

          end

        end
      end
    end
end
