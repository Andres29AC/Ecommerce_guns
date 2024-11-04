require 'net/http'
class FetchCountryService
  attr_reader :ip
  def initialize(ip)
    #Declaramos una variable de instancia
    @ip = ip
  end
  def perform
    sleep 60
    uri = URI("http://ip-api.com/json/#{ip}")
    response = Net::HTTP.get(uri)
    parsed_response = JSON.parse(response)
    #pp parsed_response
    status = parsed_response.dig("status")
    if status == "fail"
      country_code = parsed_response.dig("countryCode").downcase
      country_code
    else
      nil
    end
  rescue
    nil
  end
end

# Base de datos: tienda_development


# Para tareas pesadas o tareas que no sabemos cuanto va a tardaren responder
# Se utiliza un background job para que no afecte la respuesta del servidor
# rails g job fetch_country
# bundle add sidekiq
