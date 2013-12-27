#!/usr/bin/ruby

require 'sinatra'
require 'sinatra/reloader' if development?
require 'sass'
require 'slim'

require './hangmangame'

configure do
#  enable :sessions

  use Rack::Session::Cookie,
      expire_after: 300,          # Five minute game should cover it.
      secret:       'JGNHangman'  # Finally, an actual secret
end

get( '/styles/webgame.css' ) { scss :styles }

get '/' do
  @phase = -1

  if session[:playing].nil?
    session[:playing] = false
    session[:game]    = HangmanGame.new :release  # Don't load the whole word list
  end

  if session[:playing]
    @game     = session[:game]
    @word     = @game.word_as_dashes
    @phase    = @game.bad_count
    @letters  = Array('A'..'Z') - @game.used
    @solved   = @game.solved?
    @hung     = @game.hung?
  end

  slim :index
end

get '/start' do
  session[:playing] = true

  session[:game] ||= HangmanGame.new :release  # Don't load the whole word list
  session[:game].new_game

  redirect to( '/' )
end

get '/letter/:let' do
  session[:game].process_letter params[:let]
  redirect to( '/' )
end

# Shouldn't be necessary any more...

get '/reset' do
  session[:playing] = nil
  redirect to( '/' )
end
