class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def slider
    @stories = Story.all.where(was_checked: true)
  end

  def generate
    number = rand(10 ** 6)

    existing = Account.where(uid: number)
    if existing.first == nil
      a = Account.create(uid: number)
      return a.uid
    else
      generate
    end
  end

  def index
    if params[:search]
      @stories = Story.search(params[:search]).where(was_checked: true).order("created_at DESC")
    else
      @stories = Story.all.where(was_checked: true)
      # @stories = Story.all.where(was_checked: true)
      respond_with(@stories)
    end

  end

  def show
    if @story.was_checked == false
      redirect_to thankyou_path
    else
      @stories = Story.all.where(was_checked: true)
      respond_with(@story)
    end
  end

  def new
    @personal_code = generate
    @story = Story.new
    respond_with(@story)
  end

  def edit

  end

  def create
    @story = Story.new(story_params)
    @story.save
    respond_with(@story)
  end

  def update
    @story.update(story_params)
    respond_with(@story)
  end

  def destroy
    @story.destroy
    respond_with(@story)
  end

  private
    def set_story
      @story = Story.find(params[:id])
      @recordings = Recording.where(story_id: params[:id])
    end

    def story_params
      accessible = [ :name, :gender, :contact, :breakup_role, :notes, :person, :age, :location, :was_checked, :selected_recording_id] # extend with your own params
      params.require(:story).permit(accessible)
    end
end
