class RevisionsController < ApplicationController
#  before_action :set_revision, only: [:show, :edit, :update, :destroy]
  before_action only: [:show, :edit, :update, :destroy]

  # GET /revisions
  # GET /revisions.json
  def index
#    @revisions = Revision.all.order(:part_id, :nro)

    #####
    #1st you retrieve the part thanks to params[:post_id]
    part = Part.find(params[:part_id])
    #2nd you get all the revisions of this post
    @revisions = part.revisions

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @revisions }
    end
    #####
    
  end

  # GET /revisions/1
  # GET /revisions/1.json
  def show
    
    #####
    #1st you retrieve the part thanks to params[:post_id]
    part = Part.find(params[:part_id])
    #2nd you retrieve the revision thanks to params[:id]
    @revision = part.revisions.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @revision }
    end
    #####
    
  end

  # GET /revisions/new
  def new
#    @revision = Revision.new
    #####
    #1st you retrieve the post thanks to params[:post_id]
    part = Part.find(params[:part_id])
    #2nd you build a new one
    @revision = part.revisions.build
    
    @revision.autor = current_user.login

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @revision }
    end
    #####
    
  end

  # GET /revisions/1/edit
  def edit
    
    #####
    #1st you retrieve the post thanks to params[:post_id]
    part = Part.find(params[:part_id])
    #2nd you retrieve the revision thanks to params[:id]
    @revision = part.revisions.find(params[:id])
    #####
    
  end

  # POST /revisions
  # POST /revisions.json
  def create
#    @revision = Revision.new(revision_params)
#    
#    @revision.nro = Revision.where(part_id: @revision.part_id).maximum(:nro)
#    if @revision.nro.nil?
#      @revision.nro = 1
#    else  
#      @revision.nro = @revision.nro + 1
#    end

#    respond_to do |format|
#      if @revision.save
#        format.html { redirect_to @revision, notice: 'Revision was successfully created.' }
#        format.json { render :show, status: :created, location: @revision }
#      else
#        format.html { render :new }
#        format.json { render json: @revision.errors, status: :unprocessable_entity }
#      end
#    end

    #####
    #1st you retrieve the post thanks to params[:post_id]
    part = Part.find(params[:part_id])
    #2nd you create the revision with arguments in params[:revision]
    @revision = part.revisions.create(revision_params)

    @revision.nro = Revision.where(part_id: @revision.part_id).maximum(:nro)
    if @revision.nro.nil?
      @revision.nro = 1
    else  
      @revision.nro = @revision.nro + 1
    end


    respond_to do |format|
      if @revision.save
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource revision
        #format.html { redirect_to([@revision.part, @revision], :notice => 'Revision was successfully created.') }
        format.html { redirect_to(part_revisions_url, :notice => 'Revision was successfully created.') }
        #the key :location is associated to an array in order to build the correct route to the nested resource revision
        format.xml  { render :xml => @revision, :status => :created, :location => [@revision.part, @revision] }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @revision.errors, :status => :unprocessable_entity }
      end
    end
    #####
    
  end

  # PATCH/PUT /revisions/1
  # PATCH/PUT /revisions/1.json
  def update
#    respond_to do |format|
#      if @revision.update(revision_params)
#        format.html { redirect_to @revision, notice: 'Revision was successfully updated.' }
#        format.json { render :show, status: :ok, location: @revision }
#      else
#        format.html { render :edit }
#        format.json { render json: @revision.errors, status: :unprocessable_entity }
#      end
#    end
    
    #####
    #1st you retrieve the part thanks to params[:part_id]
    part = Part.find(params[:part_id])
    #2nd you retrieve the revision thanks to params[:id]
    @revision = part.revisions.find(params[:id])
    # Update all other revisions of this part to state
    part.revisions.update_all(:state_id => 3)
    respond_to do |format|
      if @revision.update_attributes(revision_params)
        #1st argument of redirect_to is an array, in order to build the correct route to the nested resource revision
        #format.html { redirect_to([@revision.part, @revision], :notice => 'Revision was successfully updated.') }
        format.html { redirect_to(part_revisions_url, :notice => 'Revision was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @revision.errors, :status => :unprocessable_entity }
      end
    end
    #####
    
  end

  # DELETE /revisions/1
  # DELETE /revisions/1.json
  def destroy
#    @revision.destroy
#    respond_to do |format|
#      format.html { redirect_to revisions_url, notice: 'Revision was successfully destroyed.' }
#      format.json { head :no_content }
#    end
    
    #####
    #1st you retrieve the part thanks to params[:part_id]
    part = Part.find(params[:part_id])
    #2nd you retrieve the revision thanks to params[:id]
    @revision = part.revisions.find(params[:id])
    @revision.destroy

    respond_to do |format|
      #1st argument reference the path /parts/:part_id/revisions/
      format.html { redirect_to(part_revisions_url, notice: 'Revision was successfully destroyed.') }
      format.xml  { head :ok }
    end
    #####
    
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_revision
      @revision = Revision.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def revision_params
      params.require(:revision).permit(:autor, :nro, :fecha, :state_id, :part_id)
    end
end
