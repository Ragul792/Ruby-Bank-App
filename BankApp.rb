$userDetails_hsh={}

module Validation
    
    def Validation.isValid(user_ID,user_password)
        return $userDetails_hsh[user_ID].user_password==user_password
    end

    def Validation.validUser(user_ID)
        return $userDetails_hsh.has_key?(user_ID)
    end
end


class UserDetails
    @user_name
    @user_num
    @user_password
    @user_email
    @balance
    

    def initialize(user_name,user_num,user_password,user_email,balance)
        @user_name=user_name
        @user_num=user_num
        @user_password=user_password
        @user_email=user_email
        @balance=balance
    end

    attr_accessor:user_name,:user_num,:user_password,:user_email,:balance

end

class Operations

    def add_User
        print "Enter User Name : "
        user_name=gets.chomp
        print "Enter User Number : "
        user_num=gets.chomp.to_i
        print "Enter User PassWord : "
        user_password=gets.chomp
        print "Enter User E Mail : "
        user_email=gets.chomp
        
        $userDetails_hsh.store(user_num%10000,UserDetails.new(user_name,user_num,user_password,user_email,0))
        puts("*****************    User created Successfully    ********************\n________________    Your User ID is #{user_num%10000}    __________________")

    end

    def check_Balance()

        print("Enter User ID : ")
        user_ID=gets.chomp.to_i
        puts
        print("Enter User PassWord : ")
        user_password=gets.chomp

        if(Validation.validUser(user_ID))

            if(Validation.isValid(user_ID,user_password))
                puts($userDetails_hsh[user_ID].balance)
            else
                puts("-----------------------   Invalid ID/PassWord   -----------------------")
                check_Balance()
            end
        else
            puts("---------------------  No such User ID    ----------------------")
            check_Balance()
        end

    end

    def credit_Amount

        print("Enter ID to Deposit : ")
        user_ID=gets.chomp.to_i

        if(Validation.validUser(user_ID))

            print("Enter Amount to Deposit : ")
            amount=gets.chomp.to_i
            $userDetails_hsh[user_ID].balance=$userDetails_hsh[user_ID].balance+amount
            puts("***************************   Amount Deposited Successfully      ********************************")

        else
            puts("---------------------  No such User ID    ----------------------")
            credit_Amount()
        end

    end

    def debit_Amount

        print("Enter ID to withdraw : ")
        user_ID=gets.chomp.to_i
        puts
        print("Enter PassWord : ")
        user_password=gets.chomp

        if(Validation.validUser(user_ID))

            if(Validation.isValid(user_ID,user_password))
                print("Enter Amount to withdraw : ")
                amount=gets.chomp.to_i
                $userDetails_hsh[user_ID].balance=$userDetails_hsh[user_ID].balance-amount
            else
                puts("--------------------    Invalid ID/Password    ------------------")
                debit_Amount()
            end
        else
            puts("---------------------  No such User ID    ----------------------")
            debit_Amount()
        end

    end

    def transfer_Amount

        print("Enter ID to debit amount : ")
        debit_user=gets.chomp.to_i
        puts
        print("Enter PassWord : ")
        user_password=gets.chomp
        puts

        if(Validation.validUser(debit_user))

            if(Validation.isValid(user_ID,user_password))
                print("Enter Amount to Transfer : ")
                user_Amount=gets.chomp.to_i
                puts
                print("Enter ID to credit amount : ")
                credit_user=gets.chomp.to_i
                puts
                $userDetails_hsh[user_ID].balance=$userDetails_hsh[user_ID].balance+amount
                puts("Amount Deposited Successfully")
            else
                puts("-----------------------   Invalid ID/PassWord   -----------------------")
                transfer_Amount()
            end

        else
            puts("---------------------  No such User ID    ----------------------")
            transfer_Amount()
        end

    end

    def edit_Details

        print("Enter ID : ")
        user_ID=gets.chomp.to_i
        puts
        print("Enter PassWord : ")
        user_password=gets.chomp

        if(Validation.validUser(user_ID))

            if(Validation.isValid(user_ID,user_password))

                while true do
                    puts("Select option\n1.Edit Name\n2.Edit Number\n3.Edit PassWord\n4.Edit E mail\n5.Exit")
                    option=gets.chomp.to_i
                    case option
                    when 1
                        print("Enter New Name : ")
                        new_name=gets.chomp
                        puts
                    when 2
                        print("Enter New Number : ")
                        new_number=gets.chomp.to_i
                        puts
                    when 3
                        print("Enter New PassWord : ")
                        new_password=gets.chomp
                        puts
                    when 4
                        print("Enter New E mail : ")
                        new_email=gets.chomp
                        puts
                    when 5
                        puts("Data Updated successfully")
                        break
                    else
                        puts("----------------------------     Invalid Option    -----------------------")
                    end
                end
            else
                puts("---------------------------     Invalid ID/PassWord    ---------------------------")
                edit_Details()
            end

        else
            puts("---------------------  No such User ID    ----------------------")
            edit_Details()
        end
    end
end

class Main 

    def options_Available

        while true do
            operations_obj=Operations.new
            puts("Select Optioins\n1.Create New Account\n2.Check Balance\n3.Credit Amount\n4.Debit Amount\n5.Transfer Amount\n6.Edit Details\n7.Exit")
            user_option=gets.chomp.to_i


            case user_option
            when 1
                operations_obj.add_User()
            when 2
                operations_obj.check_Balance()
            when 3
                operations_obj.credit_Amount()
            when 4
                operations_obj.debit_Amount()
            when 5
                operations_obj.transfer_Amount()
            when 6
                operations_obj.edit_Details()
            when 7
                puts("###########################   Thanks for Using Service    ########################")
                break
            else
                puts("----------------------    Invalid Option    ----------------------\n----------------------------     Enter Valid Option     ------------------------------------")
            end
        end
    end

end


main_Obj=Main.new
main_Obj.options_Available

