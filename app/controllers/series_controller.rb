class SeriesController < ApplicationController
  # GET /series
  # GET /series.xml
  def index
    @series = Series.all

    respond_to do |format|
      format.html # index.html.erb
      format.xml  { render :xml => @series }
    end
  end

  # GET /series/1
  # GET /series/1.xml
  def show
    @series = Series.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.xml  { render :xml => @series }
    end
  end

  # GET /series/new
  # GET /series/new.xml
  def new
    @series = Series.new

    respond_to do |format|
      format.html # new.html.erb
      format.xml  { render :xml => @series }
    end
  end

  # GET /series/1/edit
  def edit
    @series = Series.find(params[:id])
  end

  # POST /series
  # POST /series.xml
  def create
    @series = Series.new(params[:series])

    respond_to do |format|
      if @series.save
        format.html { redirect_to(@series, :notice => 'Series was successfully created.') }
        format.xml  { render :xml => @series, :status => :created, :location => @series }
      else
        format.html { render :action => "new" }
        format.xml  { render :xml => @series.errors, :status => :unprocessable_entity }
      end
    end
  end

  # PUT /series/1
  # PUT /series/1.xml
  def update
    @series = Series.find(params[:id])

    respond_to do |format|
      if @series.update_attributes(params[:series])
        format.html { redirect_to(@series, :notice => 'Series was successfully updated.') }
        format.xml  { head :ok }
      else
        format.html { render :action => "edit" }
        format.xml  { render :xml => @series.errors, :status => :unprocessable_entity }
      end
    end
  end

  # DELETE /series/1
  # DELETE /series/1.xml
  def destroy
    @series = Series.find(params[:id])
    @series.destroy

    respond_to do |format|
      format.html { redirect_to(series_index_url) }
      format.xml  { head :ok }
    end
  end

  def episodes
    @series = Series.find(params[:id])

    e = Episode.arel_table
    episode_count = e.group(e[:series_id]).project(e[:series_id], e[:episode_no].count(e[:series_id]).as('episode_count'))

    #@episode_counts = @series.episodes
  end
end
