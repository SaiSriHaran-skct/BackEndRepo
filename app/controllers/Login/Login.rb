require 'pg'
require 'hanami/controller'
require 'json'

module Login
    class Login
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            logincred = JSON.parse(response)
            email = logincred['logincred']['email']
            password = logincred['logincred']['password']
            
            begin
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'ddt9dfacpnfdjs', :user => 'tbtfaavmiyzwen', :password => '0776ec063debd5dde72720dbcd9b2959b370e82944c349a0a53b60a578825d9c'
                exist = con.exec "select exists (select * from employee where email='#{email}' and password='#{password}')"

                if exist[0]["exists"]=='t' 
                    puts "Existing User"

                    empDetails = con.exec "select * from employee where email='#{email}' and password='#{password}'"

                    validation = "true"
                    name = empDetails[0]["name"]
                    email = empDetails[0]["email"]
                    password = empDetails[0]["password"]
                    empcode = empDetails[0]["empcode"]
                    address = empDetails[0]["address"]
                    joiningdate = empDetails[0]["joiningdate"]
                    
                    response = {'validation' => validation, 'name' => name, 'email' => email, 'password' => password, 'empcode' => empcode, 'address' => address, 'joiningdate' => joiningdate}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else
                    puts "Wrong User Details"
                    validation = "false"
                                      
                    response = {'validation' => validation}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end
                
            
            rescue PG::Error => e
            
                puts e.message 
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 
