class TreatmentsController < ApplicationController
  before_action :set_patient
  before_action :set_treatment, only: [:show, :update, :destroy]

  # GET /treatments
  def index
    @treatments = @patient.treatments

    render json: @treatments
  end

  # GET /treatments/1
  def show
    render json: @treatment
  end

  # POST /treatments
  def create
    @treatment = @patient.treatments.new(treatment_params)

    if @treatment.save
      render json: @treatment, status: :created, location: @treatment
    else
      render json: @treatment.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /treatments/1
  def update
    if @treatment.update(treatment_params)
      render json: @treatment
    else
      render json: @treatment.errors, status: :unprocessable_entity
    end
  end

  # DELETE /treatments/1
  def destroy
    @treatment.destroy
  end

  private
    def set_patient
      @patient = Patient.find(params[:patient_id])
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_treatment
      @treatment = @patient.treatments.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def treatment_params
      params.require(:treatment).permit(:patient_id, :medication_id, :dosage, :start_date, :end_date)
    end
end
