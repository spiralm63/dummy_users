
#homepage
get '/' do
  # Look in app/views/index.erb
  erb :index
end



#link from index.erb
get '/user-login' do

  erb :login
end




#comes from login.erb form
post '/login' do

  email = params[:email]
  password = params[:password]

  @user = User.find_by_email(email: email)
  @authenticated_user = @user.authenticate(email, password)

  if @authenticated_user
    session[:user_id] = @authenticated_user.id
    erb :profile
  else
    erb :index
  end
end


#comes from index.erb form

post '/create' do 

  email = params[:email]
  password = params[:password]

  @user = User.create(email: email, password: password)

  session[:user_id] = @user.id


  erb :profile
end
