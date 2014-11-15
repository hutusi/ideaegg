class IdeasController < ApplicationController
  def index
  end

  def new
    @idea = Idea.new
  end
end
