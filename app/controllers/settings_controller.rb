class SettingsController < ApplicationController
    
        def index
        end

        def post
            render layout: "post"
        end


        def other_comment
            redirect_to :action => 'other_comment'
        end

end
