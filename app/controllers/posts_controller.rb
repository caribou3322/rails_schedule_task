class PostsController < ApplicationController
    before_action :set_post, only: %i[show edit update destroy]

    def index
        @posts = Post.all.order(start_date: :asc)
    end

    def show
    end

    def new
        @post = Post.new
    end

    def create
        @post = Post.new(post_params)
        if @post.save
            redirect_to posts_path, notice: "スケジュールを登録しました。"
        else
            flash.now[:alert] = "スケジュールの登録に失敗しました。"
            render :new, status: :unprocessable_entity
        end
    end

    def edit
    end

    def update
        if @post.update(post_params)
            redirect_to posts_path, notice: "スケジュールを更新しました。"
        else
            flash.now[:alert] = "スケジュールの更新に失敗しました。"
            render :edit, status: :unprocessable_entity
        end
    end

    def destroy
        @post.destroy
        redirect_to posts_path, notice: "スケジュールを削除しました。", status: :see_other
    end

    private

    def set_post
        @post = post.find(params[:id])
    end

    def post_params
        params.require(:post).permit(:title, :body, :start_date, :end_date, :all_day)
    end
end
