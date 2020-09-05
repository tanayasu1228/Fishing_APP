ActiveAdmin.register User do
permit_params :email, :encrypted_password, :nickname, :image, :main_field, :main_target, :max_size, :comment
end
