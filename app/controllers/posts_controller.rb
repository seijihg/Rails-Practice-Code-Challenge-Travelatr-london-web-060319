class PostsController < ApplicationController
    def index
        @posts = Post.all
    end
    def new
        @post = Post.new
    end
    def create
        post = Post.create(params_post(:title, :content, :blogger_id, :destination_id))
        if post.valid?
            redirect_to post
        else
            flash[:errors] = post.errors.full_messages
            redirect_to new_post_path
        end
    end
    def add
        post = Post.find(params[:id])
        post.likes += 1
        post.save
        redirect_to post_path(post)
    end
    def show
        @post = Post.find(params[:id])
    end

    private
    def params_post(*args)
        params.require(:post).permit(*args)
    end
end