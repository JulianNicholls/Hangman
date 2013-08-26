require 'sinatra'
require 'sinatra/reloader' if development?
require 'mongoid'
require 'sass'        # Suggested as a security improvement
require 'slim'

require './hangmangame'

configure do

    enable :sessions
    
end


get( '/styles/webgame.css' ) { scss :styles }

get '/' do
  @phase = session[:phase]

  if @phase.nil?
    @phase = -1
    session[:phase] = -1
  end
  
  slim :index
end


get '/start' do
  session[:phase] = 0
  session[:game] = HangmanGame.new
  redirect to( '/' )
end
  

post '/reset' do
  session[:phase] = -1
  redirect to( '/' )
end

post '/test' do
  session[:phase] += 1
  redirect to( '/' )
end
