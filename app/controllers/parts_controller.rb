class PartsController < ApplicationController
  before_action :set_part, only: [:show, :edit, :update, :destroy]

  ## http://blog.8thcolor.com/en/2011/08/nested-resources-with-independent-views-in-ruby-on-rails/

  # GET /parts
  # GET /parts.json
  def index
#    @parts = Part.all.order(:leter , :nro)
#    @parts = Part.paginate(:page => params[:page])
    @q = Part.search(params[:q])
    @parts = @q.result(distinct: true)
    @parts = @parts.order(:leter , :nro)
#    @parts = @q.result.includes(:revisions)
#    @revisions = Revision.all

    # @articles = @search.relation # Retrieve the relation, to lazy-load in view
    # @articles = @search.paginate(:page => params[:page]) # Who doesn't love will_paginate?
    
  end

  # GET /parts/1
  # GET /parts/1.json
  def show
  end

  # GET /parts/new
  def new
    @part = Part.new
    @part.leter = 'A'
    
    @part.nro = Part.maximum(:nro)
    if @part.nro.nil?
      @part.nro = 1
      @part.nro = @part.nro.to_s.rjust(7, '0')
    else  
      @part.nro = Part.maximum(:nro) + 1
      @part.nro = @part.nro.to_s.rjust(7, '0')
    end
    
#    @part.nro = Part.maximum(:nro) + 1
#    @part.nro = @part.nro.to_s.rjust(7, '0')
  end

  # GET /parts/1/edit
  def edit
    @part.nro = @part.nro.to_s.rjust(7, '0')
  end

  # POST /parts
  # POST /parts.json
  def create
    @part = Part.new(part_params)

    respond_to do |format|
      if @part.save
        #format.html { redirect_to @part, notice: 'Part was successfully created.' }
        format.html { redirect_to parts_url, notice: 'Part was successfully created.' }
        format.json { render :show, status: :created, location: @part }
      else
        format.html { render :new }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /parts/1
  # PATCH/PUT /parts/1.json
  def update
    respond_to do |format|
      if @part.update(part_params)
        #format.html { redirect_to @part, notice: 'Part was successfully updated.' }
        format.html { redirect_to parts_url, notice: 'Part was successfully updated.' }
        format.json { render :show, status: :ok, location: @part }
      else
        format.html { render :edit }
        format.json { render json: @part.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /parts/1
  # DELETE /parts/1.json
  def destroy
    @part.destroy
    respond_to do |format|
      format.html { redirect_to parts_url, notice: 'Part was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_part
      @part = Part.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def part_params
      params.require(:part).permit(:leter, :nro, :title, :reference, :model_id)
    end
end
