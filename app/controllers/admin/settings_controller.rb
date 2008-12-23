class Admin::SettingsController < ApplicationController
  require_role :admin
  layout 'admin'
      
  # GET /admin/settings
  # GET /admin/settings.xml
  def index
    @settings = Setting.find(:all)
    @db_settings_identifiers = @settings.map { |s| s.identifier }

    # get the standard settings as defined in config/config.yml
    @yml_settings = configatron.to_hash
    #configatron.to_hash.each_key do |key|
  	#  @yml_settings << Setting.load(key)
  	#end

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @settings }
    end
  end

  # GET /admin/settings/1
  # GET /admin/settings/1.xml
  def show
    @setting = Setting.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /admin/settings/new
  # GET /admin/settings/new.xml
  def new
    @setting = Setting.new()
    if params[:identifier]
      @setting.label = params[:identifier].humanize
      @setting.identifier = params[:identifier]
    end
    @setting.value = params[:value] if params[:value]
    
    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @setting }
    end
  end

  # GET /admin/settings/1/edit
  def edit
    @setting = Setting.find(params[:id])
  end

  # POST /admin/settings
  # POST /admin/settings.xml
  def create
    @setting = Setting.new(params[:setting])

    respond_to do |format|
      if @setting.save
        flash[:notice] = 'Setting was successfully created.'
        format.html { redirect_to(admin_setting_path(@setting)) }
        format.xml  { render :xml => @setting, :status => :created, :location => @setting }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /admin/settings/1
  # PUT /admin/settings/1.xml
  def update
    @setting = Setting.find(params[:id])

    respond_to do |format|
      if @setting.update_attributes(params[:setting])
        flash[:notice] = 'Setting.was successfully updated.'
        format.html { redirect_to(admin_setting_path(@setting)) }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @setting.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /admin/settings/1
  # DELETE /admin/settings/1.xml
  def destroy
    @setting = Setting.find(params[:id])
    @setting.destroy

    respond_to do |format|
      format.html { redirect_to(admin_settings_url) }
      format.xml  { head :ok }
    end
  end
  
  private
  
end