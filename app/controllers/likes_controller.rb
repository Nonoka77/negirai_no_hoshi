class LikesController < ApplicationController
before_action :post_params, only: %i[create destroy]
    def create
        like = current_user.likes.create(post_id: @post.id)
    end

    def destroy
        like = Like.find_by(post_id: @post.id, user_id: current_user.id)
        like.destroy
    end

    private
    
    def post_params
        @post = Post.find(params[:post_id])
    end
end
