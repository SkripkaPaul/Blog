#encoding: utf-8
require 'rubygems'
require 'sinatra'
require 'sinatra/reloader'
require 'sqlite3'



def init_db
	@db = SQLite3::Database.new 'blog.db'
	@db.results_as_hash = true
end

before do
	init_db
end

configure do
	init_db
	@db.execute 'CREATE TABLE IF NOT EXISTS Posts 
		(
			"id" INTEGER PRIMARY KEY AUTOINCREMENT,
			created_date DATE,
			content TEXT
			)'
end 

get '/' do
	
	@result = @db.execute 'select * from posts order by id desc'

	erb :index
end


get '/new' do
	erb :new
end

post '/new' do
	@content = params[:post]

	if @content.length <= 0
		@error = 'Please type text'
		return erb :new
	end

	@db.execute 'insert into Posts (content, created_date) values (?, datetime ())', [@content]

	erb "You tiped #{@content}"	
end
