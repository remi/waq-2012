configure do
  DataMapper::Logger.new STDOUT, :debug
  DataMapper.setup :default, "mysql://localhost/blogue"

  class Article
    include DataMapper::Resource
    property :id, Serial
    property :title, String
    property :content, Text
    property :created_at, DateTime
  end

  DataMapper.finalize
  DataMapper.auto_upgrade!
end

get "/" do
  @articles = Article.all
  haml :index, :layout => :blogue
end

get "/articles/:id" do
  @article = Article.get(params[:id])
  haml :show, :layout => :blogue
end

post "/articles" do
  @article = Article.create(params[:article])
  redirect to("/article/#{@article.id}")
end
