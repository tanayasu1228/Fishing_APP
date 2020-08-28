ActiveAdmin.register Tournament do
permit_params :date, :fishing_ground, :fishing_style, :condition, :fish_name, :keeper_size, :some_fish, :comment
end
