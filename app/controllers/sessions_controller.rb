class SessionsController < ApplicationController

  def new  
    redirect_to devices_path unless current_user.nil?
  end

#  def facebook
#    redirect_to '/auth/facebook'
#  end
  
#  def omniauth_endpoint
#    auth = request.env["omniauth.auth"]
#    user = User.where(:provider => auth['provider'],
#                      :uid => auth['uid'].to_s).first || User.create_with_omniauth(auth)
#    reset_session
#    log_in user 
#    #session[:user_id] = user.id
#
#    flash[:info] = 'Signed in!'
#
#    redirect_to root_url
#  end

#  def failure
#    redirect_to root_url, :alert => "Authentication error: #{params[:message].humanize}"
#  end

#  def destroy
#    reset_session
#    redirect_to root_url, :info => 'Signed out!'
#  end
#

  def create
    user = User.find_by(email: params[:session][:email].downcase)#, provider: nil)

    if user #&& user.authenticate(params[:session][:password])

      log_in user

#      if user.activated?
#        params[:session][:remember_me] == '1' ? remember(user) : forget(user)
#      else
#        message  = "Account not activated. "
#        message += "Check your email for the activation link."
#        flash[:warning] = message
#      end
      
      if request.xhr?
        render :text => '1'
      else
        redirect_back_or devices_path
      end

      return
    else
      flash.now[:danger] = 'Invalid email/password combination'

      if params[:session][:email]
        u = User.find_by(email: params[:session][:email])
      end

      if request.xhr?
        render partial: 'sessions/login_form', flash: flash
      else
        render 'new'
      end

      return
    end

    render 'new'
  end


  def destroy
    log_out if logged_in?
    last_location = request.referrer
    reset_session
    flash[:info] = 'You have been signed out.'
    redirect_to last_location || root_url
  end


end
