# ======= ======= ======= SETUP ======= ======= =======
# ======= ======= ======= SETUP ======= ======= =======
# ======= ======= ======= SETUP ======= ======= =======

# ======= requires =======
require "sinatra"
require "sinatra/reloader"
require 'sinatra/activerecord'

# ======= models =======
require './models'

# ======= database =======
set :database, "sqlite3:user_db.db"		# set "user_db" to YOUR database name

# ======= sessions =======
enable :sessions

# ======= ======= ======= ROUTER ======= ======= =======
# ======= ======= ======= ROUTER ======= ======= =======
# ======= ======= ======= ROUTER ======= ======= =======

# ======= edit userDB =======
get '/edit_user_form' do
	puts "\n******* /edit_user_form *******"
	puts "params: #{params.inspect}"
	@user = User.find(params[:id])      # ==== finding if the username entered matches a username in the db
	puts "@user: #{@user.inspect}"
	erb :edit_user_form
end

get '/update_user' do
	puts "\n******* /update_user *******"
	puts "params: #{params.inspect}"
	User.find(params[:id]).update_attributes(
  	username: params[:username],
    password: params[:password],
    firstname: params[:firstname],
    lastname: params[:lastname],
    email: params[:email],
		usertype: params[:usertype]
  )
	@user = User.find(params[:id])      # ==== finding if the username entered matches a username in the db
	erb :profile
end

# ======= delete user =======
get '/delete_user' do
	puts "\n******* GET: delete_user *******"
	puts "params: #{params.inspect}"
	@user = User.find(params[:id])      # ==== finding if the username entered matches a username in the db
	puts "@user: #{@user.inspect}"
	erb :delete_user
end

post '/delete_user' do
	puts "\n******* POST: delete_user *******"
	puts "params: #{params.inspect}"
	User.find(params[:id]).destroy
	@users = User.all
	erb :userslist
end



# ======= default =======
get '/' do
	puts "\n******* / *******"
	erb :home
end


# ======= home =======
get '/home' do
	puts "\n******* home *******"
	erb :home
end

# ======= signin_form =======
get '/signin_form' do
	puts "\n******* signin_form *******"
	erb :signin_form
end

# ======= signin =======
post '/signin' do
	puts "\n******* POST: signin *******"
	puts "params: #{params.inspect}"
	@user = User.where(:username => params[:username]).first      # ==== finding if the username entered matches a username in the db
	puts "@user: #{@user.inspect}"
	if @user
		if params[:password] == @user[:password]
			session[:user_id] = @user[:id]
			puts "session[:user_id]: #{session[:user_id].inspect}"
			erb :profile
		else
			erb :signin_form
		end
	else
			erb :signup_form
  end
end

# ======= signout =======
get '/signout' do
	puts "\n******* Get: signout *******"
	erb :home
end

# ======= signup_form =======
get '/signup_form' do
	puts "\n******* signup_form *******"
	erb :signup_form
end

# ======= signup =======

post '/signup' do
	puts "\n******* POST: signup *******"
	puts "params: #{params.inspect}"
	# puts "params[:username].inspect: #{params[:username].inspect}"
	# puts "params[:password].inspect: #{params[:password].inspect}"

  User.create(
  	username: params[:username],
    password: params[:password],
    firstname: params[:firstname],
    lastname: params[:lastname],
    email: params[:email],
		usertype: params[:usertype]
		# created_at: DateTime.new
  )
	@user = User.order("created_at").last
	# puts "\n******* User Order *******"
  erb :profile
end

get '/userslist' do
	puts "\n******* Userslist *******"
	puts "params: #{params.inspect}"
	@users = User.all
	erb :userslist
end


get "/profile" do
	puts "\n******* GET: profile:ID *******"
	puts "params: #{params.inspect}"
	@user = User.find(params[:id])
	erb :profile
end

get "/blog" do
	puts "\n******* GET: blog:ID *******"
	puts "params: #{params.inspect}"
	@user = User.find(params[:id])
	erb :blog
end

post '/blog' do
	puts "\n******* post: blog *******"
	puts "params: #{params.inspect}"
	puts "session[:user_id]: #{session[:user_id].inspect}"
	@user = User.find(session[:user_id])
	puts "@user: #{@user.inspect}"
	Question.create(
		question: params[:question],
		user_id: session[:user_id]
	)
	@questions = Question.all
	puts "@questions: #{@questions.inspect}"
	erb :blog
end


# get "/profile" do
# 	puts "\n******* GET: profile *******"
# 	puts "params: #{params.inspect}"
# 	if @user
# 		if params[:password] == @user[:password]
# 			session[:user_id] = @user[:id]
# 			puts "session[:user_id]: #{session[:user_id].inspect}"
# 			erb :profile
# 		else
# 			erb :signin_form
# 		end
# 	else
# 			erb :signup_form
#   end
# 	erb :blog
# end
#
# post '/signup' do
# 	puts "\n******* POST: signup *******"
#   puts "params: #{params.inspect}"
#   User.create(params)
#   @user = User.order("created_at").last
#   erb :profile
# end
