class PostsController < ApplicationController
  #시작 전에 method를 호출하기 위해서, 쓰고 싶을 때 호출하는 것은 따로 before_action을 안 줘도 된다.
  before_action :authenticate_user!, except: :index
  before_action :set_post, only: [:show, :edit, :update, :destroy]
  def index
    @posts = Post.all
  end

  def new
    # form_for을 사용해서 rendering을 하기 위해 필요
    @post = Post.new
  end

  def create
    # 이렇게 validation을 controller에서 하게 된다면 무거워진다. --> 안 좋은 코드
    # controller는 무조건 slim 해줘야 한다.
    # if params[:title].nil? or params[:content].nil?
    #   flash[:alert] = "빈 칸을 채워주세요"
    #   redirct_to :back
    # else
    #   @post = current_user.posts.new(post_params)
    #   @post.save
    #   redirect_to "/"
    # end
    @post = current_user.posts.new(post_params)

    # 응답을 설정 가능 (문장을 줄일 수 있다.)
    respond_to do |format|
      #return이 boolean
      if @post.save
        #flash[:notice] = "글 작성이 완료되었습니다."
        format.html{ redirect_to "/", notice: "글 작성 완료!"}
        #rendering을 index page로 하면 @post가 없기 때문에 error
      else
        #저장 실패
        #flash[:alert] = "글 작성이 실패되었습니다."
        # rails ver5 부터는 :back이 사라졌음
        #redirect_to new_post_path

        # new action rendering, redirect_to로 하면 값이 날아가는데
        # rendering은 value도 가지고 있기 때문에 실행 과정들을 다 가지고 있다.
        format.html{render :new} #이미 써져 있는 값은 기록되어야 하기 떄문.
        format.json{render json: @post.errors}
      end
    end
  end

  def show
    @comments = @post.comments
  end

  def edit
  end

  def update
    @post.update(post_params)
    redirect_to "/posts/#{@post.id}"
  end

  def destroy
    @post.destroy
    redirct_to "/"
  end

  private
    def set_post
      @post = Post.find(params[:id])
    end

    def post_params
      #params.permit(:title, :content)

      # form_for로 hash안에 있는 것을 사용할 때 사용(이중 hash를 사용하기 때문)
      # @post가 비어있는 경우 create로 보내고, 값이 있는 경우 update로 보낸다.
      params.require(:post).permit(:title, :content)
    end
end
