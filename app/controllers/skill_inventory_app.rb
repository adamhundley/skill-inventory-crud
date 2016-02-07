class SkillInventoryApp < Sinatra::Base
  get '/' do
    erb :dashboard
  end

  get '/skills' do
    @skills = skill_inventory.all
    @categories = category_inventory.all
    # require "pry"; binding.pry
    erb :index
  end

  get '/new' do
    redirect '/skills/new'
  end

  get '/skills/new' do
    if @categories.nil?
      @categories = category_inventory.all
    else
      category_inventory.create(category_name: "School")
      category_inventory.create(category_name: "Church")
      category_inventory.create(category_name: "Life")
      category_inventory.create(category_name: "Fun")
      @categories = category_inventory.all
    end
    erb :new_skill
  end

  post '/skills' do
    skill_inventory.create(params[:skill])
    redirect '/skills'
  end

  get '/skills/:id' do |id|
    @skill = skill_inventory.find(id.to_i)
    @categories = category_inventory.all
    erb :show
  end

  get "/skills/:id/edit" do |id|
    @skill = skill_inventory.find(id.to_i)
    @categories = category_inventory.all
    erb :edit
  end

  put "/skills/:id" do |id|
    skill_inventory.update(params[:skill], id.to_i)
    redirect "/skills"
  end

  delete "/skills/:id" do |id|
    skill_inventory.delete(id.to_i)
    redirect "/skills"
  end

  not_found do
    erb :error
  end

  def skill_inventory
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite("db/skill_inventory_test.sqlite3")
    else
      database = Sequel.sqlite("db/skill_inventory_development.sqlite3")
    end
    @skill_inventory ||= SkillInventory.new(database)
  end

  def category_inventory
    if ENV["RACK_ENV"] == "test"
      database = Sequel.sqlite("db/skill_inventory_test.sqlite3")
    else
      database = Sequel.sqlite("db/skill_inventory_development.sqlite3")
    end
    @category_inventory ||= CategoryInventory.new(database)
  end

end
