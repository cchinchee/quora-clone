enable :sessions
get '/' do
  erb :"static/index"
end

post'/sign_up' do 
	
	@user = User.new(name: params[:name], email: params[:email], password: params[:password])
	
	if @user.save
		session[:user_id] = @user.id
		redirect("/users/#{@user.id}")
	else
		
		@message = "Sign up invalid!! Please try again.."
		erb :"static/index"
	end 
end 

post '/users' do 
	
	@user = User.find_by(email: params[:email])
	if @user != nil && @user.authenticate(params[:password])
		session[:user_id] = @user.id

		redirect("/users/#{@user.id}")
	else
		erb :"static/error"
	end 
end


get '/users/:user_id' do
	
	if current_user

		@user=User.find( params[:user_id])

		if params["name"] 
			friend = User.find_by(name: params["name"])
			if friend
				redirect "/users/#{friend.id}"
			else
				@message = "User not found"
			end
		end
		erb :"static/users"
	else
		redirect "/"
	end
	
end 

post '/sign_out' do

	sign_out
	redirect '/'
end 


post '/question' do
	@question=Question.new(title: params[:title], description: params[:description], user_id: current_user.id)
	@question.save

	current_user
	redirect("/users/#{@current_user.id}/questions")
	# redirect("/users/#{session[:user_id]}")
end


get '/users/:id/questions' do

	if logged_in?
		@user=User.find(params[:id])
		erb :"static/question/questions"
	end 
end 

get '/question/new' do

	if logged_in?
		erb :'/static/question/create_questions'
	end
end 

get '/questions/:id' do
	if logged_in?
		@question = Question.find(params[:id])


		erb :'/static/question/one_question'
	end 
end 

get '/users/:id/answers' do
	if logged_in?
		@answer = Answer.where(user_id:params[:id])
		erb :'/static/answer/answers'
	end 
end 

post '/questions/:id/answers' do
	if logged_in?
		@answer=current_user.answers.new(description: params[:description], question_id: params[:id])
		@answer.save

		redirect"/questions/#{params[:id]}"
	end 
end 

get '/questions/:id/edit' do
	if logged_in?
		@question = Question.find(params[:id])
		erb :"static/question/question_edit"
	end 
end 

post '/questions/:id' do
	if logged_in?
		@question = Question.find(params[:id])
		@question.update(title: params[:title], description: params[:description])
		
		redirect "/questions/#{@question.id}"
		
	end 
end 


get '/answers/:id/edit' do  
	if logged_in?
		@answer = Answer.find(params[:id])
		erb :'/static/answer/answer_edit'
	end 
end 

post '/answers/:id' do
	if logged_in?
		@answer = Answer.find(params[:id])
		@answer.update(description: params[:description])
		
		redirect "/questions/#{@answer.question_id}" 
	end 
end 

post '/questions/:id/destroy' do
	if logged_in?
		@question = Question.find(params[:id])
		@question.destroy
		
		redirect "/users/#{current_user.id}/questions"
		
	end 
end 

post '/answers/:id/destroy' do
	if logged_in?
		@answer = Answer.find(params[:id])
		@answer.destroy
		
		redirect "/questions/#{@answer.question.id}"
		
	end 
end 

post '/answers/:id/votes' do
	if logged_in?
		@votes=Vote.new(count: params[:count],answer_id: params[:id],user_id: current_user.id)
		@votes.save
		{count: @votes[:count]}.to_json	
		# @answer = Answer.find(params[:id])
		# redirect "/questions/#{@answer.question.id}"
	end
end 


'/questions/:id'

post '/:id/votes/destroy' do
	if logged_in?
		@votes=Vote.find_by(answer_id: params[:id], user_id: current_user.id)
		@votes.destroy
		
		@answer = Answer.find(params[:id])
		redirect "/questions/#{@answer.question.id}"
	end
end 