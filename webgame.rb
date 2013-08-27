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
    session[:game]  = HangmanGame.new
  end
  
  if @phase > -1
    game = session[:game]
    @word     = game.word_as_dashes
    @bad      = game.bad
    @phase    = game.bad_count
    @letters  = Array('A'..'Z') - game.used
    @solved   = game.solved?
    @hung     = game.hung?
  end
  
  slim :index
end


get '/start' do
  session[:phase] = 0
  session[:game].new_game
  redirect to( '/' )
end
  

get '/reset' do
  session[:phase] = -1
  session[:game]  = HangmanGame.new
  redirect to( '/' )
end


get '/letter/:let' do
  session[:game].process_letter params[:let]
  redirect to( '/' )
end
  