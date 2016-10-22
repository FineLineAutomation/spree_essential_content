require 'spec_helper'
require 'rack/test'

require 'pry'

describe Spree::Admin::UploadsController, type: :controller do
  stub_authorization!

  describe 'GET #index' do
    let(:ability_user) { stub_model(Spree::LegacyUser, :has_spree_role? => true) }

    before :each do
      @testupload = create(:upload)
      @testupload2 = create(:upload, :png)

      spree_get :index
    end

    it "populates an array of all uploads for a products master variant" do
      #binding.pry
      expect(assigns(:uploads)).to match_array([@testupload, @testupload2])
    end

    it "renders the :index view" do
      expect(response).to render_template :index
    end
  end

  describe 'GET #new' do
    before :each do
      spree_get :new
    end

    it "assigns a new upload to @upload" do
      expect(assigns(:upload)).to be_a_new(Spree::Upload)
    end

    it "renders the :new template" do
      expect(response).to render_template :new
    end
  end

  describe 'GET #edit' do
    before :each do
      @upload = create(:upload)
      spree_get :edit, id: @upload.id
    end

    it "assigns the requested upload to @upload" do
      expect(assigns(:upload)).to eq(@upload)
    end

    it "renders the :edit template" do
      expect(response).to render_template :edit
    end
  end

  describe 'post #create' do
    context "with valid attributes" do
      before :each do
        @upload_attributes = attributes_for(:upload)
        @upload_attributes[:attachment] = Rack::Test::UploadedFile.new(File.expand_path("../../../factories/1.jpg", __FILE__), 'image/jpg')
      end

      it "save the new upload in the database" do
        expect {
          spree_post :create, upload: @upload_attributes
        }.to change(Spree::Upload, :count).by(1)
      end

      it "renders with no layout" do
        spree_post :create, upload: @upload_attributes
        assert_template layout: false
      end
    end

    context "with invalid attributes" do
      it "does not save the new upload in the database" do
        expect {
          spree_post :create, upload: attributes_for(:invalid_upload)
        }.to_not change(Spree::Upload, :count)
      end

      it "re-renders the :new template" do
        spree_post :create, upload: attributes_for(:invalid_upload)
        expect(response).to render_template :new
      end
    end
  end

  # describe 'PUT #update' do
  #   before :each do
  #     @variant = create(:variant)
  #     @upload = create(:upload, :assembly => @product.master)
  #   end

  #   context "with valid attributes" do
  #     it "locates the requested @upload" do
  #       @upload_attributes = attributes_for(:upload).merge(upload_variant_id: @variant.id)
  #       spree_put :update, id: @upload, upload: @upload_attributes, product_id: @product.permalink
  #       expect(assigns(:upload)).to eq(@upload)
  #     end

  #     it "updates the upload in the database" do
  #       spree_put :update, id: @upload, upload: attributes_for(:upload, :count => 2).merge(upload_variant_id: @variant.id), product_id: @product.permalink
  #       @upload.reload
  #       expect(@upload.count).to eq(2)
  #       expect(@upload.upload_variant).to eq(@variant)
  #     end

  #     it "renders no layout" do
  #       spree_put :update, id: @upload, upload: attributes_for(:upload, :count => 2).merge(upload_variant_id: @variant.id), product_id: @product.permalink
  #       expect(@templates.keys).to eq([])
  #     end
  #   end

  #   context "with invalid attributes" do
  #     it "does not update the new upload in the database" do
  #       spree_put :update, id: @upload, upload: attributes_for(:invalid_upload).merge(upload_variant_id: @variant.id), product_id: @product.permalink
  #       @upload.reload
  #       expect(@upload.count).to eq(1)
  #       expect(@upload.upload_variant).to_not eq(@variant_id)
  #     end

  #     it "re-renders the :edit template" do
  #       spree_put :update, id: @upload, upload: attributes_for(:invalid_upload).merge(upload_variant_id: @variant.id), product_id: @product.permalink
  #       expect(response).to render_template :edit
  #     end
  #   end
  # end

  describe 'DELETE destroy' do
    before :each do
      @upload = create(:upload)
    end

    it "deletes the upload from the database" do
      expect {
        spree_delete :destroy, id: @upload
      }.to change(Spree::Upload, :count).by(-1)
    end

    it "renders no layout" do
      spree_delete :destroy, id: @upload
      assert_template layout: false
    end
  end
end
