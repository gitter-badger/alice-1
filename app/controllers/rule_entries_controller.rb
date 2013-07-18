class RuleEntriesController < ApplicationController
  # GET /rule_entries
  # GET /rule_entries.json
  def index
    @title = t('actions.listing') + " " + t('activerecord.models.rule_entries')

    @rule = Rule.find(params[:rule_id])    
    @rule_entries = @rule.rule_entries
    @licenses = License.search(params[:license_name], params[:page])

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @rule_entries }
    end
  end

  # GET /rule_entries/1
  # GET /rule_entries/1.json
  def show
    @rule_entry = RuleEntry.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @rule_entry }
    end
  end

  # GET /rule_entries/new
  # GET /rule_entries/new.json
  def new
    @rule_entry = RuleEntry.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @rule_entry }
    end
  end

  # GET /rule_entries/1/edit
  def edit
    @rule_entry = RuleEntry.find(params[:id])
  end

  # POST /rule_entries
  # POST /rule_entries.json
  def create
    @rule_entry = RuleEntry.new(params[:rule_entry])

    respond_to do |format|
      if @rule_entry.save
        format.html { redirect_to @rule_entry, notice: 'Rule entry was successfully created.' }
        format.json { render json: @rule_entry, status: :created, location: @rule_entry }
      else
        format.html { render action: "new" }
        format.json { render json: @rule_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /rule_entries/1
  # PUT /rule_entries/1.json
  def update
    @rule_entry = RuleEntry.find(params[:id])

    respond_to do |format|
      if @rule_entry.update_attributes(params[:rule_entry])
        format.html { redirect_to @rule_entry, notice: 'Rule entry was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: "edit" }
        format.json { render json: @rule_entry.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /rule_entries/1
  # DELETE /rule_entries/1.json
  def destroy
    @rule_entry = RuleEntry.find(params[:id])
    @rule_entry.destroy

    respond_to do |format|
      format.html { redirect_to rule_entries_url }
      format.json { head :no_content }
    end
  end
end