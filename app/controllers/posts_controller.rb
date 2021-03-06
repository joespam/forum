class PostsController < ApplicationController

	before_action :find_post, only: [:show,:edit,:update,:destroy]
	before_action :authenticate_user!, except: [:index,:show]

	def create
		@post = current_user.posts.build(post_params)
		if @post.save
			redirect_to @post
		else
			render 'new'
		end
	end
	
	def destroy
		destroy @post
		redirect_to	root_path
	end

	def edit
	end
	
	def index
		@posts = Post.all.order("created_at DESC")
	end

	def new
		@post = current_user.posts.build
	end
	
	def show
	end

	def update
		if @post.update(post_params)
			redirect_to @post
		else
			render 'edit'
		end
	end

	private

	def post_params
		params.require(:post).permit(:title, :content)
	end

	def find_post
		@post = Post.find(params[:id])
	end

end
