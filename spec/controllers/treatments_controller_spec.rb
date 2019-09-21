require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.
#
# Also compared to earlier versions of this generator, there are no longer any
# expectations of assigns and templates rendered. These features have been
# removed from Rails core in Rails 5, but can be added back in via the
# `rails-controller-testing` gem.

RSpec.describe TreatmentsController, type: :controller do

  # This should return the minimal set of attributes required to create a valid
  # Treatment. As you add validations to Treatment, be sure to
  # adjust the attributes here as well.
  let!(:patient) { Patient.create( first_name: 'foo', last_name: 'bar', email: 'foo@example.net') }
  let!(:medication) { Medication.create( medication_name: 'biz', manufacturer: 'baz') }
  let(:treatment_attributes) {
    {
      patient_id: patient.id,
      medication_id: medication.id,
      dosage: "100mL / hour",
      start_date: "2019-04-01T00:00:00Z",
      end_date: nil
    }
  }

  let(:valid_attributes) {
    {
      patient_id: patient.id,
      treatment: treatment_attributes.reject { |k,v| k == :patient_id }
    }
  }

  let(:invalid_attributes) {
    {
      patient_id: patient.id,
      treatment: treatment_attributes.merge(medication_id: nil).reject { |k,v| k == :patient_id }
    }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # TreatmentsController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "returns a success response" do
      treatment = Treatment.create! treatment_attributes
      get :index, params: { patient_id: patient.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "GET #show" do
    it "returns a success response" do
      treatment = Treatment.create! treatment_attributes
      get :show, params: {id: treatment.to_param, patient_id: patient.id }, session: valid_session
      expect(response).to be_successful
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new Treatment" do
        expect {
          post :create, params: valid_attributes, session: valid_session
        }.to change(Treatment, :count).by(1)
      end

      it "renders a JSON response with the new treatment" do

        post :create, params: valid_attributes, session: valid_session
        expect(response).to have_http_status(:created)
        expect(response.content_type).to eq('application/json')
        expect(response.location).to eq(treatment_url(Treatment.last))
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the new treatment" do

        post :create, params: invalid_attributes, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { end_date: Time.now.iso8601 }
      }

      it "updates the requested treatment" do
        treatment = Treatment.create! treatment_attributes
        expect(treatment.end_date).to_not be
        put :update, params: {id: treatment.to_param, treatment: new_attributes, patient_id: patient.id}, session: valid_session
        treatment.reload
        expect(treatment.end_date).to be
      end

      it "renders a JSON response with the treatment" do
        treatment = Treatment.create! treatment_attributes

        put :update, params: {id: treatment.to_param, treatment: valid_attributes[:treatment], patient_id: patient.id}, session: valid_session
        expect(response).to have_http_status(:ok)
        expect(response.content_type).to eq('application/json')
      end
    end

    context "with invalid params" do
      it "renders a JSON response with errors for the treatment" do
        treatment = Treatment.create! treatment_attributes

        put :update, params: {id: treatment.to_param, treatment: invalid_attributes[:treatment], patient_id: patient.id}, session: valid_session
        expect(response).to have_http_status(:unprocessable_entity)
        expect(response.content_type).to eq('application/json')
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested treatment" do
      treatment = Treatment.create! treatment_attributes
      expect {
        delete :destroy, params: {id: treatment.to_param, patient_id: patient.id}, session: valid_session
      }.to change(Treatment, :count).by(-1)
    end
  end

end
