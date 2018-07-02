class PostsController < ApplicationController
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # naver api map
  def map
  end

  # 요청 반환
  def map_data
    # rails에서 json string => Hash처럼 사용할 수 있게 변환
    max = JSON.parse(params[:max])
    min = JSON.parse(params[:min])
    indices = JSON.parse(params[:indices]) #기존에 load된 학교 id값이 들어 있다.
    # @school = School.all.limit(1000)

    #위도 경도의 size의 따라 표현이 다르게,, SQL문과 동일
    school = School.where("(lat BETWEEN ? and ?) and (lng BETWEEN ? and ?)", min["_lat"],max["_lat"], min["_lng"], max["_lng"])
    # id만 추출
    school_id = school.map{|x| x.id} #ruby에서의 map과 JS의 map은 같다
    school_id -= indices # 기존에 load되지 않는 학교 id만 저장
    if school_id.length == 0
      school = []
    else
      #school_id에 존재하는 학교들만 school에 저장
      school = school.select{|x| school_id.include? x.id}#python : |x| x in school_id
    end

    respond_to do |format|
      format.json{render json: [school,school_id]}
    end
  end

  # GET /posts
  # GET /posts.json
  def index
    @posts = Post.all
    @post = Post.new
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    # @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)

    respond_to do |format|
      if @post.save
        format.html { redirect_to '/posts', notice: 'Post was successfully created.' }
        format.json { render :show, status: :created, location: @post }
        # JS 요청시 format.js로 하기
        format.js {}
      else
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to @post, notice: 'Post was successfully updated.' }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to posts_url, notice: 'Post was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
      params.require(:post).permit(:title, :content)
    end
end
