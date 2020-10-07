ActiveAdmin.register Tournament do
permit_params :start_time, :end_time, :fishing_ground, :fishing_style, :condition, :fish_name, :keeper_size, :some_fish, :comment
end
