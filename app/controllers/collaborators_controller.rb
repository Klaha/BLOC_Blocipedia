class CollaboratorsController < ApplicationController
  def create
    @collaborator = Collaborator.new(params.require(:collaborator).permit(:user_id, :wiki_id))
    @wiki = @collaborator.wiki
    # @wiki = Wiki.find(params[:collaborator][:wiki_id])

    if @collaborator.save
      flash[:notice] = "Collaborator Added."
      redirect_to edit_wiki_path(@wiki)
    else
      flash[:error] = "There was a problem adding the Collaborator!"
      # redirect_to edit_wiki_path(@wiki)
    end
    
  end

  def destroy
    @collaborator = Collaborator.find(params[:id])
    if @collaborator.destroy
      flash[:notice] = "Collaborator Removed."
      redirect_to :back
    else
      flash[:error] = "There was a problem removing the Collaborator!"
      redirect_to :back
    end
  end
end