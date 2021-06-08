require 'pg'
require 'hanami/controller'
require 'json'

module UpdateEmployee
    class UpdateEmployee
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            updateDetails = JSON.parse(response)
            name = updateDetails['profileDetails']['name']
            email = updateDetails['profileDetails']['email']
            password = updateDetails['profileDetails']['password']
            empcode = updateDetails['profileDetails']['empcode']
            address = updateDetails['profileDetails']['address']
            joiningdate = updateDetails['profileDetails']['joiningdate']
            begin
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'ddt9dfacpnfdjs', :user => 'tbtfaavmiyzwen', :password => '0776ec063debd5dde72720dbcd9b2959b370e82944c349a0a53b60a578825d9c'
                exist = con.exec "update employee set name = '#{name}',password = '#{password}',empcode = '#{empcode}',address = '#{address}',joiningdate = '#{joiningdate}' where email = '#{email}'"
                
                    puts "Updated User Details"

                    empDetails = con.exec "select * from employee where email='#{email}'"

                    updated = "true"
                    name = empDetails[0]["name"]
                    email = empDetails[0]["email"]
                    password = empDetails[0]["password"]
                    empcode = empDetails[0]["empcode"]
                    address = empDetails[0]["address"]
                    joiningdate = empDetails[0]["joiningdate"]
                    
                    response = {'updated' => updated, 'name' => name, 'email' => email, 'password' => password, 'empcode' => empcode, 'address' => address, 'joiningdate' => joiningdate}
                    
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