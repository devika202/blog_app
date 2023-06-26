require 'rails_helper'
RSpec.describe ApplicationController, type: :controller do
    describe "before_action" do
      controller do
        def index
          render plain: "Hello, world!"
        end
      end
  
      before do
        routes.draw do
          root "anonymous#index"
        end
      end
  
      describe "#configure_permitted_parameters" do
        
        context "when not in a devise controller" do
          before do
            allow(controller).to receive(:devise_controller?).and_return(false)
          end
  
          it "does not call the devise_parameter_sanitizer" do
            expect(controller).not_to receive(:devise_parameter_sanitizer)
            get :index
          end
        end
      end
  
      describe "#authenticate_user!" do
        context "when accessing a protected action" do
          it "calls authenticate_user!" do
            expect(controller).to receive(:authenticate_user!)
            get :index
          end
        end
  
        context "when accessing a non-protected action" do
          before do
            allow(controller).to receive(:authenticate_user!)
          end
  
          it "does not call authenticate_user!" do
            expect(controller).not_to receive(:authenticate_user!)
          end
        end
      end
    end
  end
  