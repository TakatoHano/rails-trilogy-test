class CommentsController < ApplicationController
  
    def index
      @article = Article.find(params[:article_id])
      @comments = @article.comments.all.order(:id).map &:resource
      render json: {
        article: @article.title, 
        comments: @comments,
      }
    end
  
    def create
      @article = Article.find(params[:article_id])
      @comment = @article.comments.create(comment_params)
      render json: {article: @article.title, comment: @comment.resource }, status: :created
    end

    def destroy
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
      @comment.destroy
      render json: {message: "deleted."}
    end

    private
      def comment_params
        params.require(:comment).permit(:commenter, :body, :status)
      end
  end
  