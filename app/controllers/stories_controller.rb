class StoriesController < ApplicationController
  before_action :set_story, only: [:show, :edit, :update, :destroy]

  respond_to :html

  def generate
    number = rand(10 ** 6)
    a = Account.create(uid: number)
    render json: a.uid
  end
  helper_method :generate

  def index
    @stories = Story.all.where(was_checked: true)
    respond_with(@stories)
  end

  def show
    respond_with(@story)
  end

  def new
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
    end

    def story_params
      params[:story]
    end
end
