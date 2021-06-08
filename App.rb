require 'hanami/router'
 
class App
  def self.router
    Hanami::Router.new do
      post '/Create', to: CreateEmployee::CreateEmployee
      post '/Login', to: Login::Login
      post '/Delete', to: DeleteEmployee::DeleteEmployee
      post '/Update', to: UpdateEmployee::UpdateEmployee
    end
  end
end
 