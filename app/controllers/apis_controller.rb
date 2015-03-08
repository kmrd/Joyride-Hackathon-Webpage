require 'twilio-ruby'

class ApisController < ApplicationController
#  before_action :set_api, only: [:show, :edit, :update, :destroy]
  skip_before_action :verify_authenticity_token


  def report
    # API call: /api/:device_id/:state/:lat/:long/:time/
    if Device.exists?(params[:device_id])
      @device = Device.find(params[:device_id])
      if [1,2].map{ |i| i.to_s }.include?(params[:state])
        case params[:state]
          when 1.to_s
            state = 'journey'
          when 2.to_s
            state = 'alert'
        end

        # store the stuff
        lat = (params[:lat].to_f / 1000000.to_f) - 90
        lng = (params[:lng].to_f / 1000000.to_f) - 180

        epoch = params[:time]

        c = Coord.new(device: @device, state: state, lat: lat, lng: lng, epoch: epoch)
        c.save if Rails.env.production?

        # if this was an alert, send a email or text
        unless @device.user.text_notification.blank?
          # send a message to Twilio (with a google map link?)
          to_number = Rails.env.production? ? '+14164001810' : '+14168418601'

          url = Googl.shorten("https://www.google.ca/maps/search/#{lat},+#{lng}/@#{lat},#{lng},17z/data=!3m1!4b1?hl=en")

          $twilio_client.account.messages.create(
              :from => $twilio_phone_number,
              :to => to_number,
              :body => "Your Joyride has detected unexpected movement. #{Time.now.strftime("%I:%M %P")} \n #{url.short_url}"
            )

            #https://www.google.ca/maps/search/43.6598912,+-79.3886251/@43.6598912,-79.3886251,17z/data=!3m1!4b1?hl=en
            #https://www.google.ca/maps/search/#{lat},+#{lng}/@#{lat},#{lng},17z/data=!3m1!4b1?hl=en

        end

      end
    end

    render :nothing => true, :status => 200, :content_type => 'text/html'
  end

  def go
    #joyride-hackathon.herokuapp.com/api/1/1/133659891/100641375/1425777628
    #/api/:device_id/:state/:lat/:long/:time/


    render text: 'good'
    return
  end

  def clean
    Coord.all.destroy

    render text: 'good'
    return
  end

  private
    # Never trust parameters from the scary internet, only allow the white list through.
    def api_params
      params[:api]
    end
end
