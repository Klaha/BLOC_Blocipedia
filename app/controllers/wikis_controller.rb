class WikisController < ApplicationController

  def index

    @wikis = policy_scope(Wiki.by_title)

    # @wikis = Wiki.all
    # @publicwikis = Wiki.where(:private => [nil, false])    
    # @privatewikis = Wiki.where('private == ?', true)
    # @collabwikis = Array.new

    # @privatewikis.each do |privatewiki|
    #   if privatewiki.users.where('user_id == ?', current_user).exists?
    #     @collabwikis.push(privatewiki)
    #   end 
    # end

    # authorize @wikis


  end

  def new
    @wiki = Wiki.new
    authorize @wiki
  end

  def create
    @user = current_user
    @wiki = Wiki.new(wiki_params)
    authorize @wiki

    if @wiki.save
      flash[:notice] = "Wiki was Created."
      redirect_to @wiki
    else
      flash[:error] = "There was a problem creating the Wiki. Try again!"
      render :new
    end

    create_collaboration(@user.id, @wiki.id)
  end

  def show
    @wiki = Wiki.find(params[:id])
    authorize @wiki
  end

  def edit
    @wiki = Wiki.find(params[:id])
    authorize @wiki
    @collaborators = Collaborator.where('wiki_id == ?', @wiki.id)
    # @collaborators = @wiki.users
    @newcollaborator = Collaborator.new
  end

  def update
    @wiki = Wiki.find(params[:id])
    authorize @wiki

    if @wiki.update_attributes(wiki_params)
      flash[:notice] = "Wiki was updated."
      redirect_to @wiki
    else
      flash[:error] = "There was an error updating the Wiki. Please try again."
      render :edit
    end
  end

  def destroy
    @wiki = Wiki.find(params[:id])
    title = @wiki.title
    authorize @wiki

    if @wiki.destroy
      flash[:notice] = "\"#{title}\" was deleted successfully."
      redirect_to wikis_path
    else
      flash[:error] = "There was an error deleting the Wiki. Please try again."
      render :show
    end
  end

  private

  def wiki_params
    params.require(:wiki).permit(:title, :body, :private)
  end

  def create_collaboration(user_id, wiki_id)
    @collab = Collaborator.new
    @collab.user_id = user_id
    @collab.wiki_id = wiki_id
    @collab.save
  end

end
