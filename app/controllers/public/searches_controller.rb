class Public::SearchesController < ApplicationController
  skip_before_action :authenticate_user!
  
  def search
    @model = params[:model]
    @content = params[:content]
    @method = params[:method]

    if @model  == "salon"
      @records = Salon.search_for(@content, @method)
    else
      @records = User.search_for(@content, @method)
    end
  end
end
