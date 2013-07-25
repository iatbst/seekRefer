class CompaniesController < ApplicationController
  
  #new company 
  def new 
    
  end
  
  #create a new company
  def create
    @company = Company.new(company_params)
    @company.save
    redirect_to @company
  end
  
  #show company info
  def show
    @company = Company.find(params[:id])
    @users = User.all(:conditions => "company = '#{@company.name}'")
  end
  
  #list all company
  def index
    @companies = Company.all
  end 
  
  #edit a company
  def edit
    @company = Company.find(params[:id])
  end
  
  #update a company
  def update
    @company = Company.find(params[:id])
 
    if @company.update(company_params)
      redirect_to @company
    else
      render 'edit'
    end
  end
 
  def destroy
    @company = Company.find(params[:id])
    @company.destroy
 
    redirect_to companies_path
  end
  
  private 
    def company_params
      params.require(:company).permit(:name, :description, :website, :logo)
    end
  
end
