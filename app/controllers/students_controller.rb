class StudentsController < ApplicationController
  before_filter :authenticate
  before_action :set_student, only: [:show, :edit, :update, :destroy]


  # GET /students
  # GET /students.json
  def index
    @students = Student.all
    @hours = {}
    @today_hours = {}
    @total_today_hours = 0
    @total_fee = 0
    @total_today_fee = 0
    @total_hours = 0
    @months_days = 0
    @paidfees = {}
    @student_extra = {}

    @month = Time.now.month
    @year = Time.now.year
    @day = Time.now.day


  # Student.first.hours.where("date_part('month', created_at) = 5 AND date_part('year', created_at) = 2016").order("created_at DESC")
    @year = params[:year] if (params[:year])
    @month = params[:month] if (params[:month])

    common_days = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    @months_days = 29 if @month == 2 && Date.gregorian_leap?(@year)
    @months_days = common_days[@month.to_i]

    if params[:day]
      @day = params[:day]
      @day = @months_days if (@day.to_i > @months_days)
    end

    @students.each do |s|
      s_hours = s.hours.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year)
      hours_count = s_hours.sum(:count)
      hours_today_count = s_hours.where("date_part('day', created_at AT TIME ZONE 'Canada/Eastern') = ?", @day).sum(:count)

      s_paidfees = s.paidfees.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year).first
      unless s_paidfees.nil?
        @paidfees[s.id] = true
      end

      extras = s.extrafees.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year).sum(:price)
      @student_extra[s.id] = extras

      @today_hours[s.id] = hours_today_count
      @total_today_hours += hours_today_count
      @hours[s.id] = hours_count
      @total_hours += hours_count
      @total_fee += hours_count * s.fee + extras
      @total_today_fee += hours_today_count * s.fee
    end
  end

  # GET /students/1
  # GET /students/1.json
  def show
  end

  def show_summary
    @month = params[:month].to_i
    @year = params[:year].to_i

    common_days = [nil, 31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
    @months_days = 29 if @month == 2 && Date.gregorian_leap?(@year)
    @months_days = common_days[@month.to_i]

    @students = Student.all
    @hours = {}

    @students.each do |s|
      s_hours = s.hours.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year)
      s_hours.each do |hr|
        @hours[s.id] ||= {}
        @hours[s.id][hr.created_at.day] = hr.count
        @hours[s.id][:total] ||= 0
        @hours[s.id][:total] += hr.count
      end
    end

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

    @month = Time.now.month
    @day = Time.now.day
    @year = Time.now.year

    if (params[:month] and params[:day] and params[:year])
      @month = params[:month]
      @day = params[:day]
      @year = params[:year]

      # Make it at 15 pm just to be safe (UTC conversion)
      date = "#{@month}/#{@day}/#{@year} 15:0:0"
      @create_date = DateTime.strptime(date, "%m/%d/%Y %H:%M:%S")
    end

    student_history = @student.hours.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('day', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year, @day)
     if student_history.empty?
      @hour = @student.hours.new(:count => params[:count])
    else
      @hour = student_history.first
      @hour.update_attributes(:count => @hour.count + 1)
    end

    if @hour.save
      if (@create_date)
        @hour.update_attributes(:created_at => @create_date)
        params = {:year => @year, :month => @month, :day => @day}
        end
    else
      @error = "Failed To add Hour!"
    end
  end

  # POST /students
  # POST /students.json
  def create
  @student = Student.new(student_params)

   respond_to do |format|
      if @student.save
        format.html { redirect_to action: "index", notice: 'Student was successfully created.' }
        format.json { render :show, status: :created, location: @student }
      else
        format.html { render :new }
        format.json { render json: @student.errors, status: :unprocessable_entity }
      end
    end
  end

  def paid_money
    @student = Student.find(params[:student_id])
    @month = params[:month].to_i
    @year = params[:year].to_i

    if (params[:month] and params[:year])
      @month = params[:month]
      day = 1
      @year = params[:year]

      # Make it at 15 pm just to be safe (UTC conversion)
      date = "#{@month}/#{day}/#{@year} 15:0:0"
      @create_date = DateTime.strptime(date, "%m/%d/%Y %H:%M:%S")
    end

    fee = @student.paidfees.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year)

    if fee.empty?
      s = @student.paidfees.create
      s.update_attributes(:created_at => @create_date)
    else
      # Do nothing
    end
  end

  def unpaid_money
    @student = Student.find(params[:student_id])
    @month = params[:month].to_i
    @year = params[:year].to_i

    fee = @student.paidfees.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ?", @month, @year)
    unless fee.empty?
      fee.first.destroy
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

  def delete_hour
    if params[:hour_id]
      @hour = Hour.find(params[:hour_id])
    elsif params[:student_id]
      @student = Student.find(params[:student_id])
      if (params[:year] && params[:month] && params[:day])
        @month = params[:month].to_i
        @year = params[:year].to_i
        @day = params[:day].to_i
        @hour = @student.hours.where("date_part('month', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('year', created_at AT TIME ZONE 'Canada/Eastern') = ? AND date_part('day', created_at AT TIME ZONE 'Canada/Eastern') = ?", params[:month], params[:year], params[:day]).first
      else
        @hour = @student.hours.last
      end
    end

    unless @hour.nil?
      @hour.destroy
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

  protected
  def authenticate
    authenticate_or_request_with_http_basic do |username, password|
      username == "gurvinder" && password == "gurvinder"
    end
  end
end
