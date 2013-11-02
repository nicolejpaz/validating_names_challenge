require 'sinatra/flash'

get '/' do
  @events = Event.all
  erb :index
end

get '/events/:id/show' do |id|
  @event = Event.find(id)
  erb :event_show
end

get '/events/new' do
  erb :event_add
end

post '/events/create' do
  @event = Event.create(organizer_name: params[:organizer_name], organizer_email: params[:organizer_email], title: params[:title], date: params[:date])
  unless @event.errors.empty?
    # @event.errors.clear
    # p @event.errors
    # flash[:error] = @event.errors[:messages]
    @error = @event.errors.full_messages
    p @error
    erb :event_add
  else
    redirect '/'
  end
end
