class ArticlesController < ApplicationController
  def index
    render json: Article.all.order(:id).map, &:resource
  end

  def show
    render json: Article.find(params[:id]).resource
  end

  def create
    @article = Article.new(article_params)

    if @article.save
      render json: @article.resource, status: :created
    else
      render_error_json(@article.errors.messages.keys, @article.errors.messages.values.flatten, :unprocessable_entity)
    end
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      render json: @article.resource
    else
      render_error_json(@article.errors.messages.keys, @article.errors.messages.values.flatten, :unprocessable_entity)
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    render json: {message: "deleted."}
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
