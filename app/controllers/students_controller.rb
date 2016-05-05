class StudentsController < ApplicationController
  before_action :set_student, only: [:show, :edit, :update, :destroy]

  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    @hours = {}
    @total_fee = 0

    @month = Time.now.month
    @year = Time.now.year
    @day = Time.now.day


  # Student.first.hours.where("date_part('month', created_at) = 5 AND date_part('year', created_at) = 2016").order("created_at DESC")
    @year = params[:year] if (params[:year])
    @month = params[:month] if (params[:month])
    @day = params[:day] if (params[:day])

    @students.each do |s|
      hours_count = s.hours.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('day', created_at AT TIME ZONE 'Canada/Eastern') <= ?", @month, @year, @day).sum(:count)
      @hours[s.id] = hours_count
      @total_fee += hours_count * s.fee
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  # GET /students/new
  def new
    @student = Student.new
  end

  # GET /students/1/edit
  def edit
  end

  def add_hour
    @student = Student.find(params[:student_id])
    @hour = @student.hours.new(:count => params[:count])

    respond_to do |format|
      if @hour.save
        format.html { redirect_to action: "index", notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end


  end

  # POST /students
  # POST /students.json
  def create
    @student = Student.new(student_params)

    respond_to do |format|
      if @student.save
        format.html { redirect_to @student, notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /students/1
  # PATCH/PUT /students/1.json
  def update
    respond_to do |format|
      if @student.update(student_params)
        format.html { redirect_to @student, notice: 'Student was successfully updated.' }
        format.json { render :show, status: :ok, location: @student }
      else
        format.html { render :edit }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /students/1
  # DELETE /students/1.json
  def destroy
    @student.destroy
    respond_to do |format|
      format.html { redirect_to students_url, notice: 'Student was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_student
      @student = Student.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def student_params
      params.require(:student).permit(:name, :fee)
    end
end
