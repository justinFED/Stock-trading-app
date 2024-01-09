FactoryBot.define do
    factory :user do
        first_name { 'John' }
        last_name { 'Doe' }
        email { 'john@doe.com' }
        password { 'password' }
        role { 'trader' }
        status { 'pending' }

        factory :admin_user do
            role { 'admin' }
        end

        factory :approved_trader do
            status { 'approved' }
        end
    end
end
