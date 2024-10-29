module Oodle
  class ItemsController < ApplicationController
    before_action :set_item, only: %i[ show edit update destroy ]

    # GET /items
    def index
      @groups = [ "all" ].concat Item.all.map(&:group).uniq
      if params[:sorted].eql?("all") || params[:sorted].blank?
        @items = Item.all
      else
        @items = Item.where(group: params[:sorted])
      end
      @pagy, @items = pagy(@items)
    end

    # GET /items/1
    def show
    end

    # GET /items/new
    def new
      @item = Item.new
    end

    # GET /items/1/edit
    def edit
    end

    # POST /items
    def create
      @item = Item.new(item_params)

      if @item.save
        redirect_to @item, notice: "Item was successfully created."
      else
        render :new, status: :unprocessable_entity
      end
    end

    # PATCH/PUT /items/1
    def update
      if @item.update(item_params)
        redirect_to @item, notice: "Item was successfully updated.", status: :see_other
      else
        render :edit, status: :unprocessable_entity
      end
    end

    # DELETE /items/1
    def destroy
      if @item.used?
        flash[:notice] = "You cannot delete an item that is used in a question."
      else
        @item.destroy!
        flash[:notice] = "Item was successfully destroyed."
      end

      redirect_to items_path
    end

    private
      # Use callbacks to share common setup or constraints between actions.
      def set_item
        @item = Item.find(params.expect(:id))
      end

      # Only allow a list of trusted parameters through.
      def item_params
        params.expect(item: [ :name, :description, :group, :score, :display_value, :correct_value ])
      end
  end
end
