class PostsController < ApplicationController
    before_action :authenticate_user!   
                    # , only: [:new, :create, :edit, :update]を使用して限定もできる！

    def index
        if params[:search] == nil
            @posts = Post.all.page(params[:page]).per(10).order(created_at: :desc)
        elsif params[:search] == ""
            @posts = Post.all.page(params[:page]).per(10).order(created_at: :desc) #desc:降順、asc:昇順
        else
            @posts = Post.where("body || title || who LIKE ? ", "%" + params[:search] + "%").page(params[:page]).per(10).order(created_at: :desc)
        end

        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)

    end

    def new
        @post = Post.new
    end

    def create
        post = Post.new(post_params)
        url = params[:post][:youtube_url]
        url = url.last(11)
        post.youtube_url = url
        post.user_id = current_user.id
        if post.save
            redirect_to :action => "index"
        else
            redirect_to :action => "new"
        end
    end

    def books
        @posts = Post.where(jenre: "書籍").page(params[:page]).per(5).order(created_at: :desc)

        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
    end

    def videos
        @posts = Post.where(jenre: "動画").page(params[:page]).per(5).order(created_at: :desc)

        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
    end

    def comics
        @posts = Post.where(jenre: "漫画").page(params[:page]).per(5).order(created_at: :desc)

        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
    end

    def words
        @posts = Post.where(jenre: "名言").page(params[:page]).per(5).order(created_at: :desc)

        @rank_posts = Post.all.sort {|a,b| b.liked_users.count <=> a.liked_users.count}.first(5)
    end

    def show
        @post = Post.find(params[:id])
        @comments = @post.comments
        @comment = Comment.new
    end

    def edit
        @post = Post.find(params[:id])
    end

    def update
        post = Post.find(params[:id])
        if post.update(post_params)
            redirect_to :action => "index"
            # redirect_to :action => "show", :id => post.id もOK！
        else
            redirect_to :action => "edit"
        end
    end

    def destroy
        post = Post.find(params[:id])
        post.destroy
        redirect_to :action => "index"
    end

    private
    def post_params
        params.require(:post).permit(:body, :image, :video, :youtube_url, :jenre, :title, :who, :published_year)
    end 

end