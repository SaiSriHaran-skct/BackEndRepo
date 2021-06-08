require 'pg'
require 'hanami/controller'
require 'json'

module CreateEmployee
    class CreateEmployee
        include ::Hanami::Action
        def call (env)
            response = request.body.read
            create = JSON.parse(response)
            name = create['create']['name']
            email = create['create']['email']
            password = create['create']['password']
            empcode = create['create']['emp_code']
            address = create['create']['address']
            joiningdate = create['create']['join_date']
            begin
                con = PG.connect :host => 'ec2-35-169-188-58.compute-1.amazonaws.com', :dbname => 'ddt9dfacpnfdjs', :user => 'tbtfaavmiyzwen', :password => '0776ec063debd5dde72720dbcd9b2959b370e82944c349a0a53b60a578825d9c'
                
                existingUser = con.exec "select exists (select * from employee where email='#{email}')"
                puts existingUser
                if existingUser[0]["exists"]==='f' 
                    exist = con.exec "INSERT INTO employee values ('#{name}', '#{email}', '#{password}', '#{empcode}', '#{address}', '#{joiningdate}')"
                    puts "Emp Added"
                    result = "Account Created"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                else 
                    result = "Existing User"
                    response = {'result' => result}
                    
                    puts response
                    res = JSON.generate(response)

                    self.body = res
                end  
            
            rescue PG::Error => e
            
                puts e.message 

                puts "Emp Not Added"
                
            ensure
            
                con.close if con
                
            end
        end
    end
end 
