class TextthreadController < ApplicationController
  def show
    @thread = Textthread.find(params[:id])
  end
end
