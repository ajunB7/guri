class ExtrafeesController < ApplicationController
  before_action :set_extrafees
  before_action :set_extrafee, only: [:show, :edit, :update, :destroy]

  # GET students/1/extrafees
  def index
    @extrafees = @student.extrafees
    redirect_to students_path
  end

  # GET students/1/extrafees/1
  def show
  end

  # GET students/1/extrafees/new
  def new
    @extrafee = @student.extrafees.build
  end

  # GET students/1/extrafees/1/edit
  def edit
  end

  # POST students/1/extrafees
  def create
    @extrafee = @student.extrafees.build(extrafee_params)

    if @extrafee.save
      redirect_to(students_path, notice: 'Extrafee was successfully created.')
    else
      render action: 'new'
    end
  end

  # PUT students/1/extrafees/1
  def update
    if @extrafee.update_attributes(extrafee_params)
      redirect_to(students_path, notice: 'Extrafee was successfully updated.')
    else
      render action: 'edit'
    end
  end

  # DELETE students/1/extrafees/1
  def destroy
    @extrafee.destroy

    redirect_to students_path
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_extrafees
      @student = Student.find(params[:student_id])
    end

    def set_extrafee
      @extrafee = @student.extrafees.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def extrafee_params
      params.require(:extrafee).permit(:name, :price)
    end
end
