class ApplicationController < ActionController::Base
    include Pagy::Backend
    around_action :switch_locale

    def switch_locale(&action)
        I18n.with_locale(locale_from_header, &action)
    end
    private
    def locale_from_header
        #if request.env['HTTP_ACCEPT_LANGUAGE']
        #    request.env['HTTP_ACCEPT_LANGUAGE'].scan(/^[a-z]{2}/)
        #end
        request.env['HTTP_ACCEPT_LANGUAGE']&.scan(/^[a-z]{2}/)&.first
    end
end

