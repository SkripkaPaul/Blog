#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'



def db_init
	@db = SQLite3::Database.new 'blog.db'
	@db.results_as_hash = true
end

before do
	db_init
end

get '/' do
	erb "Hello!!! <a href=\"https://github.com/bootstrap-ruby/sinatra-bootstrap\">Original</a> pattern has been modified for <a href=\"http://rubyschool.us/\">Ruby School</a>"			
end


get '/new' do
	erb :new
end

post '/new' do
	@post = params[:post]

	erb "You tiped #{@post}"	
end
