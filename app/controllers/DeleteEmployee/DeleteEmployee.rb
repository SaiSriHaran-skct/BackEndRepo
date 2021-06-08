require 'pg'
require 'hanami/controller'
require 'json'

module DeleteEmployee
    class DeleteEmployee
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            puts response
            deleteProfileDetails = JSON.parse(response)
            email = deleteProfileDetails['userDetails']['email']
            puts email
            
            begin
                
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'ddt9dfacpnfdjs', :user => 'tbtfaavmiyzwen', :password => '0776ec063debd5dde72720dbcd9b2959b370e82944c349a0a53b60a578825d9c'
                exist = con.exec "DELETE FROM employee where email = '#{email}'"
                
                    puts "Profile Is Deleted"

                    deleted = "true"
                                        
                    response = {'deleted' => deleted}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res              
                
            
            rescue PG::Error => e
            
                puts e.message 

                    updated = "false"
                                      
                    response = {'updated' => updated}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 
